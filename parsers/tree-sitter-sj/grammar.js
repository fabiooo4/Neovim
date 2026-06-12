module.exports = grammar({
  name: 'sj',

  extras: $ => [
    /\s/,
    $.comment,
  ],

  conflicts: $ => [
    [$._expression, $.lval],
    [$.actual_param, $._expression],
  ],

  rules: {
    source_file: $ => choice(
      repeat($._statement),
      $._expression
    ),

    _statement: $ => choice(
      $.pre_op_stmt,
      $.declaration,
      $.mutation,
      $.op_assign,
      $.if_statement,
      $.while_statement,
      $.print_statement,
      $.block,
      $.function_call_statement,
      $.exit_statement,
      $.post_op_stmt,
      $.break_statement,
      $.return_statement
    ),

    pre_op_stmt: $ => seq(choice('++', '--'), $.lval, ';'),
    post_op_stmt: $ => seq($.lval, choice('++', '--'), ';'),

    declaration: $ => choice(
      $.assign_declaration,
      $.alloc_declaration,
      $.function_declaration
    ),

    assign_declaration: $ => seq(
      'let',
      $.identifier,
      ':',
      optional($.type),
      '=',
      $._expression,
      ';'
    ),

    alloc_declaration: $ => seq(
      'let',
      $.identifier,
      ':',
      $.type,
      ';'
    ),

    function_declaration: $ => seq(
      'fn',
      field('name', $.identifier),
      '(',
      optional($.formal_params),
      ')',
      optional(seq('->', $.type)),
      $.block
    ),

    mutation: $ => seq(
      $.lval,
      '=',
      $._expression,
      ';'
    ),

    op_assign: $ => seq(
      $.lval,
      choice('+=', '-=', '*=', '/='),
      $._expression,
      ';'
    ),

    if_statement: $ => seq(
      'if',
      $._expression,
      $.block,
      optional(seq('else', $.block))
    ),

    while_statement: $ => seq(
      'while',
      $._expression,
      $.block
    ),

    print_statement: $ => seq(
      'print',
      '(',
      $._expression,
      ')',
      ';'
    ),

    block: $ => seq(
      '{',
      repeat($._statement),
      '}'
    ),

    function_call_statement: $ => seq(
      field('name', $.identifier),
      '(',
      optional($.actual_params),
      ')',
      ';'
    ),

    exit_statement: $ => seq('exit', ';'),

    break_statement: $ => seq('break', ';'),
    return_statement: $ => seq('return', optional($._expression), ';'),

    _expression: $ => choice(
      $.rval,
      $.cast,
      $.to_str,
      $.pre_op,
      $.not,
      $.neg,
      $.binary_expression,
      $.parenthesized_expression,
      $.lval,
      $.function_call,
      $.conditional_expression,
      $.post_op
    ),

    rval: $ => choice(
      $.number,
      $.boolean,
      $.string,
      $.char,
      $.list
    ),

    cast: $ => prec(14, seq('(', $.primitive_type, ')', $._expression)),
    to_str: $ => prec(14, seq('to_str', '(', $._expression, ')')),
    pre_op: $ => prec(14, seq(choice('++', '--'), $.lval)),
    not: $ => prec(14, seq('!', $._expression)),
    neg: $ => prec(14, seq('-', '(', $._expression, ')')),

    binary_expression: $ => {
      const operators = [
        [prec.right, 13, '^'],
        [prec.left, 12, choice('*', '/', '%')],
        [prec.left, 11, choice('+', '-')],
        [prec.left, 10, choice('<', '<=', '>', '>=')],
        [prec.left, 9, choice('==', '!=')],
        [prec.right, 8, '!&'],
        [prec.right, 7, '!|'],
        [prec.left, 6, '&&'],
        [prec.left, 5, '||'],
        [prec.left, 4, '::'],
      ];

      return choice(...operators.map(([fn, p, op]) => fn(p, seq($._expression, op, $._expression))));
    },

    parenthesized_expression: $ => seq('(', $._expression, ')'),

    lval: $ => choice(
      $.identifier,
      seq($.identifier, repeat1(seq('[', $._expression, ']')))
    ),

    function_call: $ => prec(15, seq(
      field('name', $.identifier),
      '(',
      optional($.actual_params),
      ')'
    )),

    conditional_expression: $ => prec.right(3, seq(
      $._expression,
      '?',
      $._expression,
      ':',
      $._expression
    )),

    post_op: $ => prec(2, seq($.lval, choice('++', '--'))),

    formal_params: $ => seq(
      $.formal_param,
      repeat(seq(',', $.formal_param))
    ),

    formal_param: $ => seq(
      $.identifier,
      ':',
      optional('&'),
      $.type
    ),

    actual_params: $ => seq(
      $.actual_param,
      repeat(seq(',', $.actual_param))
    ),

    actual_param: $ => choice(
      seq('&', $.lval),
      $._expression
    ),

    type: $ => choice(
      $.primitive_type,
      $.derived_type
    ),

    primitive_type: $ => choice('int', 'float', 'string', 'char', 'bool'),

    derived_type: $ => $.array_type,

    array_type: $ => prec.left(seq(choice($.primitive_type, $.array_type), '[', $.number, ']')),

    identifier: $ => /[a-zA-Z_][a-zA-Z0-9_]*/,

    number: $ => /-?[0-9]+(\.[0-9]+)?/,

    boolean: $ => choice('true', 'false'),

    string: $ => seq(
      '"',
      repeat(choice(
        $.escape_sequence,
        /[^"\\\n]+/
      )),
      '"'
    ),

    char: $ => seq(
      "'",
      choice(
        $.escape_sequence,
        /[^'\\\n]/
      ),
      "'"
    ),

    escape_sequence: $ => /\\([btnfr"'\\])/,

    list: $ => seq('[', optional($.values), ']'),

    values: $ => seq($._expression, repeat(seq(',', $._expression))),

    comment: $ => choice(
      seq('//', /.*/),
      seq('/*', /[^*]*\*+([^/*][^*]*\*+)*/, '/')
    ),
  }
});

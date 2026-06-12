[ "let" "fn" "if" "else" "while" "return" "break" "exit" ] @keyword
[ "print" "to_str" ] @function.call
(primitive_type) @type.builtin
(array_type) @type
(identifier) @variable
(function_declaration name: (identifier) @function)
(function_call name: (identifier) @function.call)
(function_call_statement name: (identifier) @function.call)
(number) @number
(boolean) @boolean
(string) @string
(char) @string
(escape_sequence) @string.escape
(comment) @comment
[ "=" "+" "-" "*" "/" "%" "^" "==" "!=" "<" "<=" ">" ">=" "&&" "||" "!" "!&" "!|" "::" "+=" "-=" "*=" "/=" "->" "?" ":" "++" "--" ] @operator
[ "(" ")" "[" "]" "{" "}" ] @punctuation.bracket
[ "," ";" ":" ] @punctuation.delimiter

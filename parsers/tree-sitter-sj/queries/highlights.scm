; Keywords
[
  "let"
  "fn"
  "if"
  "else"
  "while"
  "return"
  "break"
  "exit"
] @keyword

[
  "print"
  "to_str"
] @function.builtin

; Types
(primitive_type) @type.builtin
(array_type) @type

; Identifiers
(identifier) @variable

; Functions
(function_declaration name: (identifier) @function)
(function_call name: (identifier) @function.call)
(function_call_statement name: (identifier) @function.call)

; Literals
(number) @number
(boolean) @boolean
(string) @string
(char) @string

; Comments
(comment) @comment

; Operators
[
  "="
  "+"
  "-"
  "*"
  "/"
  "%"
  "^"
  "=="
  "!="
  "<"
  "<="
  ">"
  ">="
  "&&"
  "||"
  "!"
  "!&"
  "!|"
  "::"
  "+="
  "-="
  "*="
  "/="
  "->"
  "?"
  ":"
  "++"
  "--"
] @operator

; Punctuation
[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  ","
  ";"
  ":"
] @punctuation.delimiter

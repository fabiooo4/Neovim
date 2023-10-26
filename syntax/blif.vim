syntax keyword SISdeclarations model 
syntax keyword SISdeclarations inputs 
syntax keyword SISdeclarations outputs 
syntax keyword SISdeclarations end
syntax keyword SISkeywords names exdc start_kiss end_kiss code
syntax keyword SISkiss i o s p r
syntax match SISnumber "\v<\d+>"
syntax keyword SISdc -
syntax match SISvar '\v<\a+\d+>'
syntax match SISvar '\v<\a+>'
syntax region SIScomment start=/# / end="$" oneline

highlight default link SISdeclarations Function
highlight default link SISkeywords Keyword
highlight default link SISkiss Type
highlight default link SISnumber Number
highlight default link SISdc Special
highlight default link SISvar Identifier
highlight default link SIScomment Comment

let b:current_syntax="blif"

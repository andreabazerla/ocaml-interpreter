type ide = string

and exp =
	| Bool 			of bool * bool
	| Int 			of int * bool
	| Char			of char * bool
	| String		of string * bool

	| Tag	 		of exp

	| Len			of exp
	| Upper			of exp
	| Lower			of exp
	| Get			of exp * exp
	| Set			of exp * exp * exp
	| Contains		of exp * exp
	| Sub			of exp * exp * exp
	| Concat		of exp * exp

	| Minus 		of exp
	| Iszero 		of exp
	| Equ 			of exp * exp
	| Sum 			of exp * exp
	| Diff 			of exp * exp
	| Prod 			of exp * exp
	| Div 			of exp * exp

	| Not 			of exp
	| Or 			of exp * exp
	| And 			of exp * exp

	| IfThenElse	of exp * exp * exp

	| Den 			of ide
	| Val 			of exp

	| Ref 			of ide
	| Type 			of exp

	| Newloc 		of exp
	| Let 			of ide * exp * exp

	| Fun			of ide list * exp
	| Appl 			of exp * exp list
	| Proc 			of ide list * block
	| Rec 			of ide * exp

and decl = (ide * exp) list * (ide * exp) list
and block = (ide * exp) list * (ide * exp) list * com list

and com =
	| Assign		of exp * exp
	| CIfThenElse   of exp * com list * com list
	| Block 		of block
	| While 		of exp * com list
	| Call 			of exp * exp list
	| Reflect 		of string

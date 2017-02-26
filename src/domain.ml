exception Trusted
exception Untrusted

exception Nostorable
exception Noexpressible

exception DivisionByZero

type tag =
	| UNTAINTED
	| TAINTED
	| Untagged

and eval =

	| Ebool			of bool * bool
	| Eint			of int * bool
	| Echar			of char * bool
	| Estring		of string * bool

	| Funval 		of efun

	| Etag			of tag

	| Novalue

and dval =

	| Dbool 		of bool * bool
	| Dint 			of int * bool
	| Dchar			of char * bool
	| Dstring		of string * bool

	| Dloc 			of loc

	| Dfunval 		of efun
	| Dprocval 		of proc

	| Unbound

and mval =

	| Mbool 	of bool * bool
	| Mint 		of int * bool
	| Mchar		of char * bool
	| Mstring	of string * bool

	| Undefined

and tval =
	| Tbool 		of bool * bool
	| Tint			of int * bool
	| Tchar			of char * bool
	| Tstring		of string * bool

	| Tloc			of loc

	| Untyped

and efun = exp * (dval env)
and proc = exp * (dval env)

let evaltodval e =
    match e with
		| Ebool(x,t)		-> Dbool(x,t)
		| Eint(x,t)			-> Dint(x,t)
		| Echar(x,t)		-> Dchar(x,t)
		| Estring(x,t)		-> Dstring(x,t)
		| Funval(x)			-> Dfunval(x)
       	| _ 				-> Unbound

let dvaltoeval e =
    match e with
		| Dbool(x,t) 		-> Ebool(x,t)
		| Dint(x,t) 		-> Eint(x,t)
		| Dchar(x,t)		-> Echar(x,t)
		| Dstring(x,t)		-> Estring(x,t)
		| Dloc(x)			-> raise Noexpressible
		| Dfunval(x)		-> Funval(x)
		| Dprocval(x)		-> raise Noexpressible
		| Unbound 			-> Novalue

let evaltomval e =
	match e with
		| Ebool(x,t)		-> Mbool(x,t)
		| Eint(x,t) 		-> Mint(x,t)
		| Echar(x,t)		-> Mchar(x,t)
		| Estring(x,t)		-> Mstring(x,t)
       	| _ 				-> raise Nostorable

let mvaltoeval e =
	match e with
		| Mbool(x,t)		-> Ebool(x,t)
		| Mint(x,t)			-> Eint(x,t)
		| Mchar(x,t)		-> Echar(x,t)
		| Mstring(x,t)		-> Estring(x,t)
		| _ 				-> Novalue

let evaltotval e =
	match e with
		| Ebool(x,t)		-> Tbool(x,t)
		| Eint(x,t)			-> Tint(x,t)
		| Echar(x,t)		-> Tchar(x,t)
		| Estring(x,t)		-> Tstring(x,t)
		| _					-> Untyped

let tvaltoeval e =
	match e with
		| Tbool(x,t)		-> Ebool(x,t)
		| Tint(x,t)			-> Eint(x,t)
		| Tchar(x,t)		-> Echar(x,t)
		| Tstring(x,t)		-> Estring(x,t)
		| Tloc(x)			-> raise Noexpressible
		| Untyped			-> Novalue

let mvaltoetag e =
	match e with
		| Mbool(x,false)	-> Etag(UNTAINTED)
		| Mbool(x,true)		-> Etag(TAINTED)
		| Mint(x,false)		-> Etag(UNTAINTED)
		| Mint(x,true)		-> Etag(TAINTED)
		| Mchar(x,false)	-> Etag(UNTAINTED)
		| Mchar(x,true)		-> Etag(TAINTED)
		| Mstring(x,false)	-> Etag(UNTAINTED)
		| Mstring(x,true)	-> Etag(TAINTED)
		| _ 				-> Novalue

let mvaltobool e =
	match e with
		| Mbool(x,y)		-> y
		| Mint(x,y) 		-> y
		| Mchar(x,y) 		-> y
		| Mstring(x,y) 		-> y
		| _ 				-> failwith("Notaint")

let etagtotag e =
	match e with
		| Etag(UNTAINTED)	-> UNTAINTED
		| Etag(TAINTED)		-> TAINTED
		| _ 				-> Untagged

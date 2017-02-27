let typecheck (x,y) =
	match x with
		| "bool" ->
			(match y with
				| Ebool(z,t)		-> true
				| _ 				-> false)
		| "int" ->
			(match y with
				| Eint(z,t) 		-> true
				| _ 				-> false)
		| "char" ->
			(match y with
				| Echar(z,t)		-> true
				| _ 				-> false)
		| "string" ->
			(match y with
				| Estring(z,t) 		-> true
				| _ 				-> false)
		| _ -> failwith ("Error: typecheck")

let len (x) =
	if (typecheck("string",x))
		then
			match x with
				| Estring(x,t) 	-> Eint(String.length(x),t)
				| _				-> failwith("Error: match")
	else failwith ("Error: type")

let upper (x) =
	if (typecheck("string",x))
		then
			match x with
				| Estring(y,t) 	-> Estring(String.uppercase(y),t)
				| _				-> failwith("Error: match")
	else failwith ("Error: type")

let lower (x) =
	if (typecheck("string",x))
		then
			match x with
				| Estring(y,t) 	-> Estring(String.lowercase(y),t)
				| _				-> failwith("Error: match")
	else failwith ("Error: type")

let get (x,y) =
	if (typecheck("string",x) && typecheck("int",y))
		then
			match (x,y) with
				| Estring(x,a),Eint(y,b) 	-> Echar(String.get x y, a)
				| _							-> failwith("Error: match")
	else failwith ("Error: type")

let set (x,y,z) =
	if (typecheck("string",x) && typecheck("int",y) && typecheck("char",z))
		then
			match (x,y,z) with
				| Estring(x,a),Eint(y,b),Echar(z,c) ->
					let c1 = String.get x y in
						if (c1 == z)
							then Estring (x,a)
						else
							let start = String.sub x 0 y in
								let finish = String.sub x (y+1) (String.length x-(y+1)) in
									Estring(start ^ (String.make 1 z) ^ finish, a || c)
				| _	-> failwith("Error: type error")
	else failwith ("Error: type error")

let contains (x,y) =
	if (typecheck("char",x) && typecheck("string",y))
		then
			match (x,y) with
				| Echar(x,a),Estring(y,b) 	-> Ebool(String.contains y x, a || b)
				| _							-> failwith("Error: match")
	else failwith ("Error: type")

let sub (x,y,z) =
	if (typecheck("string",x) && typecheck("int",y) && typecheck("int",z))
		then
			match (x,y,z) with
				| Estring(x,a),Eint(y,b),Eint(z,c) ->
					let w = (z - y) in
						if w == 0
							then Estring("",false)
						else
							Estring(String.sub x y w, a)
				| _	-> failwith("Error: match")
	else failwith ("Error: type")

let concat (x,y) =
	if (typecheck("string",x) && typecheck("string",y))
		then
			match (x,y) with
				| (Estring(x,a),Estring(y,b)) ->
					if ((x = "") && (y = ""))
						then Estring("",false)
					else if (x = "")
						then Estring(y,b)
					else if (y = "")
						then Estring(x,a)
					else
						Estring(x ^ y, a || b)
				| _	-> failwith("Error: match")
	else failwith ("Error: type")

let minus (x) =
	if (typecheck("int",x))
		then
			match x with
				| Eint(x,t) 	-> Eint(-x,t)
				| _				-> failwith("Error: match")
	else failwith ("Error: type")

let iszero (x) =
	if (typecheck("int",x))
		then
			match x with
				| Eint(y,t) 	-> Ebool(y = 0, t)
				| _				-> failwith("Error: match")
	else failwith ("Error: type")

let equ (x,y) =
	if (typecheck("int",x) && typecheck("int",y))
		then
			match (x,y) with
				| (Eint(x,a),Eint(y,b)) 	-> Ebool(x = y, a || b)
				| _							-> failwith("Error: match")
	else failwith ("Error: type")

let sum (x,y) =
	if (typecheck("int",x) && typecheck("int",y))
		then
			match (x,y) with
				| (Eint(x,a),Eint(y,b)) ->
					if (x == 0 && y != 0)
						then Eint(y,b)
					else if (x != 0 && y == 0)
						then Eint(x,a)
					else
						Eint(x + y, a || b)
				| _	-> failwith("Error: match")
	else failwith ("Error: type")

let diff (x,y) =
	if (typecheck("int",x) && typecheck("int",y))
		then
			match (x,y) with
				| (Eint(x,a),Eint(y,b)) ->
					if (x != 0 && y == 0)
						then Eint(x,a)
					else
						Eint(x - y, a || b)
				| _ -> failwith("Error: match")
	else failwith ("Error: type")

let prod (x,y) =
	if (typecheck("int",x) && typecheck("int",y))
		then
			match (x,y) with
				| (Eint(x,a), Eint(y,b)) ->
					if (x == 0 || y == 0)
						then Eint(0,false)
					else if (x == 1 && y != 1)
						then Eint(y,b)
					else if (x != 1 && y == 1)
						then Eint(x,a)
					else
						Eint(x * y, a || b)
				| _	-> failwith("Error: match")
	else failwith ("Error: type")

let div (x,y) =
	if (typecheck("int",x) && typecheck("int",y))
		then
			match (x,y) with
				| (Eint(x,a), Eint(y,b)) ->
					if (x != 0 && y == 0)
						then raise DivisionByZero
					else if (x == 0 && y != 0)
						then Eint(0,false)
	 				else if (x != 1 && y == 1)
						then Eint(x,a)
					else
						Eint(x / y, a || b)
				| _	-> failwith("Error: match")
	else failwith ("Error: type")

let non (x) =
	if (typecheck("bool",x))
		then
			match x with
				| Ebool(y,t) 	-> Ebool(not y, t)
				| _				-> failwith("Error: match")
	else failwith ("Error: type")

let vel (x,y) =
	if (typecheck("bool",x) && typecheck("bool",y))
		then
			match (x,y) with
				| (Ebool(x,a), Ebool(y,b)) 	-> Ebool(x || y, a || b)
				| _							-> failwith("Error: match")
	else failwith ("Error: type")

let et (x,y) =
	if (typecheck("bool",x) && typecheck("bool",y))
		then
			match (x,y) with
				| (Ebool(x,a),Ebool(y,b)) 	-> Ebool(x && y, a || b)
				| _							-> failwith("Error: match")
	else failwith ("Error: type")

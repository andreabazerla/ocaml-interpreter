let rec sem ((e:exp),(r:dval env),(s:mval store),(t:tval env)) =
	match e with

		| Bool				(x,y)			-> Ebool			(x,y)
		| Int				(x,y)			-> Eint				(x,y)
		| Char 				(x,y)			-> Echar			(x,y)
		| String			(x,y)			-> Estring			(x,y)

		| Len				(x)				-> len				(sem(x,r,s,t))
		| Upper				(x)				-> upper			(sem(x,r,s,t))
		| Lower				(x)				-> lower			(sem(x,r,s,t))
		| Contains			(x,y)			-> contains			((sem(x,r,s,t)),(sem(y,r,s,t)))
		| Get				(x,y)			-> get				((sem(x,r,s,t)),(sem(y,r,s,t)))
		| Set				(x,y,z)			-> set				((sem(x,r,s,t)),(sem(y,r,s,t)),(sem(z,r,s,t)))
		| Sub 				(x,y,z)			-> sub				((sem(x,r,s,t)),(sem(y,r,s,t)),(sem(z,r,s,t)))
		| Concat			(x,y)			-> concat			((sem(x,r,s,t)),(sem(y,r,s,t)))

		| Minus			    (x) 			-> minus			(sem(x,r,s,t))
		| Iszero		    (x) 			-> iszero			(sem(x,r,s,t))
		| Equ				(x,y) 	  		-> equ				((sem(x,r,s,t)),(sem(y,r,s,t)))
		| Sum				(x,y) 	 	   	-> sum				((sem(x,r,s,t)),(sem(y,r,s,t)))
		| Diff			    (x,y) 	  	  	-> diff				((sem(x,r,s,t)),(sem(y,r,s,t)))
		| Prod			    (x,y) 	 	   	-> prod				((sem(x,r,s,t)),(sem(y,r,s,t)))
		| Div			    (x,y) 		    -> div				((sem(x,r,s,t)),(sem(y,r,s,t)))

		| Not				(x) 			-> non				(sem(x,r,s,t))
		| Or				(x,y)			-> vel				((sem(x,r,s,t)),(sem(y,r,s,t)))
		| And				(x,y) 		    -> et				((sem(x,r,s,t)),(sem(y,r,s,t)))

		| IfThenElse (x,y,z) ->
			let f = sem(x,r,s,t) in
				if (typecheck("bool",f) || typecheck("int",f))
					then (
						if (f = Ebool(true,false) || f = Ebool(true,true))
							then sem(y,r,s,t)
						else sem(z,r,s,t)
					)
				else
					failwith ("Error: nonboolean guard")

		| Den (x) -> dvaltoeval (applyenv(r,x))

		| Val (x) ->
			let (v,s1) =
				semden(x,r,s,t) in (
					match v with
						| Dloc(n) 	-> mvaltoeval(applystore(s1,n))
						| _ 		-> failwith("Error: not a variable")
				)

		| Ref (x) -> tvaltoeval (applyenv(t,x))

		| Type (x) ->
			let (v,s1) =
				semtaint(x,r,s,t) in (
					match v with
						| Tloc(n) 	-> mvaltoetag(applystore(s1,n))
						| _ 		-> failwith("Error: not a variable")
				)

		| Let (i,e1,e2) ->
			let (v,s1) =
				semden(e1,r,s,t) in
					sem(e2,bind(r,i,v),s1,t)

		| Fun(i,a) -> dvaltoeval(makefun(Fun(i,a),r))

        | Appl(a,b) ->
			let (v1,s1) =
				semlist(b,r,s,t) in
             		applyfun(evaltodval(sem(a,r,s,t)),v1,s1,t)

		| Rec(f,e) -> makefunrec(f,e,r)

		| _	-> failwith("Error: expression invalid")

and semden ((e:exp),(r:dval env),(s:mval store),(t:tval env)) =
	match e with

		| Den(e) -> (applyenv(r,e),s)

		| Newloc(e) ->
			let m =
				evaltomval(sem(e,r,s,t)) in
					let (l,s1) = allocate(s, m) in
						(Dloc(l), s1)

		| _ -> (evaltodval(sem(e,r,s,t)),s)

and semtaint ((e:exp),(r:dval env),(s:mval store),(t:tval env)) =
	match e with

		| Ref(e) -> (applyenv(t,e),s)

		| _ -> (evaltotval(sem(e,r,s,t)),s)

and semc ((c:com),(r:dval env),(s:mval store),(t:tval env)) =
	match c with

		| Assign(e1,e2) ->
			let (v1,s1) =
				semden(e1,r,s,t) in (
					match v1 with
						| Dloc(n) 	-> preupdate(s1,n,evaltomval(sem(e2,r,s,t)))
						| _			-> failwith ("Error: wrong location in assignment")
				)

		| CIfThenElse(e,cl1,cl2) ->
			let f = sem(e,r,s,t) in
				if typecheck("bool",f) then
					(
						if f = Ebool(true,false)
							then semcl(cl1,r,s,t)
						else if (f = Ebool(true,true))
							then raise Untrusted
						else semcl(cl2,r,s,t)
					)
				else failwith ("Error: nonboolean guard")

		| While(e,cl) ->
			let f = sem(e,r,s,t) in
				if typecheck("bool",f) then
					(if (f = Ebool(true,false) || f = Ebool(true,true))
						then semcl((cl @ [While(e,cl)]),r,s,t)
					else s)
				else failwith ("Error: nonboolean guard")

		| Block(b) -> semb(b,r,s,t)

		| Call(e1,e2) ->
			let (p,s1) =
				semden(e1,r,s,t) in
		   			let (v,s2) =
						semlist(e2,r,s1,t) in
		   					applyproc(p,v,s2,t)

		| Reflect(x) ->
			let comList, str = parseComList x in
				semcl(comList,r,s,t)

and semb ((dl,rdl,cl),r,s,t) =
	let (r1,s1) =
  		semdl((dl,rdl),r,s,t) in
       		semcl(cl,r1,s1,t)

and semdl ((dl,rl),r,s,t) =
	let (r1,s1) =
		semdv(dl,r,s,t) in
			semdr(rl,r1,s1,t)

and semdv (dl,r,s,t) =
	match dl with
		| [] -> (r,s)
		| (i,e)::dl1 ->
			let (v,s1) =
				semden(e,r,s,t) in
					semdv(dl1,bind(r,i,v),s1,t)

and semcl (cl,r,s,t) =
	match cl with
		| [] -> s
		| c::cl1 -> semcl(cl1,r,semc(c,r,s,t),t)

and semlist (el,r,s,t) =
	match el with
    	| [] -> ([],s)
    	| e::el1 ->
			let (v1,s1) =
				semden(e,r,s,t) in
      				let (v2,s2) =
						semlist(el1,r,s1,t) in
       						(v1::v2,s2)

and semdr (rl,r,s,t) =
	let functional ((r1: dval env)) =
		(match rl with
	   		| [] -> r
	   		| (i,e)::rl1 ->
				let (v,s2) = semden(e,r1,s,t) in
		 			let (r2,s3) = semdr(rl1,bind(r,i,v),s,t) in r2) in
	 					let rec rfix = function x -> functional rfix x in (rfix,s)

and makefun ((e:exp),(r:dval env)) =
	(match e with
    	| Fun(x,y) -> Dfunval(e,r)
      	| _ -> failwith ("Non-functional object"))

and makeproc ((e:exp),(r:dval env)) =
	(match e with
		| Proc(x,y) -> Dprocval(e,r)
      	| _ -> failwith ("Non-procedural object"))

and applyfun ((ev1:dval),(ev2:dval list),s,t) =
	(match ev1 with
    	| Dfunval(Fun(ii,aa),x) -> sem(aa,bindlist(x,ii,ev2),s,t)
      	| _ -> failwith ("attempt to apply a non-functional object"))

and applyproc ((ev1:dval),(ev2:dval list),s,t) =
	(match ev1 with
    	| Dprocval(Proc(ii,b),x) -> semb(b,bindlist(x,ii,ev2),s,t)
      	| _ -> failwith ("attempt to apply a non-functional object"))

and makefunrec (i,e1,r) =
     let functional (rr: dval env) =
	     bind(r, i, makefun(e1,rr)) in
	     	let rec rfix =
				function x ->
					functional rfix x in
		 				dvaltoeval(makefun(e1, rfix))

and preupdate ((r: 'a store),(l: loc),(e: mval)): ('a store) =
	if (mvaltobool e = false)
		then update (r,l,e)
	else if (mvaltobool (applystore (r,l)) = false)
		then update (r,l,e)
	else raise Untrusted

and liststorage s =
	let rec scan s li i =
		let l = applystore (s,i) in
			match l with
	 			| Undefined -> li
				| _ -> let ll = mvaltobool l in scan s (ll :: li) (i + 1);
	in scan s [] 0

let rec print_list = function
	| [] -> ()
	| e::l -> let ll = Pervasives.string_of_bool e in print_string ll; print_list l

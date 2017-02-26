type loc = int

type 't store =
	loc -> 't

let (newloc,initloc) =
	let count =
		ref(-1) in
			(fun () -> count := !count +1; !count),
			(fun () -> count := -1)

let emptystore (x) =
	initloc ();
	function y -> x

let applystore (x,y) =
	x y

let allocate ((r:'a store),(e:'a)) =
	let l =
		newloc () in
			(l,function lu ->
				if lu = l
					then e
				else applystore(r, lu))

let update ((r:'a store),(l:loc),(e:'a)) =
	function lu ->
		if lu = l
			then e
		else applystore(r,lu)

let r = emptyenv(Unbound);;
let s = emptystore(Undefined);;
let t = emptyenv(Untyped);;

print_endline("\nSTRING -------------------------------------------------------------------------");;

print_endline("\nLENGTH");;
let length = sem(length,r,s,t);;

print_endline("\nUPPER");;
let upper = sem(upper,r,s,t);;

print_endline("\nLOWER");;
let lower = sem(lower,r,s,t);;

print_endline("\nGET");;
let get1 = sem(get1,r,s,t);;
let get2 = sem(get2,r,s,t);;
let get3 = sem(get3,r,s,t);;

print_endline("\nSET");;
let set1 = sem(set1,r,s,t);;
let set2 = sem(set2,r,s,t);;
let set3 = sem(set3,r,s,t);;
let set4 = sem(set4,r,s,t);;
let set5 = sem(set5,r,s,t);;
(* Exception: Invalid_argument "Index out of bounds".
let set6 = sem(set6,r,s,t);;
*)

print_endline("\nCONTAINS");;
let contains1 = sem(contains1,r,s,t);;
let contains2 = sem(contains2,r,s,t);;
let contains3 = sem(contains3,r,s,t);;

print_endline("\nSUB");;
let sub1 = sem(sub1,r,s,t);;
let sub2 = sem(sub2,r,s,t);;
let sub3 = sem(sub3,r,s,t);;
(*
let sub4 = sem(sub4,r,s,t);;
*)

print_endline("\nCONCAT");;
let concat1 = sem(concat1,r,s,t);;
let concat2 = sem(concat2,r,s,t);;
let concat3 = sem(concat3,r,s,t);;

print_endline("\nEXPRESSIONS --------------------------------------------------------------------");;

print_endline("\nMINUS");;
let minus1 = sem(minus1,r,s,t);;
let minus2 = sem(minus2,r,s,t);;
let minus3 = sem(minus3,r,s,t);;
let minus4 = sem(minus4,r,s,t);;

print_endline("\nISZERO");;
let iszero1 = sem(iszero1,r,s,t);;
let iszero2 = sem(iszero2,r,s,t);;

print_endline("\nEQU");;
let equ1 = sem(equ1,r,s,t);;
let equ2 = sem(equ2,r,s,t);;
let equ3 = sem(equ3,r,s,t);;
let equ4 = sem(equ4,r,s,t);;

print_endline("\nSUM");;
let sum1 = sem(sum1,r,s,t);;
let sum2 = sem(sum2,r,s,t);;
let sum3 = sem(sum3,r,s,t);;
let sum4 = sem(sum4,r,s,t);;
let sum5 = sem(sum5,r,s,t);;
let sum6 = sem(sum6,r,s,t);;

print_endline("\nDIFF");;
let diff1 = sem(diff1,r,s,t);;
let diff2 = sem(diff2,r,s,t);;
let diff3 = sem(diff3,r,s,t);;
let diff4 = sem(diff4,r,s,t);;
let diff5 = sem(diff5,r,s,t);;
let diff6 = sem(diff6,r,s,t);;

print_endline("\nPROD");;
let prod1 = sem(prod1,r,s,t);;
let prod2 = sem(prod2,r,s,t);;
let prod3 = sem(prod3,r,s,t);;
let prod4 = sem(prod4,r,s,t);;
let prod5 = sem(prod5,r,s,t);;

print_endline("\nDIV");;
let div1 = sem(div1,r,s,t);;
let div2 = sem(div2,r,s,t);;
(* Exception: DivisionByZero
let div3 = sem(div3,r,s,t);;
let div4 = sem(div4,r,s,t);;
let div5 = sem(div5,r,s,t);;
let div6 = sem(div6,r,s,t);;
let div7 = sem(div7,r,s,t);;
let div8 = sem(div8,r,s,t);;
*)

print_endline("\nNOT");;
let non1 = sem(non1,r,s,t);;
let non2 = sem(non2,r,s,t);;

print_endline("\nOR");;
let vel1 = sem(vel1,r,s,t);;
let vel2 = sem(vel2,r,s,t);;
let vel3 = sem(vel3,r,s,t);;

print_endline("\nAND");;
let et1 = sem(et1,r,s,t);;
let et2 = sem(et2,r,s,t);;
let et3 = sem(et3,r,s,t);;

print_endline("\nIFTHENELSE");;
let ifthenelse1 = sem(ifthenelse1,r,s,t);;
let ifthenelse2 = sem(ifthenelse2,r,s,t);;
(* Exception: Untrusted
let ifthenelse3 = sem(ifthenelse3,r,s,t);;
*)

print_endline("\nFACTORIAL ----------------------------------------------------------------------");;

let factorial = sem(factorial,r,s,t);;

let (l3,s3) = allocate (s,Mint(4,false));;
let r3 = bind (r,"z",Dloc(l3));;
let t3 = bind (t,"z",Tloc(l3));;

let (l4,s4) = allocate (s3,Mint(1,false));;
let r4 = bind (r3,"w",Dloc(l4));;
let t4 = bind (t3,"w",Tloc(l4));;

let s5 = semcl(factorial2,r4,s4,t4);;

sem(Val(Den("z")),r4,s5,t4);;
etagtotag(sem(Type(Ref("z")),r4,s5,t4));;

sem(Val(Den("w")),r4,s5,t4);;
etagtotag(sem(Type(Ref("w")),r4,s5,t4));;

print_endline("\nREFLECT ------------------------------------------------------------------------");;

(*
let r = emptyenv(Unbound);;
let s = emptystore(Undefined);;
let t = emptyenv(Untyped);;

let d = [("x",Newloc(Int(4,false)));("y",Newloc(Int(1,false)))];;
let r1,s1 = semdv(d,r,s,t);;

let block1 = "[Block([],[],[While(Not(Equ(Val(Den(\"x\")),Int(0,false))),[Assign(Den(\"y\"),Prod(Val(Den(\"y\")),Val(Den(\"x\"))));Assign(Den(\"x\"),Diff(Val(Den(\"x\")),Int(1,true)))])])]";;

let s2 = semc(Reflect(block1),r1,s1,t);;
*)

let (terminal, remain) = parseExp factorial3;;
let factorial3 = sem(terminal,r,s,t);;

let (l1,s1) = allocate (s,Mint(0,false));;
let r1 = bind (r,"x",Dloc(l1));;
let t1 = bind (t,"x",Tloc(l1));;

let (l2,s2) = allocate (s1,Mint(1,true));;
let r2 = bind (r1,"y",Dloc(l2));;
let t2 = bind (t1,"y",Tloc(l2));;

let (l3,s3) = allocate (s2,Mint(2,false));;
let r3 = bind (r2,"z",Dloc(l3));;
let t3 = bind (t2,"z",Tloc(l3));;

sem(Val(Den("x")),r3,s3,t3);;
etagtotag(sem(Type(Ref("x")),r3,s3,t3));;

sem(Val(Den("y")),r3,s3,t3);;
etagtotag(sem(Type(Ref("y")),r3,s3,t3));;

sem(Val(Den("z")),r3,s3,t3);;
etagtotag(sem(Type(Ref("z")),r3,s3,t3));;

let s4 = semc(Reflect(assign1),r3,s3,t3);;

sem(Val(Den("x")),r3,s4,t3);;
etagtotag(sem(Type(Ref("x")),r3,s4,t3));;

sem(Val(Den("y")),r3,s4,t3);;
etagtotag(sem(Type(Ref("y")),r3,s4,t3));;

sem(Val(Den("z")),r3,s4,t3);;
etagtotag(sem(Type(Ref("z")),r3,s4,t3));;

print_endline("\nETVOILAAAAA");;

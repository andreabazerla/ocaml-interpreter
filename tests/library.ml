print_endline("\nSTRING -------------------------------------------------------------------------");;

let welcome = "Hello World";;

print_endline("\nLENGTH");;
let length = Let("length", Fun(["x"], Len(Den("x"))), Appl(Den("length"), [String(welcome,false)]));;

print_endline("\nUPPER");;
let upper = Let("upper", Fun(["x"], Upper(Den("x"))), Appl(Den("upper"), [String(welcome,true)]));;

print_endline("\nLOWER");;
let lower = Let("lower", Fun(["x"], Lower(Den("x"))), Appl(Den("lower"), [String(welcome,false)]));;

print_endline("\nGET");;
let get1 = Let("get1", Fun(["x"], Fun(["y"], Get(Den("x"), Den("y")))), Appl(Appl(Den("get1"), [String(welcome,false)]), [Int(0,false)]));;
let get2 = Let("get2", Fun(["x"], Fun(["y"], Get(Den("x"), Den("y")))), Appl(Appl(Den("get2"), [String(welcome,false)]), [Int(0,true)]));;
let get3 = Let("get3", Fun(["x"], Fun(["y"], Get(Den("x"), Den("y")))), Appl(Appl(Den("get3"), [String(welcome,true)]), [Int(0,false)]));;

print_endline("\nSET");;
let set1 = Let("set1", Fun(["x"], Fun(["y"], Fun(["z"], Set(Den("x"), Den("y"), Den("z"))))), Appl(Appl(Appl(Den("set1"), [String(welcome,false)]), [Int(3,false)]), [Char('_',true)]));;
let set2 = Let("set2", Fun(["x"], Fun(["y"], Fun(["z"], Set(Den("x"), Den("y"), Den("z"))))), Appl(Appl(Appl(Den("set2"), [String(welcome,false)]), [Int(3,true)]), [Char('_',false)]));;
let set3 = Let("set3", Fun(["x"], Fun(["y"], Fun(["z"], Set(Den("x"), Den("y"), Den("z"))))), Appl(Appl(Appl(Den("set3"), [String(welcome,true)]), [Int(3,false)]), [Char('_',false)]));;
let set4 = Let("set4", Fun(["x"], Fun(["y"], Fun(["z"], Set(Den("x"), Den("y"), Den("z"))))), Appl(Appl(Appl(Den("set4"), [String(welcome,false)]), [Int(5,false)]), [Char(' ',true)]));;
let set5 = Let("set5", Fun(["x"], Fun(["y"], Fun(["z"], Set(Den("x"), Den("y"), Den("z"))))), Appl(Appl(Appl(Den("set5"), [String(welcome,true)]), [Int(5,false)]), [Char(' ',false)]));;
let set6 = Let("set6", Fun(["x"], Fun(["y"], Fun(["z"], Set(Den("x"), Den("y"), Den("z"))))), Appl(Appl(Appl(Den("set6"), [String(welcome,false)]), [Int(999,false)]), [Char('_',false)]));;

print_endline("\nCONTAINS");;
let contains1 = Let("contains1", Fun(["x"], Fun(["y"], Contains(Den("x"), Den("y")))), Appl(Appl(Den("contains1"), [Char('l',false)]), [String(welcome,false)]));;
let contains2 = Let("contains2", Fun(["x"], Fun(["y"], Contains(Den("x"), Den("y")))), Appl(Appl(Den("contains2"), [Char(' ',false)]), [String(welcome,true)]));;
let contains3 = Let("contains3", Fun(["x"], Fun(["y"], Contains(Den("x"), Den("y")))), Appl(Appl(Den("contains3"), [Char('#',true)]), [String(welcome,false)]));;

print_endline("\nSUB");;
let sub1 = Let("sub1", Fun(["x"], Fun(["y"], Fun(["z"], Sub(Den("x"), Den("y"), Den("z"))))), Appl(Appl(Appl(Den("sub1"), [String(welcome,false)]), [Int(2,false)]), [Int(6,false)]));;
let sub2 = Let("sub2", Fun(["x"], Fun(["y"], Fun(["z"], Sub(Den("x"), Den("y"), Den("z"))))), Appl(Appl(Appl(Den("sub2"), [String(welcome,true)]), [Int(2,false)]), [Int(6,false)]));;
let sub3 = Let("sub3", Fun(["x"], Fun(["y"], Fun(["z"], Sub(Den("x"), Den("y"), Den("z"))))), Appl(Appl(Appl(Den("sub3"), [String(welcome,true)]), [Int(5,false)]), [Int(5,true)]));;
let sub4 = Let("sub4", Fun(["x"], Fun(["y"], Fun(["z"], Sub(Den("x"), Den("y"), Den("z"))))), Appl(Appl(Appl(Den("sub4"), [String(welcome,false)]), [Int(0,false)]), [Int(999,false)]));;

print_endline("\nCONCAT");;
let concat1 = Let("concat1", Fun(["x"], Fun(["y"], Concat(Den("x"), Den("y")))), Appl(Appl(Den("concat1"), [String("",false)]), [String("Andrea.",true)]));;
let concat2 = Let("concat2", Fun(["x"], Fun(["y"], Concat(Den("x"), Den("y")))), Appl(Appl(Den("concat2"), [String("Hello, ",false)]), [String("",true)]));;
let concat3 = Let("concat3", Fun(["x"], Fun(["y"], Concat(Den("x"), Den("y")))), Appl(Appl(Den("concat3"), [String("",false)]), [String("",true)]));;

print_endline("\nEXPRESSIONS --------------------------------------------------------------------");;

print_endline("\nMINUS");;
let minus1 = Let("minus1", Fun(["x"], Minus(Den("x"))), Appl(Den("minus1"), [Int(1,false)]));;
let minus2 = Let("minus2", Fun(["x"], Minus(Den("x"))), Appl(Den("minus2"), [Int(-1,true)]));;
let minus3 = Let("minus3", Fun(["x"], Minus(Den("x"))), Appl(Den("minus3"), [Int(0,false)]));;
let minus4 = Let("minus4", Fun(["x"], Minus(Den("x"))), Appl(Den("minus4"), [Int(0,true)]));;

print_endline("\nISZERO");;
let iszero1 = Let("iszero1", Fun(["x"], Iszero(Den("x"))), Appl(Den("iszero1"), [Int(0,false)]));;
let iszero2 = Let("iszero2", Fun(["x"], Iszero(Den("x"))), Appl(Den("iszero2"), [Int(0,true)]));;

print_endline("\nEQU");;
let equ1 = Let("equ1", Fun(["x"], Fun(["y"], Equ(Den("x"), Den("y")))), Appl(Appl(Den("equ1"), [Int(0,false)]), [Int(1,false)]));;
let equ2 = Let("equ2", Fun(["x"], Fun(["y"], Equ(Den("x"), Den("y")))), Appl(Appl(Den("equ2"), [Int(0,false)]), [Int(1,true)]));;
let equ3 = Let("equ3", Fun(["x"], Fun(["y"], Equ(Den("x"), Den("y")))), Appl(Appl(Den("equ3"), [Int(1,false)]), [Int(1,false)]));;
let equ4 = Let("equ4", Fun(["x"], Fun(["y"], Equ(Den("x"), Den("y")))), Appl(Appl(Den("equ4"), [Int(1,true)]), [Int(1,true)]));;

print_endline("\nSUM");;
let sum1 = Let("sum1", Fun(["x"], Fun(["y"], Sum(Den("x"), Den("y")))), Appl(Appl(Den("sum1"), [Int(1,false)]), [Int(2,false)]));;
let sum2 = Let("sum2", Fun(["x"], Fun(["y"], Sum(Den("x"), Den("y")))), Appl(Appl(Den("sum2"), [Int(1,false)]), [Int(2,true)]));;
let sum3 = Let("sum3", Fun(["x"], Fun(["y"], Sum(Den("x"), Den("y")))), Appl(Appl(Den("sum3"), [Int(1,false)]), [Int(0,false)]));;
let sum4 = Let("sum4", Fun(["x"], Fun(["y"], Sum(Den("x"), Den("y")))), Appl(Appl(Den("sum4"), [Int(1,false)]), [Int(0,true)]));;
let sum5 = Let("sum5", Fun(["x"], Fun(["y"], Sum(Den("x"), Den("y")))), Appl(Appl(Den("sum5"), [Int(0,false)]), [Int(0,true)]));;
let sum6 = Let("sum6", Fun(["x"], Fun(["y"], Sum(Den("x"), Den("y")))), Appl(Appl(Den("sum6"), [Int(0,true)]), [Int(0,true)]));;

print_endline("\nDIFF");;
let diff1 = Let("diff1", Fun(["x"], Fun(["y"], Diff(Den("x"), Den("y")))), Appl(Appl(Den("diff1"), [Int(2,false)]), [Int(1,false)]));;
let diff2 = Let("diff2", Fun(["x"], Fun(["y"], Diff(Den("x"), Den("y")))), Appl(Appl(Den("diff2"), [Int(2,false)]), [Int(3,true)]));;
let diff3 = Let("diff3", Fun(["x"], Fun(["y"], Diff(Den("x"), Den("y")))), Appl(Appl(Den("diff3"), [Int(2,false)]), [Int(0,true)]));;
let diff4 = Let("diff4", Fun(["x"], Fun(["y"], Diff(Den("x"), Den("y")))), Appl(Appl(Den("diff4"), [Int(0,true)]), [Int(2,false)]));;
let diff5 = Let("diff5", Fun(["x"], Fun(["y"], Diff(Den("x"), Den("y")))), Appl(Appl(Den("diff5"), [Int(0,false)]), [Int(0,true)]));;
let diff6 = Let("diff6", Fun(["x"], Fun(["y"], Diff(Den("x"), Den("y")))), Appl(Appl(Den("diff6"), [Int(0,true)]), [Int(0,true)]));;

print_endline("\nPROD");;
let prod1 = Let("prod1", Fun(["x"], Fun(["y"], Prod(Den("x"), Den("y")))), Appl(Appl(Den("prod1"), [Int(2,false)]), [Int(3,false)]));;
let prod2 = Let("prod2", Fun(["x"], Fun(["y"], Prod(Den("x"), Den("y")))), Appl(Appl(Den("prod2"), [Int(2,false)]), [Int(3,true)]));;
let prod3 = Let("prod3", Fun(["x"], Fun(["y"], Prod(Den("x"), Den("y")))), Appl(Appl(Den("prod3"), [Int(2,false)]), [Int(0,true)]));;
let prod4 = Let("prod4", Fun(["x"], Fun(["y"], Prod(Den("x"), Den("y")))), Appl(Appl(Den("prod4"), [Int(2,true)]), [Int(0,false)]));;
let prod5 = Let("prod5", Fun(["x"], Fun(["y"], Prod(Den("x"), Den("y")))), Appl(Appl(Den("prod5"), [Int(0,false)]), [Int(0,true)]));;
let prod6 = Let("prod6", Fun(["x"], Fun(["y"], Prod(Den("x"), Den("y")))), Appl(Appl(Den("prod6"), [Int(0,true)]), [Int(0,true)]));;

print_endline("\nDIV");;
let div1 = Let("div1", Fun(["x"], Fun(["y"], Div(Den("x"), Den("y")))), Appl(Appl(Den("div1"), [Int(10,false)]), [Int(2,false)]));;
let div2 = Let("div2", Fun(["x"], Fun(["y"], Div(Den("x"), Den("y")))), Appl(Appl(Den("div2"), [Int(3,false)]), [Int(2,true)]));;
let div3 = Let("div3", Fun(["x"], Fun(["y"], Div(Den("x"), Den("y")))), Appl(Appl(Den("div3"), [Int(2,false)]), [Int(1,true)]));;
let div4 = Let("div4", Fun(["x"], Fun(["y"], Div(Den("x"), Den("y")))), Appl(Appl(Den("div4"), [Int(2,true)]), [Int(1,false)]));;
let div5 = Let("div5", Fun(["x"], Fun(["y"], Div(Den("x"), Den("y")))), Appl(Appl(Den("div5"), [Int(1,false)]), [Int(1,false)]));;
let div6 = Let("div6", Fun(["x"], Fun(["y"], Div(Den("x"), Den("y")))), Appl(Appl(Den("div6"), [Int(1,false)]), [Int(1,true)]));;
let div7 = Let("div7", Fun(["x"], Fun(["y"], Div(Den("x"), Den("y")))), Appl(Appl(Den("div7"), [Int(1,true)]), [Int(1,true)]));;
let div8 = Let("div8", Fun(["x"], Fun(["y"], Div(Den("x"), Den("y")))), Appl(Appl(Den("div8"), [Int(1,false)]), [Int(0,false)]));;
let div9 = Let("div9", Fun(["x"], Fun(["y"], Div(Den("x"), Den("y")))), Appl(Appl(Den("div9"), [Int(1,false)]), [Int(0,true)]));;
let div10 = Let("div10", Fun(["x"], Fun(["y"], Div(Den("x"), Den("y")))), Appl(Appl(Den("div10"), [Int(0,false)]), [Int(0,false)]));;
let div11 = Let("div11", Fun(["x"], Fun(["y"], Div(Den("x"), Den("y")))), Appl(Appl(Den("div11"), [Int(0,false)]), [Int(0,true)]));;

print_endline("\nNOT");;
let non1 = Let("non1", Fun(["x"], Not(Den("x"))), Appl(Den("non1"), [Bool(false,false)]));;
let non2 = Let("non2", Fun(["x"], Not(Den("x"))), Appl(Den("non2"), [Bool(true,true)]));;

print_endline("\nOR");;
let vel1 = Let("vel1", Fun(["x"], Fun(["y"], Or(Den("x"), Den("y")))), Appl(Appl(Den("vel1"), [Bool(false,false)]), [Bool(false,false)]));;
let vel2 = Let("vel2", Fun(["x"], Fun(["y"], Or(Den("x"), Den("y")))), Appl(Appl(Den("vel2"), [Bool(false,false)]), [Bool(true,true)]));;
let vel3 = Let("vel3", Fun(["x"], Fun(["y"], Or(Den("x"), Den("y")))), Appl(Appl(Den("vel3"), [Bool(true,true)]), [Bool(true,true)]));;

print_endline("\nAND");;
let et1 = Let("et1", Fun(["x"], Fun(["y"], And(Den("x"), Den("y")))), Appl(Appl(Den("et1"), [Bool(false,false)]), [Bool(false,false)]));;
let et2 = Let("et2", Fun(["x"], Fun(["y"], And(Den("x"), Den("y")))), Appl(Appl(Den("et2"), [Bool(false,false)]), [Bool(true,true)]));;
let et3 = Let("et3", Fun(["x"], Fun(["y"], And(Den("x"), Den("y")))), Appl(Appl(Den("et3"), [Bool(true,true)]), [Bool(true,true)]));;

print_endline("\nIFTHENELSE");;
let ifthenelse1 = Let("ifthenelse1", Fun(["x"], Fun(["y"], Fun(["z"], IfThenElse(Den("x"), Den("y"), Den("z"))))), Appl(Appl(Appl(Den("ifthenelse1"), [Bool(false,false)]), [Bool(true,false)]), [Bool(false,false)]));;
let ifthenelse2 = Let("ifthenelse2", Fun(["x"], Fun(["y"], Fun(["z"], IfThenElse(Den("x"), Den("y"), Den("z"))))), Appl(Appl(Appl(Den("ifthenelse2"), [Bool(true,false)]), [Bool(true,false)]), [Bool(false,false)]));;
let ifthenelse3 = Let("ifthenelse3", Fun(["x"], Fun(["y"], Fun(["z"], IfThenElse(Den("x"), Den("y"), Den("z"))))), Appl(Appl(Appl(Den("ifthenelse3"), [Bool(true,true)]), [Bool(true,true)]), [Bool(false,true)]));;

print_endline("\nFACTORIAL ----------------------------------------------------------------------");;

let factorial = Let("factorial", Rec("factorial", Fun(["x"], IfThenElse(Equ(Den("x"), Int(0,false)), Int(1,false), Prod(Den("x"), Appl(Den("factorial"), [Diff(Den("x"), Int(1,false))]))))), Appl(Den("factorial"), [Int(4,false)]));;

let factorial2 = [While(Not(Equ(Val(Den("z")), Int(0,false))), [Assign(Den("y"), Prod(Val(Den("y")), Val(Den("z")))); Assign(Den("z"), Diff(Val(Den("z")), Int(1,false)))])];;

print_endline("\nREFLECT ------------------------------------------------------------------------");;

let assign1 = "[Assign(Den(\"x\"),Int(1,true));Assign(Den(\"y\"),Int(1,false));Assign(Den(\"z\"),Int(2,true))]";;

let factorial3 = "Let(\"factorial\",Rec(\"factorial\",Fun([\"x\"],IfThenElse(Equ(Den(\"x\"),Int(0,false)),Int(1,false), Prod(Den(\"x\"),Appl(Den(\"factorial\"),[Diff(Den(\"x\"),Int(1,false))]))))),Appl(Den(\"factorial\"),[Int(4,false)]))";;

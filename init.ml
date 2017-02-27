(*
#use "init.ml";;
*)

print_endline("\nMODULE ##########################################################################\n");;
print_endline("\nENVIRONMENT");;
#use "src/mod/environment.ml";;
print_endline("\nSTORAGE");;
#use "src/mod/storage.ml";;

print_endline("\nINTERPRETER #####################################################################\n");;
#use "src/syntax.ml";;
#use "src/domain.ml";;
#use "src/operations.ml";;
#use "src/parser.ml";;
#use "src/semantic.ml";;

print_endline("\nLIBRARY ########################################################################\n");;
#use "tests/library.ml";;

print_endline("\nTEST ###########################################################################\n");;
#use "tests/test.ml";;

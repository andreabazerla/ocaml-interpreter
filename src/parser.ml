let parseTerminal s =
    let rec extractTerminal stringToExtract terminalName =
        let trimmedStringToExtract = String.trim(stringToExtract) in
            if String.length(trimmedStringToExtract) = 0
                then terminalName, trimmedStringToExtract
            else
                let charToElaborate = String.sub trimmedStringToExtract 0 1 in
                    let l = String.length(trimmedStringToExtract) in
                        let stringLeftToElaborate = String.sub trimmedStringToExtract 1 (l - 1) in
                            match charToElaborate with

                                | " " | "\n" | "," ->
                                    extractTerminal stringLeftToElaborate terminalName

                                | "(" | "[" | ";" ->
                                    if String.length terminalName = 0
                                        then extractTerminal stringLeftToElaborate terminalName
                                    else terminalName, trimmedStringToExtract

                                | _ -> extractTerminal stringLeftToElaborate (terminalName ^ charToElaborate)

    in extractTerminal s "";;

let parseParam stringToParse =
    let rec extractParams remainString extracted bracket =
        if String.length(remainString) = 0
            then extracted, remainString
        else
            let c = String.sub remainString 0 1 in
                let length = String.length(remainString) in
                    let subString = String.sub remainString 1 (length - 1) in
                        match c with

                            | ")" ->
                                if bracket = 1
                                    then extracted, subString
                                else extractParams subString (extracted ^ c) (bracket - 1)

                            | "(" -> extractParams subString (extracted ^ c) (bracket + 1)

                            | _ ->
                                if bracket = 0
                                    then extractParams subString extracted bracket
                                else extractParams subString (extracted ^ c) bracket

    in extractParams stringToParse "" 0;;

let parseIde stringToParse =
    let rec parseIde toExtract extracted openQuotes =
        if String.length(toExtract) = 0
            then
                if openQuotes = 0
                    then extracted, toExtract
                else failwith ("Uneven quotes in: " ^ stringToParse)
        else
            let c = String.sub toExtract 0 1 in
                let length = String.length(toExtract) in
                    let subString = String.sub toExtract 1 (length - 1) in
                        match c with

                            | "\"" ->
                                if openQuotes = 1
                                    then extracted, subString
                                else parseIde subString extracted (openQuotes + 1)

                            | _ ->
                                if openQuotes = 0
                                    then parseIde subString extracted openQuotes
                                else parseIde subString (extracted ^ c) openQuotes

    in parseIde stringToParse "" 0;;

let parseInt stringToParse =
    let rec parseInt toExtract extracted =
        if String.length(toExtract) = 0
            then failwith ("No int in: " ^ stringToParse)
        else
            let charString = String.sub toExtract 0 1 in
                let lengthString = String.length(toExtract) in
                    let subString = String.sub toExtract 1 (lengthString - 1) in
                        match charString with

                            | " " | "," ->
                                if String.length extracted > 0
                                    then extracted, subString
                                else parseInt subString extracted

                            | "(" -> parseInt (String.trim subString) extracted

                            | _ -> parseInt subString (extracted ^ charString)

    in parseInt (String.trim stringToParse ) "" ;;

let parseChar stringToParse =
    let fullLenght = String.length stringToParse in
    let findSingleQuote = String.index stringToParse '\'' in
    let remain = String.sub stringToParse (findSingleQuote+3) (fullLenght-findSingleQuote-3) in
    stringToParse.[findSingleQuote+1], remain

let parseIdeList stringToParse =
    let fullLenght = String.length stringToParse in
    let openBracket = String.index stringToParse '[' in
    let closeBracket = String.index stringToParse ']' in
    let remain = String.sub stringToParse (closeBracket+1) (fullLenght-closeBracket-1) in
    let idelist = String.sub stringToParse (openBracket+1) (closeBracket-openBracket-1) in
    let rec parseIdes (toExtract : string) (extracted : string list) =
        let parsed, remain = parseIde toExtract in
        if parsed = ""
        then extracted
        else parseIdes remain (parsed :: extracted)
    in parseIdes idelist [], remain

let rec parseBool stringToParse =
    let trimmedString = String.trim(stringToParse) in
        if (String.length trimmedString) < 4
            then failwith ("Cannot parse bool from: " ^ stringToParse)
        else if trimmedString.[0] = ','
            then parseBool (String.sub trimmedString 1 (String.length(trimmedString)-1))
        else if trimmedString.[0] = '\n'
            then parseBool (String.sub trimmedString 1 (String.length(trimmedString)-1))
        else
            let tt = String.sub trimmedString 0 4 in
                if (tt="true") then let rr = String.sub trimmedString 4 (String.length(trimmedString)-4) in (true,rr)
            else
                let ff = String.sub trimmedString 0 5 in
                    if (ff="false") then let rr = String.sub trimmedString 4 (String.length(trimmedString)-4) in (false,rr)
            else failwith ("Cannot find true or false")

let parseList stringToParse =
    let rec extractList t e o =
        if String.length t = 0
            then e, t
        else
            let c = String.sub t 0 1 in
                let l = String.length(t) in
                    let r = String.sub t 1 (l - 1) in
                        match c with

                            | "]" ->
                                if o = 1
                                    then e, r
                                else extractList r (e ^ c) (o - 1)

                            | "[" -> extractList r (e ^ c) (o + 1)

                            | ";" -> extractList r e o

                            | _ ->
                                if o = 0
                                    then extractList r e o
                                else extractList r (e ^ c) o

    in extractList stringToParse "" 0;;

let splitListElement stringToParse =
    let rec extractParamList t e o rlist =
        if String.length t = 0
            then e :: rlist
        else
            let c = String.sub t 0 1 in
                let l = String.length(t) in
                    let r = String.sub t 1 (l-1) in
                        match c with

                            | ";" ->
                                if o = 0
                                    then extractParamList r "" o (e :: rlist)
                                else extractParamList r (e^c) o rlist

                            | "(" -> extractParamList r (e^c) (o+1) rlist

                            | ")" -> extractParamList r (e^c) (o-1) rlist

                            | _ -> extractParamList r (e^c) o rlist

    in extractParamList stringToParse "" 0 [];;

let rec parseExp s =
    let terminal, terminalRemain = parseTerminal s in
        let params, paramRemain = parseParam terminalRemain in
            match terminal with

                | "Char" ->
                    let ide, restide = parseChar params in
                        let b, restbool = parseBool restide in
                            Char (ide, b), paramRemain

                | "Bool" ->
                    let ide, restide = parseBool params in
                        let b, restbool = parseBool restide in
                            Bool (ide, b), paramRemain

                | "String" ->
                    let ide, restide = parseIde params in
                        let b, restbool = parseBool restide in
                            String (ide, b), paramRemain

                | "Tag" ->
                    let exp0, restexp0 = parseExp params in
                        Tag(exp0), paramRemain

                | "Upper" ->
                    let exp0, restexp0 = parseExp params in
                        Upper(exp0), paramRemain

                | "Lower" ->
                    let exp0, restexp0 = parseExp params in
                        Lower(exp0), paramRemain

                | "Len" ->
                    let exp0, restexp0 = parseExp params in
                        Len(exp0), paramRemain

                | "Get" ->
                    let exp0, restexp0 = parseExp params in
                        let exp1, restexp1 = parseExp restexp0 in
                            Get(exp0, exp1), paramRemain

                | "Set" ->
                    let exp0, restexp0 = parseExp params in
                        let exp1, restexp1 = parseExp restexp0 in
                            let exp2, restexp2 = parseExp restexp1 in
                                Set(exp0, exp1, exp2), paramRemain

                | "Contains" ->
                    let exp0, restexp0 = parseExp params in
                        let exp1, restexp1 = parseExp restexp0 in
                            Contains (exp0, exp1), paramRemain

                | "Sub" ->
                    let exp0, restexp0 = parseExp params in
                        let exp1, restexp1 = parseExp restexp0 in
                            let exp2, restexp2 = parseExp restexp1 in
                                Sub(exp0, exp1, exp2), paramRemain

                | "Concat" ->
                    let exp0, restexp0 = parseExp params in
                        let exp1, restexp1 = parseExp restexp0 in
                            Concat (exp0, exp1), paramRemain

                | "Diff" ->
                    let exp0, restexp0 = parseExp params in
                        let exp1, restexp1 = parseExp restexp0 in
                            Diff(exp0, exp1), paramRemain

                | "Appl" ->
                    let exp0, restexp0 = parseExp params in
                        let exp1, restexp1 = parseExpList restexp0 in
                            Appl(exp0, exp1), paramRemain

                | "Prod" ->
                    let exp0, restexp0 = parseExp params in
                        let exp1, restexp1 = parseExp restexp0 in
                            Prod(exp0, exp1), paramRemain

                | "Sum" ->
                    let exp0, restexp0 = parseExp params in
                        let exp1, restexp1 = parseExp restexp0 in
                            Sum(exp0, exp1), paramRemain

                | "Div" ->
                    let exp0, restexp0 = parseExp params in
                        let exp1, restexp1 = parseExp restexp0 in
                            Div(exp0, exp1), paramRemain

                | "Int" ->
                    let ide, restide = parseInt params in
                        let b, restbool = parseBool restide in
                            Int(int_of_string(ide), b), paramRemain

                | "Not" ->
                    let exp0, restexp0 = parseExp params in
                        Not(exp0), paramRemain

                | "Or" ->
                    let exp0, restexp0 = parseExp params in
                        let exp1, restexp1 = parseExp restexp0 in
                            Or (exp0, exp1), paramRemain

                | "And" ->
                    let exp0, restexp0 = parseExp params in
                        let exp1, restexp1 = parseExp restexp0 in
                            And (exp0, exp1), paramRemain

                | "Den" ->
                    let ide, restide = parseIde params in
                        Den(ide), paramRemain

                | "Equ" ->
                    let exp0, restexp0 = parseExp params in
                        let exp1, restexp1 = parseExp restexp0 in
                            Equ(exp0, exp1), paramRemain

                | "Minus" ->
                    let exp0, restexp0 = parseExp params in
                        Minus(exp0), paramRemain

                | "IfThenElse" ->
                    let exp0, restexp0 = parseExp params in
                        let exp1, restexp1 = parseExp restexp0 in
                            let exp2, restexp2 = parseExp restexp1 in
                                IfThenElse(exp0, exp1, exp2), paramRemain

                | "Iszero" ->
                    let exp0, restexp0 = parseExp params in
                        Iszero(exp0), paramRemain

                | "Fun" ->
                    let ides, restide = parseIdeList params in
                        let exp1, restexp1 = parseExp restide in
                            Fun(ides, exp1), paramRemain

                | "Rec" ->
                    let ide, restide = parseIde params in
                        let exp1, restexp1 = parseExp restide in
                            Rec(ide, exp1), paramRemain

                | "Let" ->
                    let ide, restide = parseIde params in
                        let exp1, restexp1 = parseExp restide in
                            let exp2, restexp2 = parseExp restexp1 in
                                Let(ide, exp1, exp2), paramRemain

                | "Val" ->
                    let exp0, restexp0 = parseExp params in
                        Val(exp0), paramRemain

                | "Ref" ->
                    let ide, restide = parseIde params in
                        Ref(ide), paramRemain

                | "Type" ->
                    let exp0, restexp0 = parseExp params in
                        Type(exp0), paramRemain

                | "Newloc" ->
                    let exp0, restexp0 = parseExp params in
                        Newloc(exp0), paramRemain

                | _ -> failwith ("Unhandled expression: " ^ terminal)


and parseExpList stringToParse =
    let explist, remainExplist = parseList stringToParse in
        let rec parseExps (toExtract : string) (extracted : exp list) =
            if String.trim toExtract = ""
            then
                extracted
            else
                let parsed, remain = parseExp toExtract in
                    parseExps remain (parsed :: extracted)
            in parseExps explist [], remainExplist

let parseStringIdexExp stringToParse =
    let ide, remain0 = parseIde stringToParse in
     let exp0, remain1 = parseExp remain0 in
        ide, exp0;;

let parseIdexExpList (listideexp: string list) =
    List.rev_map (fun x -> parseStringIdexExp x) listideexp;;

let rec parseCom s =
    let terminal, terminalRemain = parseTerminal s in
        let params, paramRemain = parseParam terminalRemain in
            match terminal with

                | "Assign" ->
                    let exp0, restexp0 = parseExp params in
                        let exp1, restexp1 = parseExp restexp0 in
                            Assign(exp0, exp1), paramRemain

                | "CIfThenElse" ->
                    let exp0, restexp0 = parseExp params in
                        let comlist1, restcomlist1 = parseComList restexp0 in
                            let comlist2, restcomlist2 = parseComList restcomlist1 in
                                CIfThenElse(exp0,comlist1,comlist2), restcomlist2

                | "Block" ->
                    let str0, remain0 = parseList params in
                        let str1, remain1 = parseList remain0 in
                            let comList, remain2 = parseComList remain1 in
                                let ideexplist1 = parseIdexExpList (splitListElement str0) in
                                    let ideexplist2 = parseIdexExpList (splitListElement str1) in
                                        Block(ideexplist1, ideexplist2, comList), remain2

                (*
                | "Block" ->
                    let str0, remain0 = parseList params in
                        let str1, remain1 = parseList remain0 in
                            let comList, remain2 = parseComList remain1 in
                                let ideexplist1 = parseIdexExpList (splitListElement str0) in
                                    Block(ideexplist1, comList), remain2
                *)

                | "While" ->
                    let exp0, restexp0 = parseExp params in
                        let comlist1, restcomlist1 = parseComList restexp0 in
                            While(exp0, comlist1), restcomlist1

                | "Call" ->
                    let exp0, restexplist = parseExp params in
                        let exp1list, restexplist1 = parseExpList restexplist in
                            Call (exp0,exp1list), restexplist1

                | "Reflect" ->
                    let ide,remain = parseIde params in
                        Reflect (ide), remain

                | _ -> failwith ("Error in parsing: " ^ s)

and parseComList stringToParse =
    let comList, remain = parseList stringToParse in
        let rec parseCommands (toExtract: string) (extracted: com list) =
            if String.trim toExtract = ""
                then extracted
            else
                let parsed, remain = parseCom toExtract in
                    parseCommands remain (parsed :: extracted)
        in parseCommands comList [], remain

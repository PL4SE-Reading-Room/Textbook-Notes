type term =
    TmVar of info * int * int 
    (* extra number: contain the total length of the context 
       in which the variable occurs, for consistency check.
     *)
  | TmAbs of info * string * term
    (* name of variable for printing
     *)
  | TmApp of info * term * term

type context = (string * binding) list
type binding = NameBind

(* 7.1 Printing routine *)
let rec printtm ctx t = match t with
    TmAbs(fi,x,t1) ->
      let (ctx',x') = pickfreshname ctx x in
      pr "(lambda "; pr x'; pr ". "; printtm ctx' t1; pr ")"
  | TmApp(fi,t1,t2) ->
      pr "("; printtm ctx t1; pr " "; printtm ctx t2; pr ")"
  | TmVar(fi,x,n) ->
      if ctxlength ctx = n then
        pr (index2name fi ctx x)
      else
        pr "[bad index]"

(* 7.2 Shifting and Substitution *)
let termShift d t =
  let rec walk c t = match t with
    TmVar(fi,x,n) -> if x>= c then TmVar(fi,x+d,n+d)
                     else TmVar(fi,n+d)
  | TmAbs(fi,x,t1) -> TmAbs(fi,x,walk (c+1) t1)
  | TmApp(fi,t1,t2) -> TmApp(fi,walk c t1,walk c t2)
  in walk 0 t

let termSubst j s t =
  let rec walk c t = match t with
    TmVar(fi,x,n) -> if x=j+c then termShift c s else TmVar(fi,x,n)
  | TmAbs(fi,x,t1) -> TmAbs(fi,x,walk (c+1) t1)
  | TmApp(fi,t1,t2) -> TmApp(fi,walk c t1,walk c t2)
  in walk 0 t

(* 7.3 Evaluation *)
let rec isval ctx t = match t with
    TmAbs(_,_,_) -> true
  | _ -> false

(* single-step evaluation *)
exception NoRuleApplies

let rec eval1 ctx t = match t with
    TmApp(fi,TmAbs(_,x,t12),v2) when isval ctx v2 ->
      termSubst v2 t12
    | TmApp(fi,v1,t2) when isval ctx v1 ->
      let t2' = eval1 ctx t2 in
      TmApp(fi,v1,t2')
    | TmApp(fi,t1,t2) ->
      let t1' = eval1 ctx t1 in
      TmApp(fi,t1',t2)
    | _ -> raise NoRuleApplies

(* multi-step evaluation *)
let rec eval ctx t =
  try let t' = eval1 ctx t
      in eval ctx t'
  with NoRuleApplies -> t
# Files de Priorité

## En OCaml
### Fichier d'en-tête
```ml
type ('a,'b) priority_queue ;;

val create : unit -> ('a,'b) priority_queue ;;
val init : 'a array -> 'b -> ('a,'b) priority_queue ;;
val add : ('a,'b) priority_queue -> 'a -> 'b -> unit ;;
val min :  ('a,'b) priority_queue -> 'b * 'a ;;
val extract_min :  ('a,'b) priority_queue -> 'b * 'a ;;
val update_priority :  ('a,'b) priority_queue -> 'a -> 'b -> unit ;;
val is_empty : ('a, 'b) priority_queue -> bool;;
val get : ('a, 'b) priority_queue -> 'a -> 'b * 'a;;
val has : ('a, 'b) priority_queue -> 'a -> bool;;
```
### Implémentation
```ml
module Darray = Dynamic_array;;

type ('a,'b) priority_queue = {heap: ('b * 'a) Darray.dynamic_array; locate: ('a, int) Hashtbl.t};;

(*
  val create : unit -> ('a,'b) priority_queue;;
  val init : 'a array -> 'b -> ('a,'b) priority_queue;;
  val add : ('a,'b) priority_queue -> 'a -> 'b -> unit ;;
  val min :  ('a,'b) priority_queue -> 'a * 'b ;;
val extract_min :  ('a,'b) priority_queue -> 'a * 'b ;;
val update_priority :  ('a,'b) priority_queue -> 'a -> 'b -> unit ;;
*)

let create () = {heap = Darray.create (); locate = Hashtbl.create 100};;

let is_empty pq = Darray.is_empty pq.heap;;

let get pq e = Darray.get pq.heap (Hashtbl.find pq.locate e);;

let has pq e =
    match Hashtbl.find_opt pq.locate e with
    | None -> false
    | _ -> true;;

let swap pq i1 i2 =
  let e1 = Darray.get pq.heap i1 in
  let e2 = Darray.get pq.heap i2 in
  Darray.set pq.heap i1 e2;
  Darray.set pq.heap i2 e1;
  Hashtbl.add pq.locate (snd e2) i1;
  Hashtbl.add pq.locate (snd e1) i2;;

let rec percolate_up pq i =
  let e = Darray.get pq.heap i in
  let i_father = (i-1)/2 in
  let father = Darray.get pq.heap i_father in
  if e < father then begin
    swap pq i i_father;
    percolate_up pq i_father;
  end;;

let add pq e prio =
  Darray.append pq.heap (prio, e);
  let i = (Darray.length pq.heap - 1) in
  percolate_up pq i;
  Hashtbl.add pq.locate e i;;

let init a prio =
  let pq = create () in
  for i = 0 to (Array.length a) - 1 do
    Darray.append pq.heap (prio, a.(i));
    Hashtbl.add pq.locate a.(i) i;
  done;
  pq;;

let min pq = Darray.get pq.heap 0;;

let rec percolate_down pq i =
  let e = Darray.get pq.heap i in
  let i_child1 = 2*i+1 in
  let i_child2 = 2*i+2 in 
  
  if i_child1 >= Darray.length pq.heap then ();
  let child1 = Darray.get pq.heap i_child1 in
  
  if i_child2 >= Darray.length pq.heap then begin
    if e < child1 then ()
    else swap pq i i_child1;
    percolate_down pq i_child1;
  end;
  
  let child2 = Darray.get pq.heap i_child2 in
  
  let new_i = ref i_child1 in
  if child1 < child2 then new_i := i_child2;
  
  swap pq i !new_i;
  percolate_down pq !new_i;;

let extract_min pq =
  let i = Darray.length pq.heap - 1 in
  let m = Darray.get pq.heap 0 in
  swap pq 0 i;
  ignore (Darray.pop pq.heap);
  percolate_down pq 0;
  m;; 

let update_priority pq e prio =
  let i = Hashtbl.find pq.locate e in
  let (last_prio, _) = Darray.get pq.heap i in
  Darray.set pq.heap i (prio, e);
  if last_prio < prio then percolate_up pq i
  else percolate_down pq i;;
```
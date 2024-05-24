# Tableaux Dynamiques

## En OCaml
### Fichier d'en-tête
```ml
type 'a dynamic_array ;;

val create : unit -> 'a dynamic_array ;;
val init : 'a array -> 'a dynamic_array ;;
val is_empty : 'a dynamic_array -> bool;;

val length : 'a dynamic_array -> int ;;
val get : 'a dynamic_array -> int -> 'a ;;
val set : 'a dynamic_array -> int -> 'a -> unit ;;

val append : 'a dynamic_array -> 'a -> unit ;;
val pop : 'a dynamic_array -> 'a ;;
```
### Implémentation
```ml
type 'a dynamic_array = {mutable tab:'a array; mutable len:int};;

let create () = {tab = [||]; len = 0};;

let init a = {tab = a; len = Array.length a};;

let length d = Array.length d.tab;;

let get d = Array.get d.tab;;

let set d = Array.set d.tab;;

let is_empty d = d.len = 0;;

let append d e = 
  let n = length d in
  if n = d.len
  then begin
    let new_len = max (n*2) 1 in
    let new_tab = Array.make new_len e in
    Array.blit d.tab 0 new_tab 0 d.len;
    d.tab <- new_tab;
  end; 
  set d n e;
  d.len <- d.len + 1;;

exception Empty_dynamic_array

let pop d =
  let n = length d in
  if d.len = 0 then raise Empty_dynamic_array;
  let last = get d (d.len-1) in
  d.len <- d.len - 1;
  if d.len * 4 < n then begin
    let new_len = n / 2 in
    let new_tab = Array.make new_len (get d 0) in
    Array.blit d.tab 0 new_tab 0 (d.len-1);
    d.tab <- new_tab;
  end;
  d.len <- d.len - 1;
  last;;
```
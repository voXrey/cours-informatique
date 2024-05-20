# Arbres Binaires de Recherche

## En OCaml
### Fichier d'en-tête
```ml
type 'a abr ;;

val empty_tree : 'a abr ;;
val is_empty : 'a abr -> bool ;;

val min_elt : 'a abr -> 'a ;;
val mem : 'a abr -> 'a -> bool ;;

val add : 'a abr -> 'a -> 'a abr ;;
val remove_min : 'a abr -> 'a * 'a abr ;;
val remove : 'a abr -> 'a -> 'a abr ;;
```
### Implémentation
```ml
type 'a abr =
  | Empty
  | Node of 'a abr * 'a * 'a abr;;

let empty_tree = Empty;;

let is_empty tree =
  match tree with
  | Empty -> true
  | _ -> false;;

let rec min_elt tree =
  match tree with
  | Empty -> failwith "Tree is empty"
  | Node (Empty, x, _) -> x
  | Node (left, _, _) -> min_elt left;;

let rec mem tree value =
  match tree with
  | Empty -> false
  | Node (_, x, _) when x = value -> true
  | Node (left, x, _) when value < x -> mem left value
  | Node (_, x, right) -> mem right value;;

let rec add tree value =
  match tree with
  | Empty -> Node (Empty, value, Empty)
  | Node (left, x, right) when value < x -> Node (add left value, x, right)
  | Node (left, x, right) when value > x -> Node (left, x, add right value)
  | _ -> tree;;

let rec remove_min tree =
  match tree with
  | Empty -> failwith "Tree is empty"
  | Node (Empty, x, right) -> (x, right)
  | Node (left, x, right) ->
      let min_val, new_left = remove_min left in
      (min_val, Node (new_left, x, right));;

let rec remove tree value =
  match tree with
  | Empty -> Empty
  | Node (left, x, right) when value < x -> Node (remove left value, x, right)
  | Node (left, x, right) when value > x -> Node (left, x, remove right value)
  | Node (left, _, Empty) -> left
  | Node (Empty, _, right) -> right
  | Node (left, _, right) ->
      let min_right, new_right = remove_min right in
      Node (left, min_right, new_right);;
```
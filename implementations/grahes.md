# Implémentation des Graphes

## Typage
### Matrices d'Adjacence
#### En OCaml
```ocaml
type graphe = int array array;;
```
#### En C
```c
typedef struct {int n; int** g;} graphe;
```
### Liste d'Adjacence
#### En OCaml
```ocaml
type graphe = int list list;;
```
#### En C
- Tableaux de structs : Trop difficile
- Indiquer la taille de chaque liste au premier indice
- Utiliser une sentinelle
### Dictionnaire d'Adjacence
A n'utilisez que si les sommets ne sont pas des entiers.

## Algorithmes de Parcours

### Algorithme impératif Générique
```ocaml
(* interface de notre module Bag *)
module type Bag = sig
  type 'a t
  val create : unit -> 'a t
  val add : 'a -> 'a t -> unit
  val take : 'a t -> 'a
  val is_empty : 'a t -> bool
end;;

(* recherche générique *)
let whatever_first_search g s =
  let n = List.length g in
  let visited = Array.make n false in
  let bag = Bag.create () in
  Bag.add s bag;

  while not (Bag.is_empty bag) do
    let u = Bag.take bag in
    if not visited.(u) then (
      visited.(u) <- true;
      foo (); (* faire l'action *)
      List.iter (fun v -> Bag.add v bag) (List.nth g u)
    )
  done;;
```
On retiendra
- profondeur : Stack
- largeur : Queue 

### Profondeur
#### En OCaml
##### Récursif
```ocaml
type graphe = int list list

let dfs (g : graphe) =
  let n = List.length g in
  let visited = Array.make n false in

  let rec visite u =
    if not visited.(u) then (
      visited.(u) <- true;
      foo (); (* faire une action *)
      List.iter visite (List.nth g u);
    )
  in

  for u = 0 to n - 1 do
    visite u
  done;;
```
##### Impératif
```ocaml
type graphe = int list list

(* utilisation des piles *)
let dfs (g : graphe) u0 =
  let n = List.length g in
  let visited = Array.make n false in
  let stack = Stack.create () in

  (* Initialisation de la pile avec un seul sommet *)
  Stack.push u0 stack;

  (* Boucle principale *)
  while not (Stack.is_empty stack) do
    let u = Stack.pop stack in
    if not visited.(u) then (
      foo (); (* faire l'action *)
      visited.(u) <- true;
      List.iter (fun v -> Stack.push v stack) (List.nth g u)
    )
  done;;
```
### Largeur
#### En OCaml
```ocaml
(* Type de graphe : liste d'adjacence *)
type graphe = int list list

(* Fonction de parcours en largeur *)
let bfs (g : graphe) u0 =
  let n = List.length g in
  let visited = Array.make n false in
  let queue = Queue.create () in

  (* Un seul sommet au départ *)
  Queue.push u0 queue;
  visited.(u0) <- true;

  (* Boucle principale *)
  while not (Queue.is_empty queue) do
    let u = Queue.pop queue in
    foo (); (* faire l'action *)
    List.iter (fun v ->
      if not visited.(v) then (
        visited.(v) <- true;
        Queue.push v queue
      )
    ) (List.nth g u)
  done;;
```

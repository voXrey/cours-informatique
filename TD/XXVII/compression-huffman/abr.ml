type 'a abr = Nil | Node of 'a * 'a abr * 'a abr ;;

(* Vérification qu'un arbre binaire est un ABR *)
let rec is_abr tree =
    let rec is_subtree_abr tree min max =
        match tree with
        | Nil -> true
        | Node (value, left, right) ->
            value >= min && value <= max &&
            is_subtree_abr left min value &&
            is_subtree_abr right value max
    in
    is_subtree_abr tree min_int max_int

(* Recherche d'un élément dans un ABR *)
let rec mem tree x =
    match tree with
    | Nil -> false
    | Node (value, left, right) ->
        if x = value then true
        else if x < value then mem left x
        else mem right x

(* Insertion d'un élément dans un ABR *)
let rec insert tree x =
    match tree with
    | Nil -> Node (x, Nil, Nil)
    | Node (value, left, right) ->
        if x < value then Node (value, insert left x, right)
        else if x > value then Node (value, left, insert right x)
        else tree (* Already exists, so no change *)

(* Min et max *)
let rec min tree =
    match tree with
    | Nil -> failwith "Empty tree"
    | Node (value, Nil, _) -> value
    | Node (_, left, _) -> min left

let rec max tree =
    match tree with
    | Nil -> failwith "Empty tree"
    | Node (value, _, Nil) -> value
    | Node (_, _, right) -> max right

(* Predecesseur et successeur *)
let rec pred tree x =
    match tree with
    | Nil -> failwith "Element not found"
    | Node (value, left, right) ->
        if x = value then max left
        else if x < value then pred left x
        else
            let res = pred right x in
            if res = x then value else res

let rec succ tree x =
    match tree with
    | Nil -> failwith "Element not found"
    | Node (value, left, right) ->
        if x = value then min right
        else if x > value then succ right x
        else
            let res = succ left x in
            if res = x then value else res

(* Suppression *)
let rec del tree x =
    match tree with
    | Nil -> Nil
    | Node (value, left, right) ->
        if x < value then Node (value, del left x, right)
        else if x > value then Node (value, left, del right x)
        else
            match left, right with
            | Nil, _ -> right
            | _, Nil -> left
            | _, _ ->
                let replacement = min right in
                Node (replacement, left, del right replacement)

(* Tri par ABR *)
let abr_sort arr =
    let rec to_list tree acc =
        match tree with
        | Nil -> acc
        | Node (value, left, right) -> to_list left (value :: to_list right acc)
    in
    let rec from_list lst =
        match lst with
        | [] -> Nil
        | hd :: tl -> insert (from_list tl) hd
    in
    let sorted_list = to_list (from_list (Array.to_list arr)) [] in
    Array.iteri (fun i x -> arr.(i) <- x) sorted_list

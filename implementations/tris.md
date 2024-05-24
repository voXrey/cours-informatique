# Implémentation des Tris
## Tri fusion
### Listes OCaml

```ocaml
let rec divide = function
    | [] -> [],[]
    | [e] -> [e],[]
    | a::b::l ->
    let (l1,l2) = divide l in
    (a::l1, b::l2);;

let rec fusion l1 l2 = match l1,l2 with
    | [],l2 -> l2
    | l1,[] -> l1
    | h1::t1, h2::t2 when h1 < h2 -> h1 :: (fusion t1 (h2::t2))
    | h1::t1, h2::t2              -> h2 :: (fusion (h1::t1) t2);;

let rec fusion_sort l =
    (*Cas de base*)
    if List.length l < 2 then l
    else
        (*DIVISER*)
        let (l1,l2) = divide l in
        (*REGNER*)
        let (l3,l4) = (fusion_sort l1, fusion_sort l2) in
        (*COMBINER*)
        fusion l3 l4;;   
```

#### Tableaux OCaml

```ocaml
let divide_arr a =
    let len = Array.length a in
    let l1 = Array.init (len/2) (fun i -> a.(i)) in
    let l2 = Array.init (len-len/2) (fun i -> a.(len-1-i)) in
    l1,l2;;

let fusion_arr a1 a2 =
    let n1 = Array.length a1
    and n2 = Array.length a2 in
    let n = n1 + n2 in
    if n1 + n2 = 0 then
        [||]
    else
        let a = Array.make n (if n1 = 0 then a2.(0) else a1.(0)) in
        let i = ref 0 (* indice de a1 *)
        let j = ref 0 (* indice de a2 *)
        let k = ref 0 (* indice de a *)
        in
        while !k < n do
            (* Invariant : k = i + j *)
            if !i < n1 && (!j = n2 || a1.(!i) <= a2.(!j)) then (
                a.(!k) <- a1.(i);
                incr i
            ) else if !j < n2 && (!i = n1 || a2.(!j) < a1.(!i)) then (
                a.(!k) <- a2.(!j);
                incr j
            );
            incr k
        done;
        a;;

let rec fusion_sort_arr a =
    (* CAS DE BASE *)
    if Array.length a < 2 then
        a
    else
        (* DIVISER *)
        let (a1,a2) = divide_arr a in
        (* REGNER *)
        let (a3,a4) = (fusion_sort_arr a1, fusion_sort_a2) in
        (* COMBINER *)
        fusion_arr a3 a4;;
```

## Tri rapide
### Listes OCaml

```ocaml
let rec partition p = function
    | [] -> [],[]
    | h::t when h <= p ->
        let (l1,l2) = partition p t in
        (h::l1, l2)
    | h::t ->
        let (l1,l2) = partition p t in
        (l1, h::l2);;

let rec quicksort = function
    | [] -> [] (* CAS DE BASE *)
    | [a] -> [a]
    | h::t ->
        (* DIVISER *)
        let (l1, l2) = partition h t in
        (* REGNER *)
        let (l3,l4) = (quicksort l1, quicksort l2) in
        (* COMBINER *)
        l3 @ (h::l4);;
```

### Tableaux OCaml

```ocaml
let swap a i j =
    let tmp = a.(i) in
    a.(i) <- a.(j);
    a.(j) <- tmp;;

let partition a i j =
    (* On sauvegarde le pivot *)
    let p = a.(i) in
    swap a i (j-1); (* On place le pivot en fin de portion : *)
    (* On découpe la portion a[i:j] en trois parties
       - les plus petits que p
       - les plus grands que p
       - p
       On définit 2 indices k et l avec l'invariant de boucle :
       - a[i:k] est la portion des petits
       - a[l:j] est la portion des grands
       - k < l
       - le pivot est en position l-1
    *)
    let k = ref i
    and l = ref j in
    (* A la fin, les portions doivent se toucher au privot, cad l=k+1 *)
    while !k <> !l-1 do
        if a.(!k) > p then begin
            if !k <> l-2 then
                swap a (!l-1) (!l-2); (* On remplace le pivot *)
            swap a !k (!l-1); (* On place a.(k) dans la portion des grands *)
            decr l (* On redimensionne la portion des grands *)
        end else
            (* Sinon a.(k) est déjà à sa place et on redimensionne celle des petits *)
            incr k
    done;
    (* A la fin, l'invariant implique que le pivot est à sa place : inutile de replacer p *)
    !l-1;; (* On renvoie l'indice du pivot *)

let partition_cormen a i j =
    (* Sauvegarde du pivot :
    ils prennent comme pivot le dernier élément de la tranche a[i:j] *)
    let p = a.(j-1) in
    let k = ref (i-1) in
    for l = i to j-2 do
        if a.(l) <= p then begin
            incr k;
            swap a !k l
        end
    done;
    swap a (!k+1) (j-1);
    !k+1;;
    (* Invariant de boucle :
       - a[i:k+1] est la portion des petits
       - a[k+1:l] est la portion des grands
       - le pivot est en case j-1
    *)

let rec quicksort_aux a i j =
    (* Cas de base : si j <= i+1 alors a[i:j] est vide ou n'a qu'un élément
    --> rien à faire*)
    if j > i+1 then begin
        (* DIVISER *)
        let p = partition a i j in
        (* REGNER *)
        quicksort_aux a i p;
        quicksort_aux a (p+1) j;
        (* COMBINER *)
        ()
    end;;
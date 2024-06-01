# Exceptions OCaml

Ce sont des erreurs, lorsqu'une exception est lancée, cela interrompt tout le programme.

* `failwith` lance une exception

* `Not_found`, `Invalid_argument`, `Failure`... sont des exceptions

On peut définir ses propres exceptions :

```ocaml
exception Nadine;;
```

Ce sont des constructeurs !

On peut lancer une exception avec `raise` :

```ocaml
raise Nadine;;
```

On peut donner des arguments à nos exceptions :

```ocaml
exception Nadine of int;;

raise (Nadine 12);;
```

> `Failure` et `Invalid_argument` prennent en argument une *string*.

En fait, la fonction `failwith` est codée de cette manière :

```ocaml
let failwith S = raise (Failure S);;
```

On peut <u>rattraper</u> les exceptions :

```ocaml
try:
    (* instructions renvoyant du 'a *)
    foo ();
    ....
with
    (* Ce pattern matching renvoie également du 'a *)
    | Failure s -> bar ()
    | Nadine s -> nad ()
```

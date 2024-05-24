# Algorithme de Dijkstra

## En OCaml
```ml
module Nadine = Priority_queue;;

let dijkstra g s =
    let n = Array.length g in
    let pq = Nadine.init (Array.init n (fun i -> i)) infinity in
    let distances = Array.make n infinity in
    Nadine.update_priority pq s 0.;

    while not (Nadine.is_empty pq) do
        let (prio_u,u) = Nadine.extract_min pq in

        distances.(u) <- prio_u;

        for i = 0 to (Array.length g.(u) - 1) do
            let (v, pond_v) = g.(u).(i) in
            let min_d = prio_u +. pond_v in
            if min_d < distances.(v) then
                Nadine.update_priority pq v min_d
        done;
    done;
    distances;;
```
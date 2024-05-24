open Abr ;;

type ('a,'b) priority_queue = ('a, 'b) abr ref;;

let create () = ... ;;

let is_empty pq = true ;;
let mem pq elt = true ;;

let add pq elt prio = () ;;
let min pq = failwith "A implementer" ;;
let extract_min pq = failwith "A implementer" ;;

let priority pq elt = failwith "A implementer et donner sa complexite" ;;

(* Seule instruction à NE PAS implémenter : *)
let update_priority pq elt prio = 
    failwith "Not Implemented" ;;

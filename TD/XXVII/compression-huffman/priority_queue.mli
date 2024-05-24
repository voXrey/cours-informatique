type ('a,'b) priority_queue ;;

val create : unit -> ('a,'b) priority_queue ;;
val is_empty :  ('a,'b) priority_queue -> bool ;;
val mem :  ('a,'b) priority_queue -> 'a -> bool ;;

val add : ('a,'b) priority_queue -> 'a -> 'b -> unit ;;
val min :  ('a,'b) priority_queue -> 'a * 'b ;;
val extract_min :  ('a,'b) priority_queue -> 'a * 'b ;;

val priority :  ('a,'b) priority_queue -> 'a -> 'b ;;
val update_priority :  ('a,'b) priority_queue -> 'a -> 'b -> unit ;;

(* LISEZ BIEN LES CONSIGNES *)

(* COMMENCEZ par indiquer ici la commande de compilation qui permet de produire 
l'exécutable demandé.*)

(* CONCERNANT LA FERMETURE DE FICHIERS, voir ligne 45 *)



open Hashtbl

(* Table des décalages = table de hachage dont les clés sont des caractères et les valeurs des entiers *)
type offset = (char, int) t ;; 

(* Pour la version améliorée, les clés sont des string *)
type offset2 = (string, int) t ;; 



                    (* I - Lecture et écriture de l'offset *)


(*  Entrée : s string et c char
    Sortie : une liste [s1; s2; ...; sk] de string telles que 
    s = s1 ^ c ^ s2 ^ c ^ s3 ... ^ c ^ sk 
    et le caractere c n'apparait dans aucune chaine s1, ..., sk
*)
let split s c =
  List.init ((String.length s)/2 + (String.length s) mod 2) (fun i -> s.[2*i]);;
    


let read_offset filename = 
    let f = open_in filename in
    let offset = create 20 in
    try
        while true do
            let s = input_line f in
            let assoc = split s ':' in
            let rec aux = function
                | [] -> ()
                | h::[] -> ()
                | a::b::t -> add offset a b;
                aux t;
            in aux assoc;
        done ; 
        offset (* LIGNE OBLIGATOIRE POUR RAISON DE TYPAGE *)
    with
        | End_of_file -> close_in f; offset
        (* BONNE PRATIQUE : pour assurer la fermeture du fichier f, 
        on rattrape TOUTES les exceptions, on ferme, puis on relance 
        l'exception rattrapée *)
        | exn -> close_in f; raise exn;;


let write_offset offset filename = 
  let f = open_out filename in
  Hashtbl.iter (fun a b -> output_string f (a^":"^b));;
            (* II - CALCUL DE L'OFFSET *)
            
let compute_offset m = 
    let offset = create 20 in

    

    offset ;;
    
    
            (* III - ALGORITHME DE BOYER MOORE *)
            
            
(* m : motif, t : texte, offset : table des décalage *)            
let boyer_moore m t offset =     
    () ; 
    0 ;;
    



(* Fonction Main *)

let main () = 
    let argv = Sys.argv in
    let argc = Array.length argv in
    
    (* Lecture de l'offset si existe *)
    let offset = read_offset "offset"

    (* Création + écriture de l'offset sinon *)


    (* Appel à Boyer Moore *)
    (* Impression Réponse *)
    
    ();;
    
    
main () ;;
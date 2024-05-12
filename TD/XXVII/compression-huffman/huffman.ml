(* On suppose que le texte est écrit uniquement avec des caractères ASCII. *)


            (* I - LECTURE *)
            
(* Lit un fichier et retourne le txt + le tableau des fréquences *)            
let read_txt_and_frequencies filename = 
  () ;
  ("", [||])
  
          (* II - ECRITURE *)

(* Ecrit un txt dans un fichier*)
let write txt filename = 
  () ;;
  

          (* III - CONVERSION BINAIRE--STRING *)
          
(* Comme OCAML ne sait manipuler que des octets et pas des bits directement, il faut donc ruser : 

Vous devez écrire une fonction qui convertit une string ne contenant que des caractères '0' et '1', les lit 
8 par 8 et produit une chaine de caractère dont l'écriture en mémoire sera exactement celle que l'on veut.

Réciproquement, étant donné une string quelconque s, on veut produire la string OCaml 
ne contenant que des '0' et des '1' qui correspond à la représentation mémoire de s. 

*)

let convert_to_bin s = 
  "" ;;
  
let convert_from_bin b = 
  "" ;;


  
          (* III - Compression *)

type codage = Leaf of char | Node of codage * codage ;;
          
          
(*  Entrée : le tableau des fréquences des char dans le texte 
  Sortie : le codage optimal sous forme d'arbre *)
  
let code_huffman frequencies =
  Leaf 'a' ;;
  
(* Convertit un codage sous forme d'arbre en un tableau de longueur 256 tel que 
t.(i) donne le mot de {0,1}* qui code le caractère numéro i *)    
let tree_to_array c =    
  [||] ;;
  
  
(* Compresse le txt selon le codage c, donné sous forme de tableau *)    
let compress txt c =
  "" ;;
  
  
          (* IV - Décompression *)
  
  
(* Decompresse le txt selon le codage c, donné sous forme d'arbre *)
let decompress txt c = 
  "" ;;
  
  
  
          (* V - MAIN *)
          
          
let main () = 
  (* On récupère le txt dans le fichier donné par Sys.argv *)
  (* On le compresse optimalement *)
  (* On écrit la compression dans un fichier *)
  (* On lit la compression et on la décompresse *)
  (* On compare au fichier d'origine pour détecter les erreurs *)
  (* On output les tailles des fichiers d'origine et de compression et on admire. *)
  () ;;
  
  
main () ;;
          
  
  
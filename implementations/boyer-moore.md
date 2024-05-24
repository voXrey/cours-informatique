# Algorithme de Boyer-Moore

## En C
```c
#define ALPHABET_SIZE   256     // taille de l'alphabet ASCII

/**
 * Implémentation de Boyer-Moore-Horspool
 *
 * Note : retourne directement la position du premier pattern trouvé dans text, sinon -1
 */
int bmh(char *text, char *pattern)
{
        unsigned int skip_table[ALPHABET_SIZE];
        ssize_t tsize, psize;
        int i;

        tsize = strlen(text);
        psize = strlen(pattern);

        /* pré-traitement */
        /** remplir la table avec la valeur de saut maximum */
        for (i = 0; i < ALPHABET_SIZE; i++)
                skip_table[i] = psize;

        /** puis calculer pour chaque caractère de pattern le saut */
        for (i = 0; i < psize - 1; i++)
                skip_table[(int) pattern[i]] = psize - i - 1;

        /* recherche */
        i = 0;
        while (i <= tsize - psize) {
                if (text[i + psize - 1] == pattern[psize - 1])
                        if (memcmp(text + i, pattern, psize - 1) == 0)
                                return i;

                /* si les deux caractères comparés sont différents, 
                sauter en utilisant la valeur de la table de saut à
                l'index du caractère de text */
                i += skip_table[(int) text[i + psize - 1]];
        }

        return -1;
}
```

## En OCaml
```ml
let ALPHABET_SIZE = 256;;

let jump_table pattern =
  let m = String.length pattern in
  let table = Array.make ALPHABET_SIZE m in
  (* Remplit la table avec les sauts appropriés pour chaque caractère du motif, sauf le dernier *)
  for i = 0 to m - 2 do
    table.(Char.code pattern.[i]) <- m - 1 - i
  done;
  table;;

let bmh text pattern =
  let n = String.length text in
  let m = String.length pattern in
  (* Si le motif est vide, retourne 0 (on considère qu'un motif vide est trouvé à l'index 0) *)
  if m = 0 then 0
  else
    let bad_char = jump_table pattern in
    (* Fonction récursive de recherche *)
    let rec search i =
      (* Si l'index i dépasse la limite où le motif pourrait être trouvé, retourne -1 *)
      if i > n - m then -1
      else
        (* Fonction récursive pour comparer les suffixes *)
        let rec match_suffix j =
          (* Si j < 0, cela signifie que le motif a été entièrement trouvé *)
          if j < 0 then i
          (* Si les caractères correspondent, continue à comparer *)
          else if text.[i+j] = pattern.[j] then match_suffix (j-1)
          (* Sinon, effectue un saut basé sur la table de mauvais caractères *)
          else search (i + bad_char.(Char.code text.[i+m-1]))
        in
        match_suffix (m-1)
    in
    search 0;;
```
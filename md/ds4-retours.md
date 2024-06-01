# DS 4 : Retours

## Exercice 1

```c
// Type du sujet
struct cell {int value; struct cell* next;};
typedef struct cell cell;
typedef cell* list;

// Erreur
cell new;
new.value;
// Correction
list new = malloc(...); // ou list
(*new).value;
new->value;
```

Pour l'algorithmique il fallait bien choisir le `first` et le `last` par rapport au `next` (ou vice-versa) pour conserver le O(1).

Il n'y a pas de maillon sentinelle dans cet exercice.

Il ne fallait pas oublier les `free`.

A chaque accès pointeur il faut vérifier si l'accès est valide (cas extrêmes par exemple).

## Exercice 2

À reprendre

Erreurs sur la quantité à déterminer.

Erreurs de calcul.

## Exercice 3

3.1 question 2 à reprendre

Erreurs d'accès à ne plus commettre, utiliser un invariant de boucle permet de vérifier.

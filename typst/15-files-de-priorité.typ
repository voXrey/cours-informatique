#set text(font: "Roboto Serif")

= Partie III - Structure de Données <partie-iii---structure-de-données>
= Chapitre 15 : Files de Priorités <chapitre-15-files-de-priorités>
== I - Tas Binaire <i---tas-binaire>
Soit X un ensemble ordonné

Définition : Un tas binaire est un arbre binaire presque complet ayant la propriété de tas.

#quote(
  block: true,
)[
  Presque complet : tous les étages sont pleins sauf éventuellement le dernier qui est alors "rempli de gauche à droite" (voir exemple).

  Propriété de tas :

  - Tas-max : un élément de l’arbre est plus grand que ses (deux) fils.

  - Tas-min : un élément est plus petit que ses fils.
]

Voyons un exemple.

```mermaid
graph TB;
    A((13))-->B((8))
    A-->C((12));
    B-->E((4))
    B-->F((2))
    C-->H((3))
    C-->I((7))
    E-->J((2))
    E-->K((3))
    F-->L((1))
```

Important : Dans le dernier étage "il n’y a pas de trou", si un nœud de l’étage h-1 n’a pas deux enfants, alors tous les nœuds à sa droite n’ont pas d’enfant.

#quote(block: true)[
  Remarque : appellation tas-max car le max est à la racine
]

=== Implémentation des Tas Binaires <implémentation-des-tas-binaires>
==== Tableau <tableau>
Ceci est possible justement parce que l’arbre est presque complet. Si un noeud est stocké en case $i$ du tableau, alors son fils gauche se trouve en case $2 i + 1$ et son fils droit en $2 i + 2$.

On place la racine en case 0.

Sur l’exemple

#figure(align(center)[#table(
    columns: 10,
    align: (col, row) => (
      center,
      center,
      center,
      center,
      center,
      center,
      center,
      center,
      center,
      center,
    ).at(col),
    inset: 6pt,
    [0],
    [1],
    [2],
    [3],
    [4],
    [5],
    [6],
    [7],
    [8],
    [9],
    [13],
    [8],
    [12],
    [4],
    [2],
    [3],
    [7],
    [2],
    [3],
    [1],
  )])

#quote(block: true)[
  Remarque : Cela correspond à un parcours en largeur.
]

Opérations

- Ajouter un élément au tas

- Supprimer la racine

===== 1. Ajout <ajout>
Pour simplifier on suppose avoir des tableaux dynamiques.

====== Algorithme auxiliaire <algorithme-auxiliaire>
On aura besoin d’une opération auxiliaire : `percolate_up`.

Spécification `percolate_up` :

- Précondition : l’arbre manipulé est presque un tas : il y a au plus un nœud qui pose problème ; il est plus grand que son père.

- Postcondition : l’arbre est un tas binaire qui contient les mêmes éléments qu’au départ.

```md
Algorithme percolate_up :
Tant que le noeud "pointé" pose problème
    Echanger ce noeud avec son père
```

Correction : Lors d’un échange, le nœud qui prend la place de son père est plus grand que son frère gauche par transitivité. La preuve est assez évidente, la précondition est vérifiée : il y a au plus un problème dans l’arbre, entre l’élément remonté et son nouveau père.

Complexité : A chaque étape le nœud pointé remonte d’un étage, donc l’algorithme est en O\(h\(t)). Sauf qu’ici, soit n le nombre d’éléments) comme l’arbre est presque complet, on a : $2^(h lr((t))) - 1 < n lt.eq 2^(h lr((t)) + 1) - 1$

Donc $h lr((t))$ \~ $l o g lr((n))$

Autre façon de le voir

Si un nœud se trouve en case $i$ du tableau, son père est en case $frac(i - 1, 2)$ du tableau. Donc notre algorithme a pour variant la quantité $l o g_2 lr((i + 1))$ donc une complexité $O lr((l o g_2 lr((i + 1))))$.

====== Algorithme principal <algorithme-principal>
On ajoute un élément en dernière case du tableau (que l’ont étend si nécessaire) et on appelle `percolate_up` sur ce dernier nœud.

==== 2. Suppression de la racine <suppression-de-la-racine>
Algorithme

- On remplace a racine par l’élément le plus à droite dans le tableau

- On appelle `percolate_down`

Algorithme `percolate_down`

```markdown
Tant que le noeud pointé pose problème
    On échange le noeud avec le plus grand de ses fils
```

Précondition / Invariant de boucle : L’arbre est un tas sauf éventuellement au niveau du nœud pointé.

Complexité : $O lr((h lr((t)))) = O lr((l o g lr((n))))$

== II - Tri Par Tas <ii---tri-par-tas>
Deux étapes

#block[
  #set enum(numbering: "1)", start: 1)
  + On transforme le tableau initial en un tas

  + On extrait successivement le max et on le range à sa place
]

Exemple : $a = { 13 , 8 , 1 , 7 , 18 , 4 , 0 , 12 }$

+ Invariant de boucle : $a lr([0 : i + 1])$ est un tas

  $i = 0$ : 13 8 1 7 18 4 0 12

  $i = 1$ : 13 8 1 7 18 4 0 12

  $i = 2$ : 13 8 1 …

  $i = 3$ : 13 8 1 7 18 …

  $i = 4$ : 18 13 1 7 8 4 0 12 (flèche de 8 à 13 puis à 18)

  $i = 5$ : 18 13 4 7 8 1 0 12 (flèche de 1 à 4)

  $i = 6$ : 18 13 4 7 8 1 0 12

  $i = 7$ : 18 13 4 12 8 1 0 7 (flèche de 7 à 12 et de 12 à 13)

  Pour $i = 0$ à $n - 1$ : `percolate_up(i)`

  Complexité : Chaque `percolate(i)` est en $O lr((l o g lr((i)))) lt.eq O lr((l o g lr((n))))$ donc le total est en $O lr((n l o g lr((n))))$.

+ Extraction du max (on remplace 7 et 18) puis on effectue `percolate_down`

  Invariant : $a lr([0 : i])$ est un tas binaire et $a lr([i : n])$ est trié et contient des éléments supérieurs à ceux de $a lr([0 : i])$.

  Algorithme :

  ```markdown
    Pour i = n à 1
        Échanger a[0] et a[i-1]
        taille du tas -= 1
        percolate_down(0)
    ```

  Complexité : $O lr((n l o g lr((n))))$

Conclusion : Complexité temporelle en $O lr((n l o g lr((n))))$ et spatiale en $O lr((1))$

== III - Files de Priorités <iii---files-de-priorités>
Définition : #strong[Structure abstraite] qui permet de stocker des éléments munis d’une priorité.

Opérations

- Créer une file de priorité vide

- Ajouter un élément et sa priorité dans la file

- Extraire l’élément de priorité dans la file

- Tester si la file est vide

- Déterminer le minimum de la liste

- Mettre à jour une priorité pour la remplacer par une priorité plus faible

=== 1. Implémentations naïves <implémentations-naïves>
#figure(
  align(
    center,
  )[#table(
      columns: 5,
      align: (col, row) => (center, center, center, center, center,).at(col),
      inset: 6pt,
      [],
      [Min],
      [Extract Min],
      [Update Prio],
      [Add],
      [Tableaux triés par priorité],
      [$O lr((1))$],
      [$O lr((1)) \*$],
      [$O lr((n))$],
      [$O lr((n))$],
      [Liste chaînée non triée],
      [$O lr((n))$],
      [$O lr((n))$],
      [$O lr((1))$],
      [$O lr((1))$],
      [ABR équilibré],
      [$O lr((l o g lr((n))))$],
      [$O lr((l o g lr((n))))$],
      [$O lr((l o g lr((n))))$],
      [$O lr((l o g lr((n))))$],
    )],
)

#emph[On note ] l’utilisation d’un tableau dynamique\*

=== 2. Implémentation via les tas binaires <implémentation-via-les-tas-binaires>
Créer une file vide : on crée un tas vide

File vide : facile

Trouver le minimum : il faut utiliser un `tas-min` $O lr((1))$

Extraire le minimum : cela correspond à la suppression de la racine d’un tas binaire $O lr((l o g lr((n))))$

Ajout d’un élément : ajout dans un tas binaire $O lr((l o g lr((n))))$

Mise à jour d’une priorité

- On met à jour la priorité

- Si la nouvelle priorité est inférieure à l’ancienne on appelle `percolate_up` $O lr((l o g lr((n))))$

  Sinon, on appelle `percolate_down` $O lr((l o g lr((n))))$

=== 3. Remarque importante sur l’implémentation <remarque-importante-sur-limplémentation>
Dans les tas binaires, les nœuds contiennent une valeur dans un ensemble X donné (c’est un `'a tas_binaire`).

Ici, les étiquettes des nœuds sont des couples `(élément, priorité)`, la priorité joue le rôle de clé et l’élément de donnée satellite.

La clé sert donc à structurer le tas, c’est elle qui est utilisée dans les fonctions de tas (insertion, suppression…) tandis que la donnée satellite n’est pas lue.

Cependant, pour la mise à jour d’une priorité, on souhaiterait avoir une fonction

```c
void update_priority (tas, elt, new_prio);
```

Solution naïve : on cherche l’élément dans le tas pour mettre à jour la seconde composante du couple puis on appelle `percolate` depuis le nœud $O lr((n))$.

Solution préférable : On représente une file de priorité par un couple

- tas binaire de couples

- dictionnaire dont les clés sont les éléments (la donnée satellite) et dont les valeurs sont les indices du tableau qui implémente le tas où se trouve la priorité de l’élément concerné.

Conséquence : à chaque modification du tableau dans les fonctions de tas binaire il faut mettre à jour le dictionnaire.

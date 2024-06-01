#set text(font: "Roboto Serif")

= Graphes Pondérés <graphes-pondérés>
== I - Mathématiquement <i---mathématiquement>
== III - Recherche de chemin de poids minimal dans un graphe pondéré <iii---recherche-de-chemin-de-poids-minimal-dans-un-graphe-pondéré>
=== 1. Algorithme de Dijkstra <algorithme-de-dijkstra>
==== Parenthèse : structure de "sac" <parenthèse-structure-de-sac>
On retrouve ces 4 fonctions :

- `create`

- `add`

- `take`

- `is_empty`

```python
def whatever_first_search(G, s):
    n = len(G)
    visited = tous à faux
    bag = create
    add s bag

    while not is_empty(bag):
        u = take bag
        if not visited[u]:
            visited[u] = True
            for each v neighbor:
                add v bag
```

==== Description de l’algorithme <description-de-lalgorithme>
```python
def dijsktra(G, s):
    n = len(G)
    pq = initialise une file de prio avec sommets à prio = +infini
    update pq s 0

    Tant que pq non vide:
        u = extract_min pq
        mise à jour de tab_distance[u]
        Pour chaque voisin v:
            min_d = prio(u) + pond(u,v)
            if v in pq && min_d < prio(v):
                update pq v min_d

    renvoyer le tableau des distances
```

==== Correction de l’algorithme <correction-de-lalgorithme>
#quote(
  block: true,
)[
  Lemme : Soit s et t deux sommets d’un graphe orienté et pondéré G. Soit c un chemin $s = u_0 , u_1 , . . . , u_k = t$ de poids minimal de s à t. Alors quelque soit i, le chemin $s = u_0 , . . . , u_i$ est de poids minimal de s à $u_i$.

  Preuve : S’il y avait un meilleur chemin de s à $u_i$, alors on obtiendrait un meilleur chemin de s à t.
]

Invariant

- Si prio\(u) différent de \$+\\infin\$ alors \$\\exist c : s\\rightarrow u\$ de poids prio\(u)

- Si $x in.not p q$ alors pour tout voisin w de x on a prio\(u) $lt.eq$ prio\(x) + pond\(x, w)

- Lorsque u sort de la file, prio\(u) \= $delta lr((s , u))$

Préservation de l’invariant

On suppose u différent de s

On considère c un chemin optimal de s à u.

- Sur ce chemin, on note w le premier du chemin qui est dans la file (existe car u est dans la file)

- Sur ce chemin on note x le prédécesseur de w (existe car s $in.not$ pq donc s différent de w)

$delta lr((s , w)) lt.eq p r i o lr((w))$ par invariant

$x in.not p q$ puisque w est le premier du chemin à être dans pq.

Donc par le 2ème invariant : $p r i o lr((w)) lt.eq p r i o lr((x)) + p o n d lr((x , w))$ où $p r i o lr((x)) = delta lr((s , w))$.

Par le lemme, le préfixe du chemin c de s à w est optimal, donc de poids $delta lr((s , w))$

De même pour x, donc $delta lr((s , w)) = delta lr((s , x)) + p o n d lr((w , x))$

#strong[On met tout ensemble :]

$delta lr((s , w)) lt.eq p r i o lr((w)) lt.eq delta lr((s , w)) + p o n d lr((w , x))$ et $p r i o lr((w)) = delta lr((s , w))$

Et comme \$u \= extract\\\_min \\space pq\$.

On a $p r i o lr((u)) lt.eq p r i o lr((w)) = delta lr((s , w)) = delta lr((s , u)) - p o n d lr((c_2))$

Donc $delta lr((s , u)) lt.eq delta lr((s , u)) - p o n d lr((c_2))$

Donc $p o n d lr((c_2)) = 0$

L’invariant est vérifié.

==== Complexité <complexité>
Avant la boucle : $O lr((n))$ pour initialiser la file de priorité

Boucle while : exécutée exactement une fois par sommet

Extraction du min : $O lr((l o g lr((n))))$

Pour chaque voisin : $O lr((l o g lr((n))))$ à cause de la mise à jour de priorité

#strong[Finalement :]

$O lr((n)) + sum_(u in V) ( O lr((l o g lr((n)) + sum_(v v o i s i n) O lr((l o g lr((n))))))$

$= O lr((l o g lr((n)))) + sum_(u in V) O lr((l o g lr((n)))) d_(+) lr((u))$

$= O lr((n l o g lr((n)))) + O lr((m l o g lr((n))))$

$= O lr((l o g lr((n)) lr((n + m))))$

==== Conclusion <conclusion>
- L’algorithme donne pour un sommet s : les poids minimaux et plus courts chemins de s à tous les $t in V$.

=== 2. Algorithme de Floyd Warshall <algorithme-de-floyd-warshall>
==== Introduction <introduction>
- On travaille avec la matrice d’adjacence

- On va déterminer tous les plus courts chemins de s à t $forall lr((s , t))$.

==== Première idée - Adaptation du produit matriciel <première-idée---adaptation-du-produit-matriciel>
Essayons d’adapter la méthode des puissances matricielles. On note A la matrice d’adjacence du graphe et suppose :

\$A\_{ij} \= +\\infin\$ si $lr((i , j)) in.not E$

$A_(i j) = p o n d lr((i , j))$

$A_(j j) = 0$

On aimerait que $A_(i j)^k$ donne le poids minimal d’un chemin de longueur au plus k de i à j.

$A_(i j)^k = min_(l = 0)^(n - 1) lr((A_(i l)^(k - 1) + A_(l j)))$

Complexité

En supposant la multiplication matricielle modifiée en $O lr((n ³))$ le calcul de $A^n$ est en $O lr((n ³ l o g lr((n))))$.

==== Description de l’algorithme <description-de-lalgorithme-1>
De manière similaire, on fractionne le problème "aller de i à j en un chemin de poids minimal" en des sous-problèmes "aller de i à j #strong[en utilisant uniquement les sommets \[0, k-1\]] et de poids minimal".

On définit $p m_(i j)^k$ le poids minimal d’un chemin de i à j dont les sommets intermédiaires sont dans $lr([0 , k - 1])$.

$p m_(i j)^0 = A_(i j)$

$p m_(i j)^k = m i n lr(
  (p m_(i j)^(lr((k - 1))) , p m_(i , k - 1)^(k - 1) + p m_(k - 1 , j)^(k - 1))
)$

Complexité : $O lr((n^3))$

Pseudo-code : On applique la recette du cours de programmation dynamique

- Création du tableau

  - C’est un `int array array`

  - Convention : $T . lr((i)) . lr((j)) . lr((k)) = p m_(i j)^k$

- Cas de base : facile

  ```ocaml
        for i
         for j
             T.(i).(j).(0) <- ...
    ```

- Remplissage : ne pas se tromper dans l’ordre des boucles

  ```ocaml
      for k = 1 to ...
       for i = 0 to ...
           for j = 0 to ...
               T.(i).(j).(k) <- ...
    ```

Gain en espace : `T.(i).(j)` : table 2D.

Invariant : $T . lr((i)) . lr((j)) = p m_(i j)^(k - 1)$

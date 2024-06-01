#set text(font: "Roboto Serif")

= Chapitre 22 : Algorithmique du Texte <chapitre-22-algorithmique-du-texte>
== Notations et Vocabulaire <notations-et-vocabulaire>
=== Notations <notations>
On appelle alphabet, souvent noté $Sigma$, un ensemble fini de symboles.

#quote(block: true)[
  Exemple : $Sigma = { A S C I I }$

  $lr(|Sigma|) = 256$
]

#quote(block: true)[
  Exemple : En bio-informatique

  $Sigma = { A , T , C , G }$

  $lr(|Sigma|) = 4$
]

On fixe un alphabet sur $Sigma$.

Un mot est une suite finie de symboles de $Sigma$. $u = a_0 , . . . a_(n - 1)$. On note $lr(|u|) = n$ la longueur de u. Les $a_i$ sont les lettres de u. On notera $u lr([i]) = a_i$ le $i^e$ caractère de u.

On note $epsilon.alt$ le mot vide (l’unique mot de longueur 0).

On note $Sigma^(\*)$ l’ensemble des mots.

On note $circle.stroked.tiny$ la concaténation des mots. $u circle.stroked.tiny v = a_0 . . . a_(n - 1) b_0 . . . b_(m - 1)$ avec $u = a_0 . . . a_(n - 1)$ et $v = b_0 . . . b_(m - 1)$. On écrit souvent $u w$ au lieu de $u circle.stroked.tiny w$.

=== Vocabulaire <vocabulaire>
u est un préfixe de v si

- $u = a_0 . . . . a_(n - 1)$

- $v = a_0 . . . a_(n - 1) a_n . . . a_(m - 1)$

Respectivement "suffixe"

u est un facteur de v s’il existe un mot w tel que $w u$ est un préfixe de v.

$m lr([i : j])$ est le facteur de m entre position i (inclus) et j (exclus), $m = a_0 . . . a_(n - 1) arrow.r.double m lr([i : j]) = a_i . . . a_(j - 1)$

== I - Recherche de Mot dans un Texte <i---recherche-de-mot-dans-un-texte>
=== 1. Algorithme de Robin Karp <algorithme-de-robin-karp>
==== a. Algorithme naïf <a.-algorithme-naïf>
Première approche

$m , T in Sigma^(\*)$

On veut savoir si m est un facteur de T

Pour $i_0 in \[ 0 , lr(|T|) - lr(|m|) \[$

Tester si $m = T lr([i_0 : i_0 + lr(|m|)])$

```py
algo_naif(texte, motif) # tiré de wikipédia
1.  n ← longueur(texte)
2.  m ← longueur(motif)
3. pour i de 1 à n-m+1 faire
4.    si texte[i..i+m-1] = motif[1..m]
5.       motif trouvé dans le texte à la position i
6. motif non trouvé
```

Complexité en $O lr((lr((lr(|T|) - lr(|m|))) lr(|m|)))$

#quote(block: true)[
  Exemple pire cas :

  m \= "dauphin"

  T \= "dauphi dauphi dauphi…"
]

Idée de l’algorithme

On prend une fonction de hachage h et on remplace le test $m = = T lr([i_0 , i_0 + m])$ par le test $h lr((m)) = h lr((T lr([i_0 , i_0 + m])))$

S’il y a égalité des haches, alors on fait le premier test.

Empiriquement, si h est "bien faite" (peu de collisions) alors on s’attend à réaliser le premier test beaucoup moins souvent.

#quote(block: true)[
  Problème : Le calcul de h\(m) est en $O lr((lr(|m|)))$
]

Pour l’algorithme on choisit $h lr((m)) = sum_(i = 0)^(lr(|m|) - 1) c lr((m lr([i]))) lr(|Sigma|)^i m o d lr((N))$ avec $c : Sigma arrow.r \[ 0 , lr(|Sigma|) \[$ une énumération de $Sigma$.

$arrow.r.double h lr((m))$ se calcule en $O lr((lr(|m|)))$

L’algorithme

On obtient $h ( T lr(|i_0 : i_0 +|) m lr(|\] = h lr((T lr([i_0 - 1 : i_0 - 1 + lr(|m|)]))) \/|) Sigma \| + sum^(lr(|m|) - 1) c lr((T lr([i_0 + lr(|m|) - 1]))) m o d lr((N))$

La somme est calculée qu’une seule fois.

On prend $h_m$ le haché de m

On calcule $sum^(lr(|m|) - 1)$.

$h_T$ \= haché $T lr([0 : lr(|m|) - 1]) \* lr(|Sigma|)$

Pour $i_0 in \[ 0 , lr(|T|) - lr(|m|) \[$

~~~~$h_T = h_T \/ lr(|Sigma|) + sum^(lr(|m|) - 1) \* c lr((T lr([i_0 + lr(|m|) - 1])))$

~~~~Si $h_T = = h_m :$

~~~~~~~~Si $m = = T lr([i_0 : i_0 + lr(|m|)])$:

~~~~~~~~~~~~Retourner vrai

Retourner faux

```python
rabin_karp(texte, motif) # tiré de wikipédia
 1.  n ← longueur(texte)
 2.  m ← longueur(motif)
 3.  hn ← hach(texte[1..m])
 4.  hm ← hach(motif[1..m])
 5.  pour i de 0 à n-m+1 faire
 6.    si hn = hm
 7.      si texte[i..i+m-1] = motif[1..m]
 8.        motif trouvé dans le texte à la position i
 9.    hn ← hach(texte[i+1..i+m])
10. motif non trouvé
```

Complexité : Dans le pire cas on effectue le test `m == T[...]` à chaque fois et on a donc rien gagné. L’analyse de complexité pire cas n’est pas pertinente ici. L’efficacité empirique de cet algorithme repose sur le fait que lorsque \$m \\space !\=T\[i\_0:i\_0+|m|\]\$ alors $h_m ! = h_T$ dans la plupart des cas.

Autrement dit, les cas où $h_T = h_m$ et \$m \\space!\= T\[...\]\$ sont rares.

=== 2. Algorithme de Boyer-Moore <algorithme-de-boyer-moore>
==== a. Algorithme (version 1) <a.-algorithme-version-1>

```python
algo
1. i0 = 0
2. Tant que i0 <  |T| - |m|
3.     tester m == T[i0 : i0 + |m|] en partant de la droite
4.     Si cela échoue, en prenant compte de T[i0 + |m| - 1]
5.         On se décale intelligament : i0 = i0 + decalage(T[i0+|m -1])
```

Comment construire `décalage` ?

Pour représenter cette fonction on pourrait utiliser un tableau "offset" et une énumération de $Sigma$, notée c de sorte que $o f f s e t lr([c lr((a))]) = d e c a l a g e lr((a)) forall a in Sigma$

Inconvénient : Beaucoup d’espace utilisé pour rien puisque $forall a in Sigma$ qui n’es pas dans m on a $d e c a l a g e lr((a)) = lr(|m|)$.

On utilise donc un dictionnaire dont les clés sont les caractères présents dans m et la valeur associée à $a in Sigma$ sera $d e c a l a g e lr((a))$.

Complexité :

- Pire des cas : Si $i_0 = i_0 + 1$ à chaque boucle (irréaliste) alors on est en $O lr((lr((lr(|T|) - lr(|m|))) lr(|m|)))$. Cette analyse n’est pas adaptée, l’amélioration est empirique.

- Meilleur cas : $i_0 = i_0 + lr(|m|)$.

  On est en $O lr((frac(lr(|T|) - lr(|m|), lr(|m|))))$.

L’algorithme sera d’autant plus efficace que |m| est grand.

==== b. Algorithme (version 2 - hors-programme) <b.-algorithme-version-2---hors-programme>
Elle prend compte des suffixes dans la table.

== II - Compression de Texte <ii---compression-de-texte>
=== 1. Codage de Huffman <codage-de-huffman>
#quote(block: true)[
  Exemple : "AATACGCATAAATA"
]

On peut s’intéresser à cette séquence en RAM en prenant

A – 01

T – 01

C – 10

G – 11

Espace RAM occupé : $2 \* 14 = 28 b i t s$

Autre codage possible (fonction c)

A – 0

T – 10

C – 110

G – 111

Calcul de l’espace mémoire utilisé : $sum_(a in Sigma) lr(|c lr((a))|) \* f r e q_T lr((a)) = 23 b i t s$

On donne un poids différent entre chaque caractère selon sa fréquence d’apparition.

Décompression : Algorithme glouton. Il fonctionne si on impose la contrainte suivante

\$\\forall a \\in\\Sigma, \\forall b\\in\\Sigma, a \\space !\=b \\Longrightarrow c\(a)\\in\\{0,1\\}^\*\$ n’est pas un préfixe de $c lr((b)) in { 0 , 1 }^(\*)$

Définition : Soit $Sigma$ un alphabet, on appelle codage une fonction injective $c : Sigma arrow.r { 0 , 1 }^(\*)$. On dit qu’un codage est admissible si \$\\forall a \\space !\= b, c\(a)\$ n’est pas un préfixe de c\(b).

Objectif : Etant donné $T in Sigma^(\*)$, trouver le #strong[meilleur] codage admissible, c’est-à-dire celui qui minimise la consommation mémoire de T.

On note $c_(m T) lr((c)) = sum_(i = 0)^(lr(|T|) - 1) \| c lr((T lr([i]))) \| = sum_(a in Sigma) lr(|c lr((a))|) \* f r e q_T lr((a))$

Où $f r e q_T lr((a))$ est le nombre d’occurrences de a dans T.

==== a. Représentation des Codages <a.-représentation-des-codages>
On propose de voir un mot de ${ 0 , 1 }^(\*)$ comme un chemin dans un arbre binaire

- 0 : aller à gauche

- 1 : aller à droite

Pour $a in Sigma$, on écrit a comme étiquette du nœud d’arbre c\(a).

Ainsi, on visualise les codages comme des arbres.

$c : A arrow.r 00 , T arrow.r 01 , C arrow.r 10 , G arrow.r 11$

Si le codage est admissible dans les symboles $a in Sigma$ étiquettent des feuilles sur l’arbre.

Pour minimiser la consommation mémoire, on peut ne considérer que les codages pour lesquels tout nœud interne de l’arbre associé a exactement 2 enfants.

#quote(
  block: true,
)[
  Remarque : Pour $a in Sigma$, on a |c\(a)| \= profondeur du nœud étiqueté par a dans l’arbre.

  Donc faire "remonter" un symbole dans l’arbre a pour effet de réduire |c\(a)| sans changer |c\(b)| pour $b in Sigma$\\{a}. Donc cela réduit $sum_(a in Sigma) lr(|c lr((a))|) f r e q_T lr((a))$
]

Conclusion : Un codage optimal correspond forcément à une arbre binaire strict. On prendra dans la suite

```ocaml
type codage = Leaf of Sigma | Node of codage * codage
```

==== b. Recherche du codage Optimal <b.-recherche-du-codage-optimal>
On fixe un texte T.

#quote(
  block: true,
)[
  Propriété 1 : Soit $sigma$ une bijection de $Sigma$ dans $Sigma$ et c un codage admissible. Alors $c circle.stroked.tiny sigma$ est un codage admissible et si c correspond à un arbre binaire strict alors $c circle.stroked.tiny sigma$ aussi.
]

#quote(
  block: true,
)[
  Propriété 2 : Soit c un codage optimal pour T. Soit $a , b in Sigma$ tels que

  $f r e q_T lr((a)) < f r e q_T lr((b))$

  Alors $lr(|c lr((a))|) gt.eq lr(|c lr((b))|)$.

  Preuve : Si ce n’est pas le cas, on applique au codage la transposition $tau_(a b)$. Par la première propriété, $c circle.stroked.tiny tau_(a b)$ est un codage admissible donc par optimalité

  $c_(m T) lr((c)) lt.eq c_(m T) lr((c circle.stroked.tiny tau_(a b)))$

  et pourtant

  $c_(m T) lr((c circle.stroked.tiny tau_(a b))) = sum_(d in Sigma) lr(|c circle.stroked.tiny tau_(a b) lr((d))|) f r e q_T lr((d))$

  #emph[demander à quelqu’un pour les étapes intermédiaires]

  $c_(m T) lr((c circle.stroked.tiny tau_(a b))) = c_(m T) lr((c))$

  $- lr(|c lr((a))|) f r e q_T lr((a))$

  $- lr(|c lr((b))|) f r e q_T lr((b))$

  $+ lr(|c lr((h))|) f r e q_T lr((a))$

  $+ lr(|c lr((a))|) f r e q_T lr((b))$

  $= < 0$

  Donc absurde
]

#quote(
  block: true,
)[
  Preuve : Soit c un codage optimal pour T.

  Soient $a_1 , a_2$ deux frères dans l’arbre c de profondeur maximale.

  Par la propriété 2, $f r q u_T lr((a_1))$ et \$ freq\_T\(a\_2)\$ sont minimales parmi

  ${ f r e q_T lr((a)) \| a in Sigma }$

  On définit $Sigma prime = Sigma without { a_1 , a_2 } u n i o n { a prime }$ où a’ est un nouveau symbole qui n’appartient pas à $Sigma$.

  Et $T prime = T$ dans lequel on remplace tous les $a_1 , a_2$ par a’.

  $f r e q_(T prime) lr((a prime)) = f r e q_T lr((a_1)) + f r e q_T lr((a_2))$ et T’ est un texte sur $Sigma prime$ et $f r e q_(T prime) lr((a)) = f r e q_T lr((a))$ pour $a in Sigma u n i o n Sigma prime$

  Comme $a_1$ et $a_2$ sont frères dans l’arbre, ils s’écrivent $a_1 = u_0$ et $a_2 = u_1$ (ou l’inverse).

  On définit \$c\': \\Sigma \\longrightarrow \\{0,1\\}^\* \\\\c\'\(a) \= c\(a) \\\\c\'\(a\') \= u\$.

  #quote(
    block: true,
  )[
    Lemme : c est optimal pour T’ et $Sigma prime$.

    Preuve : Supposons par l’absurde que c’ n’est pas optimal. Il existe donc $c prime_(o p t)$ tel qu $c_(m T) lr((c prime_(o p t))) < c_(m T prime) lr((c prime)) .$

    On va définir $c_(o p t)$ un codage pour T et $Sigma$ qui sera "mieux" que c.

    On définit

    \$c\_{opt} : \\Sigma \\longrightarrow \\{0,1\\}^\* \\\\c\_{opt}\(a) \= c\_{opt}\'\(a) \\space si\\space a\\in\\Sigma union\\Sigma\' \\\\ c\_{opt}\(a\_1) \= c\_{opt}\'\(a\').0 \\\\ c\_{opt}\(a\_2) \= c\_{opt}\'\(a\').1\$

    $c_(m T) lr((c_(o p t))) = sum_(d in Sigma) lr(|c_(o p t) lr((d))|) \* f r e q_T lr((d))$

    \$ \= c\_{mT’}\(c\_{opt}') - |c\_{opt}'\(a’)|#emph[freq\_{T’}\(a’) + |c\_{opt}\(a\_1)|]freq\_T\(a\_1) + |c\_{opt}\(a\_2)|\*freq\(a\_2)\$

    #emph[demander à quelqu’un pour les étapes intermédiaires]

    $= c_(m T prime) lr((c_(o p t) prime)) + lr((f r e q_T lr((a_1)) + f r e q_T lr((a_2)))) \* 1$

    De même, $c_(m T) lr((c)) = sum_(d in Sigma) lr(|c lr((a))|) \* f r e q_T lr((d)) = c_(m T) lr((c prime)) + lr((f r e q_T lr((a_1)) + f r e q_T lr((a_2))))$

    Conclusion : $c_(m T) lr((c_(o p t))) = c_(m T prime) lr((c_(o p t) prime)) + . . .$
  ]
]

==== c.~Algorithme Glouton Provisoire <c.-algorithme-glouton-provisoire>
```ocaml
codage_optimal(S, T):
1.    calculer freqT(a) pour a dans S
2.    a1, a2 = minimums de freqT(a)
3.    S' = S sans a1 et a2, et avec a'
4.    T' = T dans lequel on remplace tous les a1 et a2 par a'
5.    c' = codage_optimal(S', T')
6.    c = le codage tel que Pour tout a commun à S et S'
7.        c(a) = c'(a)
8.        c(a1) = c(a').0
9.        c(a2) = c(a').1
```

Cas de base :

Si $lr(|Sigma|) = 1$, renvoyer $c lr((a)) = 0$ pour a l’unique symbole de $Sigma$.

Si $lr(|Sigma|) = 2$, renvoyer $c lr((a)) = 0 , c lr((b)) = 1$ pour $Sigma = { a , b }$.

Terminaison : variant $lr(|Sigma|)$

Correction : C’est la preuve qui précède, par récurrence sur $lr(|Sigma|)$

Initialisation : $lr(|Sigma|) in { 1 , 2 }$ c’est évident.

Hérédité : Par HR, le $c prime = c o d a g e \_ o p t i m a l lr((Sigma prime , T prime))$ est optimal.

Le c est alors optimal : s’il ne l’est pas, \$\\exist c\_{opt}\$ qui est meilleur pour $Sigma , T$ et on en déduit $c_(o p t) prime$ meilleur pour $Sigma prime , T prime$ que $c prime$.

Complexité

- Calcul des fréquences : $O lr((lr(|T|)))$

- Calcul de a1 et a2 : $O lr((lr(|Sigma|)))$

- Construction de $Sigma prime$ : $O lr((1))$

- Construction dans $T prime$ : $O lr((lr(|T|)))$

- Construction de c : $O lr((lr(|Sigma|)))$

$u_(lr(|Sigma|) , lr(|T|)) = O lr((lr(|T|) + lr(|Sigma|))) + u_(lr(|Sigma|) - 1 , lr(|T|))$

$u_(n , p) = C lr((n + p)) + u_(n - 1 , p)$

$arrow.r.double u_(n , p) = O lr((n^2 + n p))$

Pour améliorer cette complexité on peut calculer une seule fois les fréquences au début. On peut également utiliser une file de priorité pour les calculs de minimaux. On peut également se passer de la construction de T’. Enfin on peut construire c d’une meilleure façon.

==== d.~Algorithme <d.-algorithme>
```ocaml
codage_optimal(S, T)
1.    On calcule les freqT(a) pour tout a de S
2.    In initialise une file de priorité pq qui contient tous les
3.        Leaf(a) pour a de S avec priorité freqT(a)
4.    Faire |S|-1 fois:
5.        a1,p1 = extract_min pq
6.        a2,p2 = extract_min pq
7.        add pq Node(a1,a2) (p1+p2)
8.    (c1, _) = extract_min pq
9.    return c
```

```ocaml
(* Rappel *)
type codage = Leaf of S | Node of codage * codage
```

==== e. Complexité <e.-complexité>
On calcule la complexité totale

- Calcul des fréquences : $O lr((lr(|T|)))$

- Initialisation de la file de priorité : $O lr((lr(|Sigma|)))$

- Boucle : $lr(|Sigma|)$ fois $O ( l o g lr((lr(|Sigma|)))$

Ce qui donne $O lr((lr(|T|) + lr(|Sigma|) l o g lr(|Sigma|)))$.

=== 2. Algorithme de Lempel Ziv <algorithme-de-lempel-ziv>
==== a. Introduction <a.-introduction>
Avantages :

- Algorithme Online (streaming)

- la décompression ne nécessite pas de connaître le codage

Exemple : "ATCATGTATCATGTAA"

On maintient une table $f a c t e u r arrow.r n o u v e a u \_ s y m b o l e$.

Ici pour simplifier, les nouveaux symboles sont des entiers.

On initialise la table : \$A\\rightarrow0\\\\T\\rightarrow1\\\\C\\rightarrow2\\\\G\\rightarrow3\$

Compression : On ajoute à la table le motif si on ne le connais pas et on incrémente le motif précédent connu.

Décompression : On remonte l’algorithme.

==== b. Algorithme de Compression <b.-algorithme-de-compression>
```python
def compression(T):
    i = 0
    d = dict([(S[i],i) for i in range(len(S)])
    symbole = n
    while i < len(T):
        Trouver le plus petit j tel que T[i:j] not in d
        d[T[i:j]] = symbole
        symbole += 1
        print(d[T[i:j-1]])
        i = j-1
    return d
```

==== c.~Algorithme de Décompression <c.-algorithme-de-décompression>
```python
def decompression(c):
    d = {}
    for i in range(len(S)): d[i] = S[i]
    print(d[c[0]])

    precedent = d[c[0]]
    for i in range(1, len(c))
        d[output_precedant+d[c[i]][0]]
        print(d[c[i]])
```

#quote(
  block: true,
)[
  Remarque : Il y a plusieurs cas à distinguer, on ne peut pas toujours accéder à d\[c\[i\]\].
]

Invariant à retenir :

Si un facteur u appartient au dictionnaire alors tous ses préfixes aussi.

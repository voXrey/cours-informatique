#import "@preview/codly:0.2.1": *
#show: codly-init.with()
#codly()

#set text(font: "Roboto Serif")

= Problèmes de Recherche et d’optimisation <problèmes-de-recherche-et-doptimisation>
== I - Problèmes de Recherche <i---problèmes-de-recherche>
On dispose d’un ensemble S de "candidats" et on souhaite savoir si l’un d’eux vérifie une certaine propriété, un tél élément est alors appelé solution.

#strong[Exemples]

  + Étant donnés $a lt.eq b in N$, existe-t-il un nombre premier dans $\[ a , b \]$ ?

  + Etant donné a un tableau d’entiers et $T in N$, existe-t-il une tranche du tableau qui somme à T ? Autrement dit, a-t-on :

    $exists 0 lt.eq i lt.eq j lt.eq "len"\(a) : T \= sum\(a\[i:j\])$

  + Subset Sum :

    Étant donné E un ensemble d’entiers et $T in Z$, existe-t-il un sous-ensemble $F subset.eq E : T = sum_(x in F) x$

  + Problème des N-dames :

    Soit $n in N$, on souhaite placer N dames sur un échiquier $N times N$ de façon à qu’aucune ne puisse en prendre une autre, c’est-à-dire qu’aucune ne puisse se voire verticalement, horizontalement, ou en diagonal. Est-ce possible ?

  + Problème du cavalier :

    Soit $n in N$, un cavalier partant du coin inférieur gauche (ou une autre position fixe) peut-il se rendre une unique fois sur chaque case de l’échiquier ?

  + Existence d’un colloscope :

    Étant donné un EDT, des créneaux de colle, des groupes de colle, avec des contraintes (LV1, LV2, option SI…) et une contrainte de discipline par semaine, comment diable construire un colloscope ?


== II - Problèmes d’optimisation <ii---problèmes-doptimisation>
On a un espace de candidats S et une fonction `f` "score" qui va de S dans $R$.

Objectif : Optimiser f, c’est-à-dire trouver $x in S : x = m i n_S lr((f))$

#strong[Exemples]

  + Étant donné $a lt.eq b in N$, trouver le plus petit nombre premier dans $lr([a , b])$.

  + Tranche optimale : Étant donné un tableau a d’entiers, trouver i et j tels que $sum_(k = i)^(j - 1) a lr([k])$ soit le plus grand possible.

  + Problème du sac à dos :

    On dispose de N objets de poids respectifs $p_1 , . . . p_N$ et de valeurs $v_1 , . . . v_N$. Notre sac de peut supporter plus qu’un poids P. Maximiser la valeur du sac, c’est-à-dire choisir un sous-ensemble $F subset.eq lr([1 , N]) : sum_(i in F) p_i lt.eq P$ et $sum_(i in F) v_i = m a x_(G subset.eq lr([1 , N])) { sum_(i in G) v_i \| sum_(i in G) }$

  + Problème du rendu de monnaie :

    On dispose d’une liste $S = lr([1 , S lr([1]) , . . . S lr([k]) , . . .])$ triée qui représente un système monétaire. Étant donné $x in N$, en souhaitant donner $x$ euros à une personne en minimisant le nombre de pièces/billets, c’est-à-dire trouver une liste R de longueur $"len"(S)$ :
    $
    sum_(i\=0)^("len"(S)-1)R[i]S[i] = x "et" sum_(i=0)^(n)R[i]
    $
    soit minimale.

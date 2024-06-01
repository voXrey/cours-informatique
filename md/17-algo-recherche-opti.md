# Problèmes de Recherche et d'optimisation

## I - Problèmes de Recherche

On dispose d'un ensemble S de "candidats" et on souhaite savoir si l'un d'eux vérifie une certaine propriété, un tél élément est alors appelé <u>solution</u>.

**Exemples**

1) Étant donnés $a \leq b \in\N$, existe-t-il un nombre premier dans $\lbrack a,b\rbrack$ ?

2) Etant donné a un tableau d'entiers et $T \in \N$, existe-t-il une tranche du tableau qui somme à T ? Autrement dit, a-t-on :
   
   $\exist 0 \leq i \leq j \leq len(a) : T = sum(a[i:j])$

3) Subset Sum :
   
   Étant donné E un ensemble d'entiers et $T \in \Z$, existe-t-il un sous-ensemble $F \subseteq E : T = \sum_{x\in F}{x}$

4) Problème des N-dames :
   
   Soit $n\in\N$, on souhaite placer N dames sur un échiquier $N\times N$ de façon à qu'aucune ne puisse en prendre une autre, c'est-à-dire qu'aucune ne puisse se voire verticalement, horizontalement, ou en diagonal. Est-ce possible ?

5) Problème du cavalier :
   
   Soit $n\in\N$, un cavalier partant du coin inférieur gauche (ou une autre position fixe) peut-il se rendre une unique fois sur chaque case de l'échiquier ?

6) Existence d'un colloscope :
   
   Étant donné un EDT, des créneaux de colle, des groupes de colle, avec des contraintes (LV1, LV2, option SI...) et une contrainte de discipline par semaine, comment diable construire un colloscope ?

## II - Problèmes d'optimisation

On a un espace de candidats S et une fonction `f` "score" qui va de S dans $\R$.

<u>Objectif</u> : Optimiser f, c'est-à-dire trouver $x\in S :x=min_{S}(f)$

**Exemples** 

1) Étant donné $a \leq b \in \N$, trouver le plus petit nombre premier dans $[a,b]$.

2) Tranche optimale : Étant donné un tableau a d'entiers, trouver i et j tels que $\sum_{k=i}^{j-1}{a[k]}$ soit le plus grand possible.

3) Problème du sac à dos :
   
   On dispose de N objets de poids respectifs $p_1,...p_N$ et de valeurs $v_1,...v_N$. Notre sac de peut supporter plus qu'un poids P. Maximiser la valeur du sac, c'est-à-dire choisir un sous-ensemble $F \subseteq [1,N] : \sum_{i\in F}{p_i}\leq P$ et $\sum_{i\in F}{v_i} =max_{G \subseteq [1,N]}\{\sum_{i\in G}{v_i} | \sum_{i\in G}\}$

4) Problème du rendu de monnaie :
   
   On dispose d'une liste $S = [1, S[1],...S[k],...]$ triée qui représente un système monétaire. Étant donné $x\in\N$, en souhaitant donner $x$ euros à une personne en minimisant le nombre de pièces/billets, c'est-à-dire trouver une liste R de longueur $len(S) : \{\sum_{i=0}^{len(S)-1}{R[i]S[i]} = x \space et \sum_{i=0}^{n}{R[i]}$ soit minimale.   

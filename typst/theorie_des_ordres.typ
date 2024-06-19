#import "@preview/codly:0.2.1": *
#show: codly-init.with()
#codly()

#set text(font: "New Computer Modern Sans")

= Théorie des Ordres
== 1. Premières Définitions
Cette section introduit du vocabulaire sur les ordres en s’appuyant sur un parallèle avec les graphes, notamment certaines notions introduites dans le DM d’Avril (sujet Mines MP 2014).

=== Contexte
Dans tout le chapitre, $X$ désigne un ensemble et $R$ une relation sur $X$.

=== Rappel
Une relation est tout simplement un sous-ensemble $R subset X times X$. Pour $(x, y) in X^2$, on note $x R y$ au lieu de $(x, y) in R$.

=== Parallèle
Un graphe est la donnée d’un ensemble fini de sommets $V$ et d’un ensemble d’arcs $E subset.eq V times V$. Mis à part que $V$ est fini, il s’agit exactement du même contexte. Nous allons donc introduire les définitions propres aux relations avec un parallèle dans le vocabulaire des graphes. Le fait que $V$ soit infini ne pose aucun problème, on se restreint aux graphes finis en MP2I pour faire de l’algorithmique, mais les graphes infinis sont largement étudiés en mathématiques.

=== Définitions
- $R$ est *réflexive* ssi : $forall x in X : x R y$.

 - Vision graphe : il y a une boucle sur chaque sommet (comme dans le sujet Mines MP 2014).

- $R$ est *irréflexive* ssi : $forall x in X, not(x R y)$.

  - Vision graphe : il n’y a aucune boucle dans le graphe.

- $R$ est *transitive* ssi : $forall (x, y, z) in X^3 : (x R y and y R z) ==> x R z$.

- On appelle *clôture réflexive transitive* $R$ la relation notée $R\*$ définie par : $x R\* y <==> exists n in NN : exists z_0, dots, z_n in X : x = z_0 R z_1 R dots R z_(n-1) R z_n = y$

  - Vision graphe : la clôture transitive transforme les chemins en arêtes : il y a une arête $(x, y)$ dans le graphe $(X, R\*)$ si et seulement s’il y a un chemin de $x "à" y$ dans le graphe $(X, R)$.

- $R$ est *antisymétrique* ssi : $forall x, y in X, x R y and y R x ==> x = y$.

  - Vision graphe : il n’y a pas de cycle simple de longueur exactement 2 ; ou encore tout cycle de longueur 2 est en fait une boucle prise 2 fois. Si la relation est également transitive, l’antisymétrie est équivalente à l’acyclicité du graphe (si on ignore les boucles !).

- $R$ est *totale* ssi : $forall x, y in X, x R y or y R x$.

  - Vision graphe : celle-ci ne se visualise pas bien, on peut dire que le graphe non orienté sous-jacent est complet, mais ce n’est pas très parlant. On aura une meilleure vision graphe pour les *ordres totaux*.

=== Vocabulaire de la théorie des ordres
- *Pré-ordre* = réflexif + transitif.
- *Ordre strict* = irréflexif + transitif.
- *Ordre* (aka ordre partiel) = réflexif, transitif, antisymétrique.
- *Ordre total* = ordre partiel + total.
  - AKA ordre linéaire. Pourquoi linéaire ? Nous y venons.
  
Exemples : on dessine,
- $NN$ muni de l’ordre naturel
- $ZZ$ muni de l’ordre naturel
- $P({0, 1, 2})$ muni de $subset.eq$
- $NN$ muni de l’ordre de divisibilité
- $ZZ$ muni de l’ordre de divisibilité est un pré-ordre : à cause de $n "et" -n$. Autre exemple du même genre ?

Culture générale : ces dessins s’appellent *diagrammes de Hasse*. Lorsque l’on dessine un ordre $(X, <=)$, on dessine en réalité le graphe $(X, R)$ où $<= "=" R\*$  pour une relation $R$ aussi "petite" que possible. Y a-t-il un minimum ? Considérez l’ensemble des réels, ou encore $NN union {+infinity}$.

=== 1.1. Les Ordres Linéaires
Quelle forme a le diagramme de Hasse d’un ordre total ? D’où le nom *linéaire*.

- Soit $<=$ un ordre partiel et $lt.eq.curly$ un ordre total tel que : $forall x, y in X, x <= y ==> x lt.curly.eq$. En théorie des ensembles, cela s’écrit plus simplement : $<= subset.eq lt.eq.curly.$. On dit que $lt.curly.eq$ est une *linéarisation* de $<=$. Exemple : une linéarisation de $P({0, 1, 2})$.

- Rappel : on appelle *tri par comparaison* un algorithme de tri qui trie un tableau en basant uniquement ses décisions sur des questions de $"if" x <= y "then" dots "else" dots$. Tous les algorithmes de tri par comparaison que vous connaissez supposent implicitement que si la branche `else` correspond à $x > y$. Autrement dit, ces algorithmes supposent que l’ordre est total. Que produit l’algorithme si on l’utilise sur un ordre partiel ? Il produit un tableau trié selon une certaine linéarisation. La linéarisation choisie va essentiellement dépendre de si l’algorithme teste $x <= y$ ou $y <= x$ en premier. Il se peut même que deux occurrences d’un même élément ne se trouve pas à côté dans le tableau trié, on peut intercaler des éléments incomparables, ou équivalents (deux éléments $x, y$ sont incomparables si $x lt.eq.not "et" y lt.eq.not x$ ; équivalents si au contraire $x <= y "et" y <= x$).\
  Ce n’est pas surprenant : la spécification d’un algorithme de tri sur un ordre partiel est incomplète : il n’y a pas unicité du tableau trié qui est une permutation du tableau initial.

- Nous avons vu cette année un algorithme qui permet de calculer une linéarisation d’un ordre partiel (dans le cas où l’ordre est fini). Nommez cet algorithme : *tri topologique*

=== 1.2. Passage d’un pré-ordre à un ordre partiel (hors programme)
- Comme vu plus haut, tout graphe acyclique peut être vu comme un ordre partiel (quitte à en prendre la clôture réflexive transitive) et réciproquement, le diagramme de Hasse d’un ordre partiel est un graphe acyclique (que l’on dessine les arêtes transitives ou non).

- Pour un pré-ordre c’est encore plus simple : n’importe quel graphe peut être vu comme un pré-ordre, quitte à en prendre la clôture réflexive transitive. Prenons donc un graphe quelconque ( G \= (V, E) ) et considérons deux éléments ( x, y ) qui mettent en défaut l’anti-symétrie : on a ( x y ) et ( y x ). Ce sont donc deux éléments tels qu’il y a un chemin dans ( G ) de $x$ à $y$ ET un chemin de $y$ à $x$. Autrement dit, $x$ et $y$ sont dans la même composante fortement connexe. Ce sont donc les composantes fortement connexes qui posent problème, il suffit de les réduire à un point : on considère le graphe de composantes fortement connexe défini dans le cours de graphe, et justement nous avons vu qu’il est acyclique ! Il correspond donc bien à un ordre partiel et si la définition de pré-ordre de départ s’il est acyclique, on peut dire que le quotient en pré-ordre est justement parfait de "quotient par une relation d’équivalence".

- Dans le sujet Mines MP 2014, c’est là fin du sujet avec la notion "d’axiomatique". Une axiomatique consiste à choisir exactement un élément par composante fortement connexe, c’est à dire un représentant par classe d’équivalence, car vous l’aviez bien remarqué : les composantes fortement connexes sont les classes d’équivalence pour la relation ( E ) définie par ( xREy ) s’il existe un chemin de $x$ à $y$ et de $y$ à $x$. Choisir un représentant par classe ou interpréter la classe comme un seul élément c’est la même chose, ce sont deux définitions équivalente du quotient par une relation d’équivalence.

=== 1.3 Ordre Strict associé à un Ordre
Soit $<=$ un ordre partiel, alors on définit l’ordre strict associé noté $<$ par :
$
  x < y <==> x <= y and x eq.not y
$
Cette définition ne convient plus si on travaille avec un pré-ordre (hors programme) : si $x "et" y$ sont dans la même composante fortement connexe, on va avoir $x < y "et" y < x$ puis par transitivité $x < x$ ce qui est impossible par irréflexivité. Il faut donc définir $<$ ainsi :
$
  x < y <==> x <= y or x gt.eq.not y
$

=== 1.4. Majorant, Maximum et Éléments Maximaux
==== Définitions
Soit $S$ une partie de $X$ :
- $A in X$ est un majorant de $S$ si : $forall x in S, x <= A$.
- $A in X$ est un maximum de $S$ ssi $A$ est un majorant de $A in S$. On dit alors que $S$ admet un maximum.
- $A$ est un élément maximal de $S$ si : $forall x in S, x gt.not A$.

On a bien évidemment les définitions duales : minorant, minimum et élément minimal.

==== Remarques et Mises en garde
- Les ensembles ordonnés que vous pratiquez ont la mauvaise manie d’être totaux $(NN, ZZ, RR, dots)$ et vous êtes donc tentés de confondre un ordre maximal et maximum. Avec des ordres partiels, cela ne reflète pas notre intuition : quels sont les éléments maximaux de $P(E)\{E}$ pour E = {0, 1, 2} ?

- En remplaçant $x < y$ par sa définition : 
  $
  x "élément maxiaml de" X <==> forall y in X, y >= x ==> x = y
  $
  et avec la définition plus générale de $x < y$ valable dans les pré-ordres :
  $
  x "élément maxiaml de" X <==> forall y in X, y >= x ==> x >= y
  $

Vous retrouverez ainsi la définition des "axiomes" du sujet Mines MP 2014.

==== Petits exercices d’entraînement
- Montrer qu’un ordre qui admet un maximum a un unique élément maximal.
- Montrer que la réciproque est fausse.
- Donner les éléments maximaux et minimaux de $NN$ muni de l’ordre "divisibilité". Et de $NN\{0, 1}$?
  - Majorant de $S$ : 0
  - Maximum de $S$ : il n'y en a pas
  - Elément max : non plus
  - Minorant : 1
  - Minimum : Il n'y en a pas
  - Elément min : non plus
- Donner une condition suffisante sur l’ordre pour avoir "il existe un maximum ssi il existe un élément maximal".

=== 1.5. Vocabulaire de la théorie des ordres qui provient de la vision graphe
- Si $x < y$ on dit que $y$ est un *successeur* de $x$ et $x$ un *prédécesseur* de $y$.

- Si $x < y$ et il n’existe aucun $z in X$ tel que $x < z < y$, alors $y$ est un *successeur immédiat* de $x$, et $x$ est un *prédécesseur immédiat* de $y$.

- Un élément maximal est donc exactement un élément sans successeur, et un élément minimal est exactement un élément sans prédécesseur.

- Un maximum n’a pas de successeur, mais la réciproque est fausse : il existe des éléments sans successeur qui ne sont pas des maximums.

- Un majorant de $S$ est un élément accessible depuis tous les éléments de $S$ (accessible au sens *il existe un chemin*).

Exemple : $NN union {infinity}$, l’infini n’a ni prédécesseur immédiat ni successeur.

== 2. Construction sur les Ordres
Soit $(X, <=_x)$ et $(X, <=_y)$ deux ordres (partiels).

- Somme disjointe : $(X union.sq Y, <=_(union.sq))$. L'ensemble $X union.sq Y$ désigne la somme disjointe de $X "et" Y$, et l'ordre est défini par :
  $
  a <=_(union.sq) b <==> (a, b in X and a lt.eq_X b) or (a, b in Y and a lt.eq_Y b)
  $

- La somme lexicographique : $(X union.sq Y, <=_+)$ où l'ordre est défini par :
  $
  a <=_+ b <==> (a, b in X and a lt.eq_union.sq b) or (a in X and b in Y)
  $

- Le produit cartésien : $(X times Y, lt.eq_X)$ où l'ordre est défini par :
  $
  (x_1, y_1) lt.eq_X (x_2, y_2) <==> x_1 lt.eq_X x_2 and y_1 lt.eq_Y y_2
  $

- Le produit lexicographique : $(X times Y, lt.eq_("lex"))$ où l'ordre est défini par :
  $
  (x_1, y_1) lt.eq_("lex") (x_2, y_2) <==> x_1 lt_X x_2 or (x_1 = x_2 and y_1 lt.eq_Y y_2)
  $

== 3. Relation Bien Fondée
*Définition :* Soit $(X, lt.eq)$ i, espace ordonné. Il est bien fondé ssi il n'existe pas de suite infinie strictement décroissante : $x_0 > x_1 > x_2 > dots > x_n > dots$

*Théorème :* Soit $(X, lt.eq)$ un espace ordonné, les propositions suivantes sont équivalentes :
1. $(X, lt.eq)$ est bien fondé
2. Toute suite strictement décroissante est finie
3. Toute suite décroissante est stationnaire
4. Toute partie $S subset.eq X$ non vide a un élément minimal
5. Le principe de récurrence est valide sur $(X, lt.eq)$

*Principe de récurrence :* Soit $P$  une propritété sur $X$.
$
[forall x in X, (forall y in X, y < x ==> P(y)) =>(x)] ==> forall x in X, P(x)
$

*Exemple :* $X = NN$ et $lt.tri$ la relation telle que $n lt.tri m <==> m = n + 1$

Montrons $forall n in NN, P(n)$ par récurrence.

Pour cela il suffit de montrer $[forall n in NN, (forall y in NN, y lt.tri x ==> P(y)) =>(n)]$

Soit $n in NN$, on suppose que $forall y in NN, y lt.tri n ==> P(y)$.

Hypothèse : $forall y in NN, y lt.tri n ==> P(y)$

Disjonction de cas :
1. Soit $n=0$, auquel cas $exists.not y : y lt.tri n$ donc l'hypothèse est une tautologie et je dois montrer $P(n)$ sans aide, c'est le cas de base, je montre $P(0)$.

2. Sinon $n > 0$, et mon hypothèse se reformule en $P(n-1)$. Je dois donc montrer $P(n)$ en supposant $P(n-1)$, c'est l'hérédité.

*Sur les arbres :* $lt.tri "tel que" cases(G lt.tri T(G, D),  D lt.tri T(G, D))$

*Sur les formules logiques :* (ensemble inductif) $"sous-formule" lt.tri "formule"$\
$E_0 = {top, bot, "var"}$.

*Démonstrations :*\
- $1 ==> 2$ : pas de suite infini $<==>$ les suites sont finies
- $1 ==> 3$ : Prenons $v_n$ suite strictement décroisssante
  - Si elle est finie alors elle stationne
  - Si elle est infinie alors elle ne peut pas être strictement décroissante, donc elle stationne
- $3 ==> 1$ : idem
- $1 ==> 4$ : Par l'absurde, soit $S subset.eq X$ n'ayant pas d'élément minimal
  - On choisit $x_0 in S$ quelconque
  - Comme $S$ n'a pas d'élément minimal, $exists x_1 in S : x_1 < x_0$
  - On réitère ce raisonnement pour construire une suite $infinity$ strictement décroissante\
  $
  x_0 > x_1 > x_2 > x_3> dots
  $
  - C'est impossible car $X$ est bien fondé, donc $forall S subset.eq X, S$ admet un élément minimal.
- $4 ==> 5$ : On veut montrer $A ==> B$ avec $cases(B = forall x in X : P(x), A = [forall x in X : C ==> P(x)])$\
  On suppose $A$ et on montre $B$
  - Soit $S = {x in X | P(x) "est faux"}$
  - Par l'absurde, supposons $S eq.not emptyset$.
  - Alors par 4, $S$ admet un élément minimal $x in S$
  - Cest-à-dire $forall y in X, y < x ==> y in.not S$
  - Par définition de $S$ : $forall y in X, y < x ==> P(y)$
  - Or $C = forall y in X, y < x ==> P(y)$
  - Donc comme on a supposé $A$, on obtient que $P(x)$ est vrai, or $s in S$ donc $P(x)$ est faux.
  - C'est absurde, donc $S = emptyset$. Autrement dit, $forall x in X, x in.not S$, soit exactement $B$.
- $5 ==> 1$ : Par l'absurde supposons qu'il existe $x_0 > x_1 > dots > x_n > dots$ une suite $infinity$ strictement décroissante.
  - On considère la propriété $P(x) : \"forall i in NN, x eq.not x_i\"$.\
  Montrons $P$ par récurrence :
  - Il suffit de montrer $A = forall x in X, (forall y in X, y < x ==> P(y)) ==> P(x)$
  - Soit $x in X$, supposons que $forall y in X, y < x ==> P(y)$ et montrons que $P(x)$
  - Il y a deux cas :
    - Si $forall i in NN, x eq.not x_i$, alors $P(x)$
    - Sinon $exists i_0 in NN : x = x_i_0$. Or $x_(i_0 + 1) > x_i_0$ et on a supposé $forall y in X, y < x ==> P(y)$. En prenant $y = x_(i_0 + 1)$ on obtient $P(x_(i_0+1))$ ce qui est faux, donc l'implication est vraie.
  Clarification : Avec $F = (forall y in X, y < x ==> P(y))$ on voulait montrer $F ==> P(x)$ et on a montré que $F$ est faux, donc l'implication est vraie.\
  Donc on a montré $A$, par principe de récurrence on en déduit $B = forall x in X, P(x)$ ce qui est absurde.

== 4. Application à la Terminaison
=== 4.1. Programme Récursifs

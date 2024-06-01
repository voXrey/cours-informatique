#set text(font: "Roboto Serif")

= Gloutons <gloutons>
== IV - Algorithmes d’approximation, un exemple <iv---algorithmes-dapproximation-un-exemple>
==== 1. La variante fractionnaire du problème du sac à dos <la-variante-fractionnaire-du-problème-du-sac-à-dos>
Dans cette variante, on autorise à prendre des quantités fractionnaires d’objets.

- n objets $lr((p_0 , v_0)) , . . . lr((p_(n - 1) , v_(n - 1)))$

- Question : trouver $alpha_0 , . . . alpha_(n - 1)$ appartenant à l’intervalle réel \[0;1\] tel que

  $sum_(i = 0)^(n - 1) alpha_i lt.eq P$

  $sum_(i = 0)^(n - 1) alpha_i v_i$ est maximale (parmi les solutions qui respectent la contrainte)

Ce problème se résout correctement via un algorithme glouton : on choisit l’objet de ratio $v_i / p_i$ maximal

#strong[Démonstration]

On commence par trier les objets par ratio décroissant. On suppose que c’est fait :

$v_0 / p_0 gt.eq . . . v_(n - 1) / p_(n - 1)$

On exclu les cas où n \= 0 ou P \= 0

La solution gloutonne est alors de la forme : $lr((1 , . . . 1 , alpha , 0 , . . .0))$ avec $alpha in \] 0 , 1 \]$ d’indice r et $sum_(i = 0)^(r - 1) p_i + alpha p_r = P$

et la valeur du sac est alors $sum_(i = 0)^(r - 1) v_i + alpha v_r$

Soit $lr((alpha_0 , . . . alpha_(n - 1)))$ une solution optimale

On a $sum_(i = 0)^(n - 1) alpha_i p_i = P$ (sauf si $sum_(i = 0)^(n - 1) p_i < P$ ce que l’on exclut car cas trivial)

On suppose par l’absurde que cette solution est différente de la gloutonne.

Soit $i_0$ le plus petit coefficient sur lequel les deux solutions diffèrent :

- Soit $alpha i_0 < 1$ si $i_0 > r$

- Soit $alpha i_0 < alpha$ si $i_0 = r$

- Ce sont les seuls cas possibles sinon la solution $lr((alpha_0 , . . . alpha_(n - 1)))$ ne respecte pas la contrainte du poids.

\$\\rarr \\exist K \>r : \\alpha\_K \> 0\$ ou $alpha_r > alpha$

Différents cas possibles :

#block[
  #set enum(numbering: "1)", start: 1)
  + $i_0 < r$

    On prend $beta = m i n lr(
      (frac(alpha_K p_K, P_(i_0)) , frac(lr((1 - alpha_(i_0))) p_(i_0), p_K))
    )$

    On montre que la solution $lr(
      (alpha_0 . . . , alpha_(i_0) + beta / p_(i_0) , alpha_(i_0 + 1) , . . . , alpha_K - beta / p_K , . . .)
    ) = lr((alpha_0 prime , . . . , alpha_(n - 1) prime))$

    C’est bien une solution :

    $sum_(i = 0)^(n - 1) alpha_i prime p_i = sum_(i = 0)^(n - 1) alpha_i p_i + beta / p_(i_0) - beta / p_K p_K = P$

    Et la valeur obtenue augmente

    $sum_(i = 0)^(n - 1) alpha_i prime v_i = sum_(i = 0)^(n - 1) alpha_i v_i + beta / p_(i_0) - beta / p_K v_K$ (la somme des deux derniers termes étant $0 lt.eq$)

    Or $i_0 < K$ donc $v_(i_0) / p_(i_0) gt.eq v_K / p_K$

    Donc $sum_(i = 0)^(n - 1) alpha_i prime v_i gt.eq sum_(i = 0)^(n - 1) alpha_i v_i$
]

#block[
  #set enum(numbering: "1.", start: 2)
  + $i_0 = r$

    Ce cas sera similaire : il faut remplir le coefficient r au maximum.
]

==== 2. Approximation de la variante classique <approximation-de-la-variante-classique>
On suppose encore les objets triés par ratio : $v_0 / p_0 gt.eq . . . v_(n - 1) / p_(n - 1)$

La solution optimale fractionnaire est de la forme $lr((1 , . . . 1 , alpha , 0 , . . .0))$ avec $alpha$ à l’indice r

Une approximation acceptable du problème initiale est : la meilleure solution entre $lr((1 , . . . 1 , 0 , . . .0))$ le premier 0 étant à l’indice r et $lr((0 , . . . 0 , 1 , 0 , . . .0))$ le 1 étant à l’indice r.

\$\\rarr\$ On suppose qu’on a retiré les objets trop gros !

Toute solution au problème "normal" est également une solution au problème fractionnaire.

Soit V la solution optimale au problème classique : $V lt.eq sum_(i = 0)^(r - 1) v_i + alpha v_r$

Donc :

- soit $sum_(i = 0)^(n - 1) v_i gt.eq V / 2$

- soit $v_r gt.eq alpha v_r gt.eq V / 2$

Cela s’appelle une $1 / 2$-approximation : on produit une solution qui est au moins la moitié de l’optimale.

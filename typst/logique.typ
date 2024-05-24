#set text(
  font: "Noto Sans Imperial Aramaic",
  size: 11pt
)

= Partie 5 - Logique
== Chapitre ? - Logique Propositionnelle

=== I - Syntaxe
Nos valeurs booléennes "vrai" et "faux" sont

- $top$ top

- $bot$ bot

Il existe différents ordres pour la logique

Ordre 0 : $not, and, or, -->, <--$

Ordre 1 : $forall, exists$...

$V$ ensemble de variables

On nommera selon cette convention :

Propositions : p, q, r, ... 

Variables propositionnelles : x, y, z, ...

```ocaml
type formula = Top | Bot | Var of variable
  | Not of formula
  | And of formula * formula
  | Or of formula * formula
  ...
```
Type inductif $eq.triple$ Ensemble inductif

$E_0 = {$Top, Bot$} union V$

$E_(n+1) = E_n union {phi_1 join phi_2 | phi_1,phi_2 in E_n, join in {and, or, -->, <-->}}union {not phi | phi in E_n}$

#underline[Connecteurs logiques] : $not, and, or, -->, <-->$

#underline[Arité] : nombre d'arguments. $not$ unaire (arité 1). Les autres sont binaires.

Une formule logique peut être représentée par un arbre. Aux feuilles on a des variables ou $top$ ou $bot$. Aux noeuds internes on a des connecteurs logiques.


$-->$ On reprend le vocabulaires des arbres

#underline[Exemple] :

$"var"(phi)$ est définit inductivement.

$"var"(top)$ = $"var"(bot)$ = $emptyset$

...


Syntaxiquement, $(x and y) and z != x and (y and z)$

=== II - Sémentique

#underline[Valuation] : $v : V --> {0, 1}$. Le programme interprète les formules dans ${V, F}$

#underline[Evaluation des formules] : On prolonge les valuations "par morphisme" pour toutes les formules.

Soit v une valuation. On définit $accent(v, -):E --> {0, 1}$.

$accent(v, -)(bot) = 0$

$accent(v, -) = 1$

$accent(v, -) = v(x)$

$accent(v, -)(not phi) = 1 - accent(v, -)(phi)$

$accent(v, -)(phi join psi) = "table de "join" appliquée à" accent(v, -)(phi) "et" accent(v, -) (psi)$

#underline[Page 7 du poly] :

#underline[Notation] : $v models phi <=> v(phi) = 1$

avec une barre c'est $<=> v(phi) = 0$

$accent(v, -)(phi) = [|phi|]_v$

$v models phi$ "est un model satisfait"

satisfaisable / satfisfiable

tautologique = valide

antilogie

$phi models psi <--> forall v, v models phi --> v models psi$

Equivalence logique : $phi models psi$ et $psi models phi$ parfois notée $eq.triple$

=== 4 - Liens Syntaxe Sémantique

- La valeur de $accent(v, -)$ ne dépend que de $v(x)$ pour $x in$ $"var"(phi)$

#underline[Preuve par induction structurelle] :

Soit v et w tels que $v(x) = w(x) forall x in $ $"var"(phi)$.

- Si $phi = top$ alors $accent(v, -)(phi) = 1 = accent(w, -)(phi)$

- Si $phi = bot$ ...

- Si $phi = x$ alors $x in$ $"var"(phi)$ donc par hypothèse $v(x) = w(x)$ donc $accent(v, -)(x) = accent(w, -)(x)$

- Si $phi = not psi$ alors par induction structurelle : $accent(v, -)(psi) = accent(w, -)(psi)$. Donc $accent(v, -)(phi) = 1 - accent(v, -)(psi) = 1 - accent(w, -)(psi) = accent(w, -)(phi)$

Remarque : L'hypothèse d'induction s'applique car var($psi$) $subset.eq$ $"var"(phi)$.

- Si $phi = phi_1 join phi_2$ alors par induction $accent(v, -)(phi_1) = accent(w, -)(phi_1) and accent(v, -)(phi_2) = accent(w, -)(phi_2)$.En effet, var($phi_1$) $subset.eq$ $"var"(phi)$ et var($phi_2$) $subset.eq$ $"var"(phi)$.

Donc v et w coïncident sur var($phi_1$) et var($phi_2$).

Donc $accent(v, -)(phi) = accent(w, -)(phi)$ puisque le même calcul sur $accent(v, -)(phi_1)$ et $accent(v, -)(phi_2)$ s'opère dans le tableau de vérité. 

- $phi models psi$ ssi $phi --> psi$ est une tautologie

$phi models psi$ ssi $forall v$ valuation $v models phi$ implique $v models psi$ ssi $accent(v, -)(psi) = 1$ lorsque $accent(v, -)(phi) = 1$ ssi $accent(v, -)(phi -> psi) = 1$ d'après le tableau de vérité.

- $phi$ sat ssi $exists v : v models phi$ ssi $exists v : accent(v, -)(not phi) = 0$ ssi $not phi$ n'est pas valide


=== 5 - Prouver qu'une formule est une tautologie

==== 5.1 - Table de vérités

$phi$ tautologie ssi $forall v$ valuation $v models phi$

$-->$ BruteForce

Nombre $infinity$ de valuations mais $accent(v, -)(phi)$ ne dépend que de $v(x_1), v(x_2)... v(x_n)$ où ${x_1, ... x_n} =$ $"var"(phi)$.

$phi = x and y <--> y and x$

$"var"(phi)$ $= {x, y}$

#table(
  align: center,
  columns: 4,
  [$v(x), v(y)$], [$x and y$], [$y and x$], [phi],
  [0, 0], [0], [0], [1],
  [0, 1], [0], [0], [1],
  [1, 0], [0], [0], [1],
  [1, 1], [1], [1], [1],
)
Est une tautologie évidente

Autre exemple : $phi = ((x or y) and (not y or z)) --> x or z$

On notera $psi$ l'intérieur du membre gauche de $phi$

#table(
  align: center,
  columns: 6,
  [$v(x), v(y), v(z)$], [$x or y$], [$not y or z$], [$psi$], [$x or z$], [$phi$],
  [0, 0, 0], [0], [1], [0], [0], [1],
  [0, 0, 1], [0], [1], [0], [1], [1],
  [0, 1, 0], [1], [0], [0], [0], [1],
  [0, 1, 1], [1], [1], [1], [1], [1],
  [1, 0, 1], [1], [1], [1], [1], [1],
  [1, 1, 0], [1], [0], [0], [1], [1],
  [1, 1, 1], [1], [1], [1], [1], [1]
)

Il sagit donc d'une tautologie

#underline[Coût de la méthode] : n variable $==> 2^n$ lignes

==== 5.2 - Substitutions

Dans l'arbre, on remplace les feuilles avec x par des sous-arbres $psi$.

==== 5.4 - Réduction à SAT

$phi$ autologie ssi $not phi$ non satisfiable

Le problème :
- Entrée : Une formule $phi$
- Question : Est-elle satisfiable ?
S'appelle SAT

=== 7 - Systèmes de connecteurs Complets

$C = {not, or, and, -->, <-->}$

On sait réécrire les formules utilisant les connecteurs $-->$ et $<-->$ en des formules logiquement équivalentes et qui n'utilisent plus ces connecteurs. Autrement dit, on aurait pu construire E en prenant les connecteurs $C'={not, or, and}$.

En utilisant de Morgan, on réécrit $p and q eq.triple not (not p or not q)$.

Puis $C'' = {not, or}$ et même $C''' = {accent(and, -)}$ avec

#table(
  align: center,
  columns: 3,
  [$accent(and, -)$], [0], [1],
  [0], [1], [1],
  [1], [1], [0]
)

On a $not p eq.triple p accent(and, -) p$

Donc $p and q eq.triple not (p accent(and, -) q)$ car $p accent(and, -) q eq.triple not (p and q)$

=== 8 - FNC / FND

On se place dans le système complet ${not, and, or}$.

#underline[Littéraux] : Variables à négation de variable

#underline[Clause] : Disjonction de littéraux : $x or not y or z or t or not u$

#underline[Conjonction de clause] : $(x or not y or z) and (x or y or z) and (not x or z)$

#underline[Anticlause] : $x and y and not z$

#underline[FND] : $(...) or (...) or (...)$

Une forme normale serait un cas où $phi eq.triple psi$ ssi forme-normale($phi$) = forme-normale($psi$)

#underline[Prop] : Pour toute formule $phi$ il existe $psi_1$ et $psi_2$ des formules équivalentes à $phi$ telles que $psi_1$ en FNC (ou l'inverse).

Connaissant un FNC de $phi$, il est "facile" de trouver une FND de $not phi$

$phi = and.big_(i=1)^n or.big_(j=1)^(p_i) l_(i,j)$

$not phi = or.big_(i=1)^n not or.big_(j=1)^p_i l_(i,j) = or.big_(i=1)^n and.big_(j=1)^p_i not l_(i,j)$.

#underline[Deux cas] :
- Si $l_(i,j)$ est une variable alors $not l_(i,j)$ est un littéral
- Si $l_(i,j)$ est la négation d'une variable x alors $not l_(i,j) eq.triple x$.

==== 8.3 - Mise en Forme Normale
===== 1) Via table de vérité
On remarque qu'une FND se déduit directement de la table de vérité : on remarque les lignes avec du 1.

Une anticlose est similaire à une valuation. Une FND s'obtient comme la liste des valuations qui satisfont $phi$.

#underline[Rappel] : Pas unicité de la FND.
Ici $phi = (x and not y) or (y and z) or (x and z) or (y and not y)$. Le dernier terme peut être retiré.

#underline[Remarque] : On appelle FND (ou FNC) canonique une FND telle que chaque anticlause (resp. clause) qui contient exactement une fois chaque variable. Alors, il y a unicité de la FND canonique à l'ordre prêt.

===== 2) Via réécriture
Il s'agit de faire un parcours d'arbre avec un pattern-matching afin de remplacer certaines formes de sous-formules.

Il faudra faire ce parcours tant qu'il y aura quelque chose à modifier. On arrête la boucle quand la formule n'est plus modifiée.

```c
to_fnc(F):
  - remplacer les implications et équivalences comme dans la section 7
  - Tant que possible
      - Trouver une sous formule de F de la forme !(F1 || F2)
        et la remplacer dans F par (!F1 && !F2)
      - Idem avec une sous formule de la forme !(F1 && F2)
      - Idem avec une sous formule de la forme (F1 || (F2 && F3))
        par (F1 || F2) && (F1 || F3)
      - Idem avec (F1 && F2) || F3
```
#underline[A retenir] : La complexité reste exponentielle dans le pire des cas, mais il y aura des cas dans lesquels "cela se passe mieux" tandis que la construction de la table de vérité était exponentielle dans tous les cas. Notamment, en pratique sur de petits exemples, ce sera plus rapide que la table de vérité.

#underline[Remarque] : On va identifier un type de pire cas : $phi_n = or.big_(i=1)^n (x_i and y_i)$. Appliquer la distributivité du $or "sur le" and$ va se générer en formule équivalente à $phi_n$ en FNC, mais de taille exponentielle (voir 8.3.1). Donc notre algorithme de mise en FNC s'exécutea sur $phi_n$ en temps $Omega(2^n)$ au moins.

#underline[Remarque] : Complexité de la mise en FNC/FND : On a 2 méthodes en temps exponentiel.

#underline[Proposition] : Il n'existe pas d'algorithme de mise en forme normale qui soit de complexité $O(n^K)$ pour un entrant K.

#underline[Preuve] : $forall psi "en FNC" : psi eq.triple phi_n, |psi| >= 2^n$

*Preuve de la terminaison*

On définit q par induction structurelle sur les formules :

$forall x in V q(x) = 2 \
q(phi_1 and phi_2) = q(phi_1) + q(phi_2) + 1 \
q(phi_1 or phi_2) = q(phi_1) q(phi_2) \
q(not phi) = 4^q(phi)$

On montre que q est un variant de boucle pour la boucle while de l'algorithme.

On fait le calcul pour 1 des 4 règles.

$q(not(F_1 and F_2)) = 4^(q(F_1) + q(F_2) + 1)\
"et"\
q(not(not F_1 or not F_2)) = 4^q(F_1) 4^q(F_2) = 4^(q(F_1)+q(F_2)) < q(F_3)$

Petit rappel : On note $x_i, y_i, z_i$ les valeurs des variables au début du $i^e$ tour de boucle. Comme q est un variant :

$q(x_0, y_0, z_0) > q(x_1, y_1, z_1) > q(x_2, y_2, z_2) > ...> q(x_d, y_d, z_d).$

On veut majorer d (le nombre d'itération du while) : $d <= q(x_0, y_0, z_0) + 1$

Ici, la mise en FNC de $phi$ s'exécute en temps [au plus] $O(q(phi))$

C'est non satisfaisant car $q(phi)$ peut être de la forme $4^.^.^.^4^n | n = |phi|$.


===== 3) CNF Rapide
*Hors-programme*

Il existe un algorithme qui étant donné $phi$ produit $psi$ en FNC en temps polynomial tel que :

$exists v : v models phi <=> exists w : w models psi$

On dit que $phi$ et $psi$ sont équisatisfiables. 

=== 9 - Logique = Langage de Spécification

==== Problème du Pavage
$n "et" m$ les dimensions de rectangles à carreler

$S = {s_0, ..., s_(p-1)}$ l'ensemble des tuiles

$s_i = (n_i, e_i, s_i, o_i)$

Ensemble des variables : $p_(i,j,k)$ vraie si la tuile $s_k$ se trouve en position $(i, j)$.

A chaque emplacement $(i, j)$, une seule tuile

$and.big_(i = 1)^n and.big_(j = 1)^m and.big_(k=0)^(p-1) (p_(i,j,k) -> and.big_(l=0\ l eq.not k) not p_(i,j,l))$

Pour chaque emplacement il y a une tuile dessus

$and.big_(i=1)^n and.big_(j=1)^m (or.big_(k=0)^(p-1)p_(i,j,k))$

=== 10 - Problème SAT
C'est le nom que l'on donne au problème suivant :

#underline[Entrée] : $phi$

#underline[Question] : $phi$ est-elle satisfiable ?

#underline[Remarque] : $phi "SAT" <=> not phi "n'est pas valide"$. Le problème SAT est "équivalent" à la question "est-ce que $phi$ est une tautologie".

==== 1) BruteForce==== 1) BruteForce

On a une fonction d'évil renvoie uation `eval v phi` renvoie $accent(v, -)(phi)$.

On énumère les évaluations jusqu'à en trouver une qui satisfasse $phi$.

Correspond à l'approche "table de vérité"

==== 2) Algorithme de Quine

Algorithme permettant de savoir si $phi$ est satisfiable
```python
is_sat(phi):
  if var(phi) = void:
    renvoyer True ou False # phi vraie ou fausse
  else:
    for x in var(phi):
      if is_sat(phi[x <- Top])
        return True
      else:
        return is_sat(phi[x <- Bot])
```

==== 3) Raffinement dans le cas d'une CNF

$-->$ Le vrai algorithme de Quine

#underline[Littéral] : $x "ou" not x$
```ocaml
type litteral =
  | Lit of variable
  | Nlit of variable
```

#underline[Clause] : Disjonction de littéraux
```ocaml
type clause = litteral list
```

_Remarque : La clause vide équivaut à $bot$_

#underline[FNC] : Conjonction de clauses
```ocaml
type fnc = clause list
```
_Remarque : La fonction vide équivaut à $top$_

```python
# Précondition : phi en CNF
is_sat(phi):
  if phi est la fnc vide: return Tru
  if phi contient une clasuse vide: return False
  else:
    for x in var(phi):
      # On effectue un max de simplifications lors de la substitution
      if is_sat(phi[x<-Top]): return True
      else: return is_sat(phi[x<-Bot])
```
Mais que nous apporte la FNC ? Elle facilite les simplifications.

$phi[x<-top] --> "pour chaque clause c"$
- Si $x$ est dans c, on supprime la clause
- Si $not x$ est dans c, on retire $not x$ de la clause
Avec $phi[x<-bot]$ analogue

#underline[Optimisation] : Propagation des clauses unitaires : Si une clause c n'a qu'un seul littéral, on le met à directement à vrai.

#underline[Remarque] : La CNF permet de rendre plus efficace les simplifications dans l'algorithme de BackTracking de Quine. Mais la mise en CNF est exponentielle, d'où l'intérêt de la CNF rapide.

Amicalement Grégoire

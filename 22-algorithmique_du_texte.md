# Chapitre 22 : Algorithmique du Texte

## Notations et Vocabulaire

### Notations

On appelle alphabet, souvent noté $\Sigma$, un ensemble fini de symboles. 

> Exemple : $\Sigma = \{ASCII\}$
> 
> $|\Sigma| = 256$

> Exemple : En bio-informatique
> 
> $\Sigma = \{A, T, C, G\}$
> 
> $|\Sigma| = 4$

On fixe un alphabet sur $\Sigma$.

Un mot est une suite finie de symboles de $\Sigma$. $u = a_0, ... a_{n-1}$. On note $|u| = n$ la longueur de u. Les $a_i$ sont les lettres de u. On notera $u[i] = a_i$ le $i^e$ caractère de u.

On note $\epsilon$ le mot vide (l'unique mot de longueur 0).

On note $\Sigma ^*$ l'ensemble des mots.

On note $\circ$ la concaténation des mots. $u \circ v = a_0...a_{n-1}b_0...b_{m-1}$ avec $u=a_0...a_{n-1}$ et $v = b_0...b_{m-1}$. On écrit souvent $uw$ au lieu de $u \circ w$.



### Vocabulaire

u est un préfixe de v si

* $u = a_0....a_{n-1}$

* $v = a_0...a_{n-1}a_n...a_{m-1}$

Respectivement "suffixe"

u est un facteur de v s'il existe un mot w tel que $wu$ est un préfixe de v.

$m[i:j]$ est le facteur de m entre position i (inclus) et j (exclus), $m = a_0...a_{n-1} \Longrightarrow m[i:j] = a_i...a_{j-1}$



## I - Recherche de Mot dans un Texte

### 1. Algorithme de Robin Karp

#### a. Algorithme naïf

<u>Première approche</u>

<img src="https://prepinstadotcom.s3.ap-south-1.amazonaws.com/wp-content/uploads/2022/01/Rabin-karp-algorithm.webp" title="" alt="Rabin Karp Algorithm Pattern matching | Prepinsta" width="504">

$m, T\in\Sigma ^*$

On veut savoir si m est un facteur de T

Pour $i_0 \in [0, |T|-|m|[$

Tester si $m=T[i_0:i_0+|m|]$

```py
algo_naif(texte, motif) # tiré de wikipédia
1.  n ← longueur(texte)
2.  m ← longueur(motif)
3. pour i de 1 à n-m+1 faire
4.    si texte[i..i+m-1] = motif[1..m]
5.       motif trouvé dans le texte à la position i
6. motif non trouvé
```

Complexité en $O((|T|-|m|)|m|)$

> Exemple pire cas :
> 
> m = "dauphin"
> 
> T = "dauphi dauphi dauphi..."

<u>Idée de l'algorithme</u>

On prend une fonction de hachage h et on remplace le test $m==T[i_0, i_0+m]$ par le test $h(m) = h(T[i_0, i_0+m])$

S'il y a égalité des haches, alors on fait le premier test.

Empiriquement, si h est "bien faite" (peu de collisions) alors on s'attend à réaliser le premier test beaucoup moins souvent.

> Problème : Le calcul de h(m) est en $O(|m|)$

Pour l'algorithme on choisit $h(m) = \sum_{i=0}^{|m|-1}{c(m[i])|\Sigma|^i} mod(N)$ avec $c:\Sigma \rightarrow [0, |\Sigma|[$ une énumération de $\Sigma$.

$\Longrightarrow h(m)$ se calcule en $O(|m|)$

<img src="https://www.researchgate.net/publication/319954837/figure/fig2/AS:631660399828998@1527610983175/Comparisons-performed-by-the-Karp-Rabin-pattern-matching-algorithm.png" title="" alt="3: Comparisons performed by the Karp-Rabin pattern matching algorithm. |  Download Scientific Diagram" width="332">

<u>L'algorithme</u> 

On obtient $h(T|i_0: i_0+|m|] = h(T[i_0-1: i_0-1+|m|])/|\Sigma| + \sum^{|m|-1}c(T[i_0+|m|-1]) mod(N)$

La somme est calculée qu'une seule fois.

On prend $h_m$ le haché de m

On calcule $\sum^{|m|-1}$.

$h_T$ = haché $T[0:|m|-1] * |\Sigma|$

Pour $i_0\in[0, |T| - |m| [$

    $h_T = h_T/|\Sigma| + \sum^{|m|-1} * c(T[i_0+|m|-1])$

    Si $h_T == h_m:$

        Si $m==T[i_0:i_0+|m|]$:

            Retourner vrai

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



<u>Complexité</u> : Dans le pire cas on effectue le test `m == T[...]` à chaque fois et on a donc rien gagné. L'analyse de complexité pire cas n'est pas pertinente ici. L'efficacité empirique de cet algorithme repose sur le fait que lorsque $m \space !=T[i_0:i_0+|m|]$ alors $h_m != h_T$ dans la plupart des cas.

Autrement dit, les cas où $h_T = h_m$ et $m \space!= T[...]$ sont rares.



### 2. Algorithme de Boyer-Moore

#### a. Algorithme (version 1)<img src="https://www.researchgate.net/publication/337265181/figure/fig2/AS:825303362437121@1573779063161/Intuition-of-the-Boyer-Moore-search-procedure.png" title="" alt="Intuition of the Boyer-Moore search procedure. | Download Scientific Diagram" width="527">

```python
algo
1. i0 = 0
2. Tant que i0 <  |T| - |m|
3.     tester m == T[i0 : i0 + |m|] en partant de la droite
4.     Si cela échoue, en prenant compte de T[i0 + |m| - 1]
5.         On se décale intelligament : i0 = i0 + decalage(T[i0+|m -1])
```

Comment construire `décalage` ?

Pour représenter cette fonction on pourrait utiliser un tableau "offset" et une énumération de $\Sigma$, notée c de sorte que $offset[c(a)] = decalage(a) \forall a\in\Sigma$

<u>Inconvénient</u> : Beaucoup d'espace utilisé pour rien puisque $\forall a \in\Sigma$ qui n'es pas dans m on a $decalage(a) = |m|$.

On utilise donc un dictionnaire dont les clés sont les caractères présents dans m et la valeur associée à $a\in\Sigma$ sera $decalage(a)$.



<u>Complexité</u> :

* Pire des cas : Si $i_0 = i_0 +1$ à chaque boucle (irréaliste) alors on est en $O((|T|-|m|)|m|)$. Cette analyse n'est pas adaptée, l'amélioration est empirique.

* Meilleur cas : $i_0 = i_0 +|m|$.
  
  On est en $O(\frac{|T|-|m|}{|m|})$.





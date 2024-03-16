# Diviser Pour Régner



## Introduction aux algorithmes

Ce sont des techniques classiques pour résoudre un problème donné.

Par exemple : trier une liste d'éléments. On appelle alors une <u>instance</u> du problème une liste en particulier. 

Un algorithme qui résout un problème P permet de donner une solution à chaque instance. 



## I - Principe

Pour résoudre un problème P sur une instance $I$ :

* [0] - Cas de base : Les "petites" instances sont résolus immédiatement.

* [1] - Diviser : On "découpe" $I$ en sous-instances $I_1,...I_k$.

* [2] - Régner : On résout (récursivement) les sous-instances.

* [3] - Combiner : On combine les solutions des instances $I_1,...I_k$ pour donner une solution à l'instance $I$.

*Remarque : on appelle les sous-instances des <u>sous-problèmes</u>.*



## II - Exemples

#### Tri fusion





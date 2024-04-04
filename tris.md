# Complément sur les Tris

## Introduction

<u>Vocabulaire</u>

* Tri **comparatif** : fonctionne pour n'importe quel ensemble $(X,\le)$ totalement ordonné.

* Tri **en place** : on trie le tableau d'entrée en place, via le souvent des échanges / interversion / transposition, **sans copier le tableau** et en espace auxiliaire $O(1)$.

* Tri **stable** : en pratique on trie des tableaux selon une **clé** mais chaque case du tableau a aussi des **données satellites**. À clés égales, l'ordre initial est préservé.

| Tri         | Temps                                   | Espace      | En place | Stable           | Comparatif |
|:-----------:|:---------------------------------------:|:-----------:|:--------:|:----------------:|:----------:|
| `Bulle`     | $O(n²)$                                 | $O(1)$      | Oui      | Oui              | Oui        |
| `Sélection` | $O(n²)$                                 | $O(1)$      | Oui      | Non              | Oui        |
| `Insertion` | $O(n²)$                                 | $O(1)$      | Oui      | Oui              | Oui        |
| `Fusion`    | $O(nlog(n))$                            | $O(n)$      | Non      | Oui              | Oui        |
| `Rapide`    | $O(n²)$ au pire $O(nlog(n))$ en moyenne | $O(1)$      | Oui      | Si pivot devant  | Oui        |
| `ABR`       | $O(nlog(n))$ en moyenne                 | $O(n)$      | Non      | Selon la gestion | Oui        |
| `Heap`      | $O(nlog(n))$                            | $O(1)$      | Oui      | Probablement pas | Oui        |
| `Comptage`  | $O(n+max(a))$                           | $O(max(a))$ | Non      | Oui              | Non        |
| `Sleep`     | X                                       | $O(n)$      | Non      | Non              | Non        |

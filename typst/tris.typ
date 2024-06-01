#set text(font: "Roboto Serif")

= Complément sur les Tris <complément-sur-les-tris>
== Introduction <introduction>
Vocabulaire

- Tri #strong[comparatif] : fonctionne pour n’importe quel ensemble $lr((X , lt.eq))$ totalement ordonné.

- Tri #strong[en place] : on trie le tableau d’entrée en place, via le souvent des échanges / interversion / transposition, #strong[sans copier le tableau] et en espace auxiliaire $O lr((1))$.

- Tri #strong[stable] : en pratique on trie des tableaux selon une #strong[clé] mais chaque case du tableau a aussi des #strong[données satellites]. À clés égales, l’ordre initial est préservé.

#figure(
  align(
    center,
  )[#table(
    columns: 6,
    align: (col, row) => (center, center, center, center, center, center,).at(col),
    inset: 6pt,
    [Tri],
    [Temps],
    [Espace],
    [En place],
    [Stable],
    [Comparatif],
    [`Bulle`],
    [$O lr((n ²))$],
    [$O lr((1))$],
    [Oui],
    [Oui],
    [Oui],
    [`Sélection`],
    [$O lr((n ²))$],
    [$O lr((1))$],
    [Oui],
    [Non],
    [Oui],
    [`Insertion`],
    [$O lr((n ²))$],
    [$O lr((1))$],
    [Oui],
    [Oui],
    [Oui],
    [`Fusion`],
    [$O lr((n l o g lr((n))))$],
    [$O lr((n))$],
    [Non],
    [Oui],
    [Oui],
    [`Rapide`],
    [$O lr((n ²))$~au pire~$O lr((n l o g lr((n))))$~en moyenne],
    [$O lr((1))$],
    [Oui],
    [Si pivot devant],
    [Oui],
    [`ABR`],
    [$O lr((n l o g lr((n))))$~en moyenne],
    [$O lr((n))$],
    [Non],
    [Selon la gestion],
    [Oui],
    [`Heap`],
    [$O lr((n l o g lr((n))))$],
    [$O lr((1))$],
    [Oui],
    [Probablement pas],
    [Oui],
    [`Comptage`],
    [$O lr((n + m a x lr((a))))$],
    [$O lr((m a x lr((a))))$],
    [Non],
    [Oui],
    [Non],
    [`Sleep`],
    [X],
    [$O lr((n))$],
    [Non],
    [Non],
    [Non],
  )],
)

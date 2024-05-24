# Huffman
```ocaml
(* Rappel *)
type codage = Leaf of Sigma | Node of codage * codage;;
```
## Codage Optimal
### En Pseudo-Code
```python
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
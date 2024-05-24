# Lampel Ziv

## Compression
### En Pseudo-Code
```python
def compression(T):
    i = 0
    d = dict([(S[i],i) for i in range(len(S)])
    symbole = n
    while i < len(T):
        Trouver le plus petit j tel que T[i:j] not in d
        d[T[i:j]] = symbole
        symbole += 1
        print(d[T[i:j-1]])
        i = j-1
    return d
```

## Décompression
### En Pseudo-Code
```python
def decompression(c):
    d = {}
    for i in range(len(S)): d[i] = S[i]
    print(d[c[0]])
    
    precedent = d[c[0]]
    for i in range(1, len(c))
        d[output_precedant+d[c[i]][0]]
        print(d[c[i]])
```

# Rabin Karp
## Pseudo-Code
```c
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
## En C
`rabinkarp.c`
```c
// Pour les mod
static int prime = 6644843;

// Taille d'un char*
int len_s (char* s){
    int i = 0;
    while(s[i] > 0){
        i ++;    
    }
    return i;
}

// Tester si 2 char* sont égaux
bool is_equal (char* m, char* s, int len){
    for (int i = 0; i < len;i++){
        if (m[i] != s[i]){
            return false;
        }
    }
    return true;
}

// Fonction puissance adaptée
int power(int x, int y, int p)
{
    int res = 1;
    while (y > 0) {
        if (y % 2 == 1)
            res = (res * x)%p;
        y = y >> 1;
        x = (x * x)%p;
    }
    return res % p;
}

// Fonction de hash choisie
int hash (char* s, int len, int sigma){
    int puiss = 1;
    int hache = 0;
    for (int i = 0; i < len; i++){
        hache += (s[i]*puiss) % prime ;
        puiss*= sigma % prime;
        puiss = puiss % prime;
    }
    return hache;
}

// Algo principal
int rabinkarp(char* m, char* t, int lenm, int lent, int sigma){
    int hm = hash(m, lenm, sigma);
    int ht = hash(t, lenm-1, sigma);
    int puiss = power(sigma, lenm-1, prime);

    for (int i = 0; i < lent-lenm; i++){
        ht = (ht/sigma) + puiss * t[i+lenm-1];
        if (ht = hm){
            if (is_equal(t+i, m, lenm)){
                return i;
            }
        }
    }
    return -1;
}

// Pour l'utiliser
int main(int argc, char** argv) {
    if (argc == 3){
        int lent = 0;
        char* t = txt(argv[2],&lent);
        printf("%d", rabinkarp(argv[1], t, len_s(argv[1]), lent, 256));
    }
    return 0;
}
```
`script.sh`
```bash
gcc -o RK rabinkarp.c
./RK "AAATCTCTAT" txt\
```
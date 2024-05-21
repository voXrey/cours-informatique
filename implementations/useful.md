# Utilitaires
## Récupérer le texte d'un fichier
```c
// Le pointeur len permet de renvoyer la taille
char* txt(char* name, int* len){
    // Récupération de la taille
    int i = 0;
    FILE* f = fopen(name,"r");
    assert(f != NULL);
    while (fgetc(f) != EOF){
        i ++;
    }
    *len = i;
    fclose(f);
    
    // Récupération du texte
    FILE* f2 = fopen(name,"r");
    char* t = malloc(sizeof(char)*(i+1));
    t[i] = 0;
    for (int j = 0; j < i; j++){
        t[j] = fgetc(f2);
    }
    fclose(f2);

    return t;
}
```

## Taille d'un `char*`
```c
// On rappel que le caractère nul se traduit
// par l'entier 0
int len_s (char* s){
    int i = 0;
    while(s[i] > 0){
        i ++;    
    }
    return i;
}
```

## Egalité de 2 `char*`
```c
// A adapter selon le besoin, en particulier sur les tailles
bool is_equal (char* m, char* s, int len){
    for (int i = 0; i < len;i++){
        if (m[i] != s[i]){
            return false;
        }
    }
    return true;
}
```
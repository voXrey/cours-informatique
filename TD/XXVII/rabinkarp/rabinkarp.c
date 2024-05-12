/// LISEZ BIEN LA CONSIGNE DANS L'ONGLET DESCRIPTION !
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <limits.h>
#include <assert.h>
#include <string.h>

int const SIGMAN_LEN = 4;

int pow_(int x, int n) {
    if (n == 0) return 1;
    if (x == 0) return 0;
    if (n % 2 == 0) {
        int y = pow_(x, n/2);
        return y*y;
    }
    else {
        int y = pow_(x, n/2);
        return y*y*x;
    }
}

int hash(char* text, int len) {
    int h = 0;
    int s_powered = 1;

    for (int i = 0; i < len; i++) {
        h = (h + (int)text[i] * s_powered) % INT_MAX;
        s_powered = s_powered * SIGMAN_LEN;
    }
    return h;
}

bool is_string_equal(char* s1, char* s2, int start_s1, int start_s2, int len) {
    int i = start_s1;
    int j = start_s2;

    while ((i - start_s1 < len) && (s1[i] == s2[j])) {
        i++;
        j++;
    }
    return (s1[i] == s2[j]);
}



/// Qu 1 : compléter comme dans le cours : 

int rabinkarp(char* m, char* T) {
    int n_len = strlen(T);
    int m_len = strlen(m);

    int sigma_powered = pow_(SIGMAN_LEN, m_len-1);
    int hm = hash(m, m_len);

    int hT = hash(T, m_len);

    for (int i = 0; i <= n_len - m_len; i++) {
        //printf("hm: %d, hT: %d\n", hm, hT);

        if (hT == hm) {
            if (is_string_equal(T, m, i, 0, m_len)) return i;
        }

        if (i < n_len - m_len) {
            hT = (SIGMAN_LEN * (hT - (T[i] * sigma_powered) % INT_MAX) + T[i + m_len]) % INT_MAX;
        }
    }

    return -1;
}

/// Qu 2 : Modifier le pg précédent pour qu'il lise le texte dans le fichier filename
/*
bool rabinkarp(char* m, char* filename) {
    
}

*/

/// Qu 3 : compléter la fonction main afin de lui donner le comportement décrit dans l'énoncé.

int main(int argc, char** argv) {
    printf("Début de la recherche...\n");
    assert(argc == 3);
    char* motif = argv[1];
    char* filename = argv[2];

    FILE* buffer = fopen(filename, "r");
    if (buffer == NULL) assert(false);
    
    fseek(buffer, 0, SEEK_END);
    int n = ftell(buffer) + 1;
    fseek(buffer, 0, SEEK_SET);
    
    char* text = malloc(sizeof(char)*n);
    text = fgets(text, n, buffer);

    int i = rabinkarp(motif, text);
    if (i == -1) printf("Le motif '%s' n'a pas été trouvé dans le fichier %s.\n", motif, filename);
    else printf("Le motif '%s' a été trouvé dans le fichier %s à l'emplacement %d.\n", motif, filename, i);

    return 0;
}

/// NB : si vous travaillez dans un environnement UNIX alors vous pourrez compiler 
/// vous même votre programme puis utiliser l'exécutable comme bon vous semble.

/// Pour ceux qui travaillent directement dans Caséine, vous n'avez pas directement accès au terminal.
/// J'ai donc fait en sorte que Caséine fasse ceci : 
/// - il exécute le fichier compilation.sh; à vous d'y écrire la bonne commande de compilation.
/// - il exécute ensuite le fichier script.sh
/// Vous pouvez donc écrire dans ce fichier script.sh les commandes que vous auriez voulu écrire 
/// dans le terminal. Par défaut, ce fichier contient la commande
///     ./RK "AAATCTCTAT" txt
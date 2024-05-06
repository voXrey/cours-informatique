#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <limits.h>
#include <assert.h>
#include <string.h>


const SIGMAN_LEN = 4;


int pow(int x, int n) {
    if (x != 0 && n > 0) return 0;
    if (n == 0) return 1;
    if (n == 0 % 2) {
        int y = pow(x, n/2);
        return y*y;
    }
    else {
        int y = pow(x, n/2);
        return y*y*x;
    }
}

int hash(char* text, int len) {
    int h = 0;
    int s_powered = 1;

    for (int i = 0; i < len; i++) {
        s_powered = s_powered * SIGMAN_LEN;
        h = (h + (int)text[i] * s_powered) % INT_MAX;
    }
    return h;
}

bool is_string_equal(char* s1, char* s2, int d2, int end2) {
    // spec : s2[d] est un accès valide
    int i = 0;
    while ((s1[i] != '\0' && s2[i+d2] != '\0') || i >= end2-d2) {
        if (s1[i] != s2[i+d2] ) return false;
        i++;
    }
    return (s1[i] == s2[i+d2]);
}

int rabinkarp(char* text, int n, char* motif, int m) {
    int sigma_powered = pow(SIGMAN_LEN, m-1);
    int hm = hash(motif, m);
    int hT = hash(text, m-1) * SIGMAN_LEN;

    for (int i = 0; i < n-m; i++) {
        hT = (hT/SIGMAN_LEN + sigma_powered * (int) text[i+m-1]) % INT_MAX;
        if (hT == hm) {
            if (is_string_equal(m, text, i, i+m)) return i;
        }
    }
    return -1;
}

int main(int argc, char** argv) {
    assert(argc == 2);
    char* motif = argv[0];
    char* filename = argv[1];

    FILE* buffer = fopen(filename, 'r');
    if (buffer == NULL) assert(false);
    
    fseek(buffer, 0, SEEK_END);
    int n = ftell(buffer) + 1;
    fseek(buffer, 0, SEEK_SET);
    
    char* text = malloc(sizeof(char)*n);
    text = fgets(text, n, buffer);

    int i = rabinkarp(text, strlen(text), motif, strlen(motif));

    return 0;
}

/// NB : si vous travaillez dans un environnement UNIX alors vous pourrez compiler 
/// vous même votre programme puis utiliser l'exécutable comme bon vous semble.

/// Pour ceux qui travaillent directement dans Caséine, vous n'avez pas directement accès au terminal.
/// J'ai donc fait en sorte que Caséine fasse ceci : 
/// - il compile votre fichier rabinkarp.c et crée un exécutable rk
/// - il exécute le fichier script.sh
/// Vous pouvez donc écrire dans ce fichier script.sh les commandes que vous auriez voulu écrire 
/// dans le terminal. Par défaut, ce fichier contient la commande
///     ./RK "AAATCTCTAT" txt
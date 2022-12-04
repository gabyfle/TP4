/*  base_converter.S

    MI01 - TP Assembleur 1

    Convertis un nombre dans une base donnée par base
*/
.file "base_converter.S"
.intel_syntax noprefix

/* Section de données */
.data

nombre:         .quad   0x1c615658fa0b1 /* nombre à convertir */
base: 		    .byte   16              /* base dans laquelle on doit convertir */
chaine:         .fill   21, 1           /* chaîne qui stocke le résultat de la conversion */

.text

.global _start
_start:
    mov     rdi, chaine + 20       /* on met le pointeur sur la fin de la chaine dans rdi */
    mov     rsi, 16                     /* on met la base dans rsi */
    mov     rdx, nombre                 /* on met le nombre à convertir dans rdx */                                         

    mov rdi, chaine + 20           /* on mets dans rdi l'adresse de la fin de la chaîne */
    mov rsi, 16                         /* on mets dans rsi l'adresse de la base */
    mov r13, 0                          /* initialisation du compteur*/

    /*
        Converti le nombre "nombre" dans la base "base" et stocke le résultat dans la chaîne "chaine"
    */
    diviser:
        mov     rax, rdx                    /* on met le nombre à convertir dans rax */
        xor     rdx, rdx                    /* reset de rdx à 0 pour pouvoir l'utiliser après et afficher les bons caractères */
        div     byte ptr [rsi]              /* on divise rax par la base et on met le reste dans rdx */
        add     rdx, 48                     /* on ajoute 48 au reste pour avoir le code ASCII du chiffre */
        mov     byte ptr [rdi], dl          /* on met le chiffre dans la chaîne (en partant de la fin) */
        dec     rdi                         /* on décrémente le pointeur de la chaîne à chaque itération */
        inc     r13                         /* on incrémente le compteur (qui nous servira à connaître la taille de la chaîne) */
        cmp     rax, 0                      /* on compare le nombre à convertir avec 0 */
        jne     diviser                     /* si le nombre n'est pas égal à 0, on continue la division */
        mov     byte ptr [rdi], 0           /* on met un 0 à la fin de la chaîne */

    /*
        Affiche la chaîne "chaine" sur la sortie standard
    */
    display:
        mov     rdi, chaine                 /* on met l'adresse de la chaîne dans rdi */
        mov     rsi, r13                    /* on met le compteur dans rsi */
        mov     rdx, 1                      /* on met 1 dans rdx */
        mov     rax, 1                      /* on met 1 dans rax */
        syscall                             /* on affiche la chaîne */

    mov     rax, 60                         /* on met 60 dans rax (appel de la fonction unix "exit") */
    mov     rdi, 0                          /* on met 0 dans rdi (exit code 0 car pas d'erreurs */
    syscall                                 /* on appel exit avec le code de sortie "0" */

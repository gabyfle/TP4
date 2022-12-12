/*  base_converter.S

    MI01 - TP Assembleur 1

    Convertis un nombre dans une base donnée par base
*/
.file "base_converter.S"
.intel_syntax noprefix

/* Section de données */
.data

nombre:         .quad   0x1c615658fa0b1    /* nombre à convertir */
chiffres:       .ascii  "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ" /* contient tous les chiffres de la base 2 à la base 36 */
base:           .byte   30                 /* base dans laquelle on doit convertir */
chaine:         .fill   64, 1             /* chaîne qui stocke le résultat de la conversion */
end:            .byte   0x0a               /* caractère de fin de ligne */

.text

/* Bonjour tout le monde! */

.global _start
_start:
    lea     r10, chaine[rip]            /* on met le pointeur sur le début de chaîne */
    lea     r11, chiffres[rip]                  /* on stocke la chaine des chiffres dans r10 */                               

    mov     rsi, base                   /* on mets dans rsi la base */
    mov     r13, 1                      /* initialisation du compteur */
    mov     rax, nombre                 /* on met le nombre à convertir dans rax */

    /*
        Converti le nombre "nombre" dans la base "base" et stocke le résultat dans la chaîne "chaine"
    */
    diviser:
        xor     rdx, rdx                    /* reset de rdx à 0 pour pouvoir l'utiliser après et afficher les bons caractères */
        div     rsi                         /* on divise rax par la base et on met le reste dans rdx */
                                            /* donc rdx = nombre % base et rax = nombre / base */
        mov     r15, [r11 + rdx]
        mov     [r10 + r13], r15            /* on met le chiffre dans la chaîne (en partant de la fin) */ 
        inc     r13                         /* on incrémente le compteur (qui nous servira à connaître la taille de la chaîne) */
        cmp     rax, 0                      /* on compare le nombre à convertir avec 0 */
        jne     diviser                     /* si le nombre n'est pas égal à 0, on continue la division */

    /*
        Affiche la chaîne "chaine" sur la sortie standard, caractère par caractère

        Comme la chaîne a été remplie dans le sens inverse, il nous faut la retourner
        lors de l'écriture sur stdout
    */
    lea r10, chaine[rip]                    /* on met le pointeur sur le début de chaîne */
    add r10, r13                            /* on se met directement à la fin de la chaîne */
    sub r10, 1
    
    mov rdx, 1                              /* taille: 1 caractère, stdout et function write */
    mov rdi, rdx
    mov rax, rdi
    mov r14, 0                              /* on initialise notre joli petit compteur r14 */

    display:
        lea    rsi, [r10]                   /* on affiche le caractère en position */
        dec    r10                          /* on décrémente l'adresse de r10 de 1 octet pour passer au caractère précédent */     
        inc    r14                          /* on oublie pas d'incrémenter notre r14 */
        syscall                             /* on appel write avec le caractère à afficher */
        cmp    r14, r13                     /* si r14 est égal à r13, on est arrivé à la fin de la chaîne */
        jne    display
        

    mov     rax, 60                         /* on met 60 dans rax (appel de la fonction unix "exit") */
    mov     rdi, 0                          /* on met 0 dans rdi (exit code 0 car pas d'erreurs */
    syscall                                 /* on appel exit avec le code de sortie "0" */

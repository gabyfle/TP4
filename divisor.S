/*  divisor.S

    MI01 - TP Assembleur 1

    Affiche une chaîne de caractères terminée par un caractère NUL à l'écran. */
.file "divisor.S"
.intel_syntax noprefix

/* Section de données */
.data

nombre:         .quad   0x1c615658fa0b1
chaine:         .fill   21, 1 /* Remplacer ?? par la longueur n de la chaîne     */

/* Section de code */
.text

/*  Le symbole _start est le point d'entrée du programme, il repère l'adresse de
    la toute première instruction exécutée. Il est défini comme global sans quoi
    l'éditeur de liens ne pourra pas le trouver. */
.global _start
_start:
        lea r8, chaine[rip] /* on mets dans r8 l'adresse de chaine */
        mov r13, 0          /*Initialisation du compteur*/

		mov rax, nombre[rip] /* on charge le nombre à diviser dans rax */
		mov r14, 10 /* on mets le diviseur dans r14 */
		division:
			mov rdx, 0 /*Reset reste*/
			div r14 /* division de *rax par *r14 */

			mov [r8 + r13], dl /* on mets dans r8[r13] la valeur dl = bit de poid faible de rdx*/

			add r13, 1 /* on incrémente notre compteur */

			cmp rax, 0 /* on regarde si le reste est nul*/
			jne division /* si c'est pas le cas (cas) on continue */

		affichage:
			lea     rsi, [r8+r13]      /* Adresse du caractère                   */
	        mov     rax, 1              /* Appel no 1 (write)                     */
        	syscall                     /* Appel système                          */

        	sub r13, 1 /* on décrémente le registre r13 pour afficher le nombre dans le bon ordre */

        	cmp r13, 0 /* on check si on est arrivé à la fin du nombre ou pas */
        	jb affichage /* si on, on continue */

        mov     rax, 60             /* Appel 60 (exit)                        */
        mov     rdi, 0              /* Valeur de retour (ici 0)               */
        syscall


.file "hello2.S"
.intel_syntax noprefix

/* Section de données */
.data

msg: .asciz "Je n'suis pas un hééééérooos !"
end: .byte 0

/* Section de code */
.text

/*  Le symbole _start est le point d'entrée du programme, il repère l'adresse de
    la toute première instruction exécutée. Il est défini comme global sans quoi
    l'éditeur de liens ne pourra pas le trouver.                              */
.global _start
_start:
        lea     r12, msg[rip]
        mov     r13, 0

        mov     rdi, 1              /* fd = 1 (stdout)                        */
        mov     rdx, 1              /* 1 seul caractère                       */
suivant:
        lea     rsi, [r12+r13]      /* Adresse du caractère                   */
        mov     rax, 1              /* Appel no 1 (write)                     */
        syscall                     /* Appel système                          */

        add     r13, 1              /* Passer au caractère suivant            */
        lea 	r8,  end[rip]
        cmp     rsi, r8             /* Est-ce le caractère de fin de chaîne?  */
        jb      suivant             /* Si non, passer au suivant              */

        /* Terminer le processus.
           On utilise l'appel système exit(retval) pour mettre fin à un
           processus. Cet appel est le nunméro 60.                            */
        mov     rdi, 0              /* Valeur de retour (ici 0)               */
        mov     rax, 60             /* Appel  60 (exit)                       */
        syscall


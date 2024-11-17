.text
    .align 2
    .arm

/* RSI_timer1: */
    .global RSI_Timer0
RSI_Timer0:
        push    { r0-r2, lr }

        ldr     r0, =ra_objetivo
        ldr     r1, [r0]
        add     r1, #1              @; incrementa ra_objetivo
        ldr     r2, =86400
        cmp     r1, r2

        /* Hueco d */
        movhs   r1, #0              @; ajuste circular

        str     r1, [r0]

        pop     { r0-r2, pc }

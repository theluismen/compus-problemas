.text
    .align 2
    .arm

/* RSI_timer0: Timer 0 configurado a 1Hz. La RSi levanta un flag para el
    programa principal capture el tiempo */
    .global RSI_timer0
RSI_timer0:
        push    { r0, r1, pc }

        ldr     r0, =capturar
        mov     r1, #1
        strb    r1, [ r0 ]

        pop     { r0, r1, lr }
.end

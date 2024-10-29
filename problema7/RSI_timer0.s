    .global RSI_timer0
RSI_timer0:
        push    { , pc }

        ldr     r6, =REG_SERVO
        mov     r5, 0b0000
        strb    r5, [ r6 ]



        pop     { , lr }

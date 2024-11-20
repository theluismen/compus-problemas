.text
    .align 2
    .arm

@; rsi_botones():
    .global rsi_botones
rsi_botones:
        push    { r0-r1, lr }            // save modified regs

        /* Poner la variable global botpuls a uno */
        ldr     r0, =botpuls        // R0: @botpuls
        mov     r1, #1              // R1: 1
        strb    r1, [ r0 ]          // botpuls = 1

        /* Intercambiar la variable global patron para pasar al patrón contrario */
        ldr     r0, =patron         // R0: @patron
        ldrb    r1, [ r0 ]          // R1: patron
        cmp     r1, #0              // patron = (patron == 0)
        moveq   r1, #1              // ? 1
        movne   r1, #0              // : 0;
        strb    r1, [ r0 ]          // Guardo el valor de patron en mem

        /* Poner la variable global indx a cero para empezar la nueva secuencia desde el principio */
        ldr     r0, =indx           // R0: @index
        mov     r1, #0              // R1: 0
        strb    r1, [ r0 ]          // indx = 0

        /* Parar el timer 0 */
        ldr     r0, =TIMER0_CR      // R0: @TIMER0_CR
        ldrh    r1, [ r0 ]          // R1: TIMER0_CR
        bic     r1, #0x80           // bit 7 a 0; parar timer
        strh    r1, [ r0 ]

        /* Y poner la variable global timer0_on a cero */
        ldr     r0, =timer0_on      // R0: @timer0_on
        mov     r1, #0              // R1: 0
        strb    r1, [ r0 ]          // timer0_on = 1

        /* Desactivar las interrupciones de los botones */
        ldr     r0, =KEYS_CR        // R0: @KEYS_CR
        ldrh    r1, [ r0 ]          // R1:KEYS_CR
        bic     r1, 0x4000          // bit 14 a 0
        strh    r1, [ r0 ]

        /* Poner en marcha el timer 1 */
        ldr     r0, =TIMER1_CR      // R0: @TIMER1_CR
        ldrh    r1, [ r0 ]          // R1:TIMER1_CR
        orr     r1, #0x80           // bit 7 a 1
        strh    r1, [ r0 ]

        pop     { r0-r1, pc }
.end

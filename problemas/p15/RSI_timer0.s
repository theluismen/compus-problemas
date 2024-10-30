.text
    .align 2
    .arm

/* RSI_timer0: */
    .global RSI_timer0
RSI_timer0:
        push    { r0-r2, pc }

        ldr     r2, =strobe             // R2: variable global strobe
        ldrb    r2, [ r2 ]

        cmp     r2, #0                  // Ver si strobe == 0
        bne     .Lstrobe_1

        ldr     r0, =currentChar        // R0:  variable global currentChar
        ldrb    r0, [ r0 ]

        ldr     r1, =num_col            // R1:  variable global num_col
        ldrb    r1, [ r1 ]

        bl      obtener_puntos          // obtener_puntos ( caracter, num_columna )

        and     r0, 0b01111111          // Por si acaso el bit 7 lo dejo en 0
        ldr     r1, =REG_DISP           //
        strb    r0, [ r1 ]              // REG_DISP = puntos obtenidos antes

        mov     r0, #1
        strb    r0, [ r2 ]              // strobe = 1 para la proxima interrupcion

        b       .Lend_strobe_1
    .Lstrobe_1:

        ldr     r1, =REG_DISP
        ldrb    r0, [ r1 ]              // R0: REG_DISP

        orr     r0, #0b10000000         // Activar bit 7 de REG_DISP
        strb    r0, [ r1 ]

        mov     r0, #0
        strb    r0, [ r2 ]              // strobe = 0 para la proxima interrupcion
    .Lend_strobe_1:
        pop     { r0-r2, lr }
.end
/*
if ( strobe == 0 ) {
    n = currentChar;
    m = num_col;

    p = obtener_puntos( n, m );

    REG_DISP = p;
    strobe = 1;
} else {

}
*/

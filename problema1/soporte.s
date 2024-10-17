    .text
		.align 2
		.arm
    /* capturar_tiempo( char * tiempo )
        R0: direccion de vector de tiempo */
    .global capturar_tiempo
capturar_tiempo:
        push    { r0-r6, lr }

        bl      iniciar_RTC
        mov     r6, r0          // Copiar @ de tiempo
        mov     r0, #0x26
        bl      enviar_RTC
        mov     r1, #1          // i = 1
        mov     r5, #0          // Vector Offset = 0
    .Lwhile:
        cmp     r1, #7          // while ( i < 7 )
        bgt     .Lend_while
        cmp     r1, #4          // if ( i != 4 )
        beq     .Lend_if

        bl      recibir_RTC     // R0 = byte de tiempo en BCD
        mov     r3, r0
        and     r3, r3, #0x0F   // R3 contiene los 4 bits de unidades
        mov     r2, r0, lsr #4
        mov     r4, #10
        mul     r0, r2, r4
        add     r0, r3

        strb    r0, [ r6, r5 ]
        add     r5, #1
    .Lend_if:
        add     r1, #1
        b       .Lwhile
    .Lend_while:
        bl      parar_RTC
        
        pop     { r0-r6, pc }
.end

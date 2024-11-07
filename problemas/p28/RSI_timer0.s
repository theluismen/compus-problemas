.text
    .align 2
    .arm

/* RSI_timer0: */
    .global RSI_timer0
RSI_timer0:
        push    { , lr }

    @     ldr     r0, =REG_MARCAS         // R0: @REG_MARCAS
    @     ldrb    r0, [ r0 ]              // R0: REG_MARCAS
    @     and     r0, #0b10000            // R0: bit4(REG_MARCAS)
    @
    @     ldr     r2, =marca_actual       // R2: @marca_actual
    @     ldrb    r3, [ r2 ]              // R3: marca_actual
    @
    @     cmp     r0, #0
    @     beq     .LRSI_timer0_end_if     // if ( bit 4 != 0 )
    @
    @     mov     r0, r0, lsl #26         // R0: el bit 4 en el 31
    @     /* Desplazar el bit hasta el marca_actual bit */
    @     ldr     r1, =31                 // R1: 31
    @ .Lwhile:
    @     cmp     r1, r3                  // while ( R1 > marca_actual )
    @     bhi     .Lwhile_end
    @     mov     r0, lsr #1              // Desplazar 1 bit a la derecha
    @     sub     r1, #1
    @     b       .Lwhile
    @ .Lwhile_end:
    @     ldr     r1, =marcas             // R1: @marcas
    @     ldr     r4, =num_filas          // R4: @num_filas
    @     ldrb    r4, [ r4 ]              // R4: num_filas
    @     ldr     r5, [ r1, r4, lsl #2 ]  // R5: marcas[num_filas]
    @     orr     r5, r0                  // Añadir el bit actual de transmision
    @     str     r5, [ r1, r4, lsl #2 ]  // Devolver a memoria
    @ .LRSI_timer0_end_if:
    @     /* Ver si ya he hecho las 32 marcas */
    @     cmp     r3, #0
    @     bleq    desactivar_timer0
    @     /* Si no acabe aun, decrementar variable global marca_actual */
    @     subne   r3, #1
    @     strbne  r3, [ r2 ]

        // Version CLase
        ldr     r0, =marca_actual       // marca_actual [32..1]
        ldrb    r1, [ r0 ]
        sub     r1, #1

        ldr     r5, =num_filas
        ldrb    r6, [r5]

        ldr     r2, =REG_MARCAS
        ldrb    r3, [ r2 ]
        tst     r3, #0x10
        beq     .LRSIT0_NoMarca

        mov     r3, #1
        mov     r3, r3, lsl r1

        ldr     r4, =marcas
        ldr     r7, [r4, r6, lsl #2]
        orr     r7, r3
        str     r7, [r4, r6, lsl #2]

    .LRSIT0_NoMarca:
        cmp     r1, #0
        bne     .LRSIT0_end

        bl      desactivar_timer0

        mov     r1, #32
        strb    r1, [ r0 ]

        ldr     r5, =num_fila
        ldrb    r6, [r5]

        add     r6, #1
        strb    r6, [ r5 ]
    .LRSIT0_end:


        pop     { , pc }
.end

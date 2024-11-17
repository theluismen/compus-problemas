.text
    .align 2
    .arm

@;RSI del timer1: se activará a la frecuencia requerida para generar el
@;  pulso de variación del motor M1;
@;  si se encuentra en búsqueda, la velocidad será 15 pulsos/segundo
@;  y el tipo de giro dependerá de la distancia entre ra_actual y
@;  ra_objetivo (grueso si >=120, fino si <120);
@;  si ra_actual = ra_objetivo, pasará a seguimiento, con giro fino
@;  y velocidad de 1 pulso/segundo;
@;  también ajusta el sentido de giro según el resultado de la
@;  comparación entre ra_actual y ra_objetivo, y se actualiza
@;  ra_actual según el tipo de giro (grueso/fino) y el sentido de
@;  giro (incremento/decremento).
RSI_Timer1:
        push    { r0-r9, lr }

        /* Hueco e */
        ldr     r2, =REG_TEL
        ldrb    r3, [ r2 ]
        tst     r3, #0x80
        bicne   r3, #0x80
        bne     .LTim1_fin
        
        orr     r3, #0x80

        ldr     r4, =seek_ra
        ldrb    r5, [r4]            @; R5 = valor de búsqueda
        ldr     r6, =ra_actual
        ldr     r7, [r6]            @; R7 = valor de ra_actual
        ldr     r8, =ra_objetivo
        ldr     r8, [r8]            @; R8 = valor de ra_objetivo
        mov     r9, #1              @; por defecto, incremento fino

        mov     r0, r8
        mov     r1, r7

        /* Hueco f */               @; R0 = circ(ra_objetivo-ra_actual)
        bl      circ_sub            @; R1 = abs(R0)

        cmp     r5, #1              @; comprobar modo búsqueda
        bne     .LTim1_cont

        cmp     r1, #120
        /* Hueco g */               @; si abs(R0) >= 120, giro grueso
        andhs   r3, #0xDF
//      bichs   r3, #0x20           tambien psto es posible
        movhs   r9, #120            @; incremento grueso
        orrlo   r3, #0x20           @; si no, giro fino

    .LTim1_cont:
        cmp     r0, #0              @; detectar signo de comparación

        /* Hueco h*/
        addgt   r7, r9              @; avanzar ra_actual
        sublt   r7, r9              @; retroceder ra_actual
        bicgt   r3, #0x40           @; si obj > act, incrementar
        orrlt   r3, #0x40           @; si obj < act, decrementar
        strne   r7, [r6]            @; actualizar variable ra_actual

        bne     .LTim1_fin          @; si obj != act, saltar al final

        cmp     r5, #0              @; si modo seguimiento,
        beq     .LTim1_fin          @; saltar al final

        ldr     r0, =divfreq_vmin   @; si ra_objetivo == ra_actual
        ldrhs   r1, [r0]
        mov     r0, #1

        /* Hueco i */                  @; fijar divfreq_vmin
        bl      activar_timer

        mov     r5, #0
        strb    r5, [r4]               @; fijar seek_ra = 0
        ldr     r4, =track
        mov     r5, #1
        strb    r5, [r4]               @; fijar track = 1

    .LTim1_fin:
        strb    r3, [r2]               @; actualizar REG_TEL

        pop     { r0-r9, pc }















.end

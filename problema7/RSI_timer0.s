// RSI del timer 0 actualizar el pulso del servomotor en funcion del valor de
//  y_mic. Tambien la rutina programa temporalmente la proxima ejecucion de la
//  misma con fijar_divfrectim0().
    .global RSI_timer0
RSI_timer0:
        push    { r0-r2, pc }

        ldr     r0, =pulse_state
        ldrb    r1, [ r0 ]          // R1: pulse_state
        cmp     r1, #1              // if ( pulse_state == 1 )
        bne     .Lpulso_0

        mov     r1, #0
        strb    r1, [ r0 ]          // pulse_state = 0;

        ldr     r0, =REG_SERVO
        ldrb    r1, [ r0 ]          // R1: REG_SERVO
        and     r1, #0b0111         // desactivar bit 3 del REG_SERVO
        strb    r1, [ r0 ]          // Guardo REG_SERVO en mem

        ldr     r0, =20000
        ldr     r1, =y_mic
        ldrh    r2, [ r1 ]
        sub     r0, r2              // R0: 20000 - y_mic

        bl      fijar_divfrectim0
        b       .Lend_pulso_0
    .Lpulso_0:
        mov     r1, #1
        strb    r1, [ r0 ]          // pulse_state = 1;

        ldr     r0, =REG_SERVO
        ldrb    r1, [ r0 ]          // R1: REG_SERVO
        orr     r1, #0b1000         // activar bit 3 del REG_SERVO
        strb    r1, [ r0 ]          // Guardo REG_SERVO en mem

        ldr     r1, =y_mic
        ldrh    r0, [ r1 ]          // R0: y_mic

        bl      fijar_divfrectim0
    .Lend_pulso_0:
        pop     { r0-r2, lr }

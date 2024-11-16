.text
    .align 2
    .arm
// RSI del timer 0: Actualizar el pulse_state en funcion del valor
// de y_mic. Tambien la rutina programa temporalmente la proxima
//  ejecucion de la misma con fijar_divfrectim0().
    .global RSI_timer0
RSI_timer0:
        push    { r0-r4, lr }

        ldr     r3, =y_mic              // R3: @y_mic
        ldr     r4, =pulse_state        // R4: @pulse_state

        ldrb    r1, [ r4 ]              // R1: pulse_state

        cmp     r1, #1
        bne     .LRSIt0_pulso_0         // if ( pulse_state == 1 )

        mov     r1, #0                  // R1: pulse_state = 0
        ldr     r0, =20000              // R0: 20.000
        ldrb    r2, [ r3 ]              // R2: y_mic
        sub     r0, r2                  // R0: 20.000 - y_mic
        bl      fijar_divfrectim0       // fijar_divfrectim0( 20.000 - y_mic )
        b       .LRSIt0_end_pulso_0
    .LRSIt0_pulso_0:                    // si pulse_state == 0
        mov     r1, #1                  // R1: pulse_state = 1
        ldr     r0, [ r3 ]              // R0: y_mic
        bl      fijar_divfrectim0       // fijar_divfrectim0( y_mic )
    .LRSIt0_end_pulso_0:
        strb    r1, [ r4 ]              // pulse_state = R1

        ldr     r0, =REG_DISP
        ldrb    r1, [ r0 ]              // Alternar bit 3 de REG_DISP
        eor     r1, #0b1000
        strb    r1, [ r0 ]

        pop     { r0-r4, pc }
.end
/*  Procedimiento en C
    if ( pulse_state == 1 ) {
        pulse_state = 0;
        fijar_divfrectim0( 20000 - y_mic );
    } else {
        pulse_state = 1;
        fijar_divfrectim0( y_mic );
    }
    REG_SERVO = REG_SERVO ^ 0b1000; // Xor al bit 3 para alternar
*/

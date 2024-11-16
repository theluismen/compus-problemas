.text
    .align 2
    .arm
// fijar_divfreqtim0( unsigned short micros ): Activa el timer 0 cada un
//  determinado periodo expresado en microsegundos: micros.
//  El Divisor de Frecuencia se calcula como:
//      divFreq = -( 523656 * micros / 1000000 )
//  el producto 523656 * micros no se puede guardar en 32 bits asi que la
//  la formula del divisor de frecuencia pasa a ser:
//      divFreq = -( 52365 * micros / 100000 )
//  R0: ( unsigned short ) micros
    .global fijar_divfrectim0
fijar_divfrectim0:
        push    { r0-r2, lr }

        ldr     r1, =52365          // R1: 52365
        mul     r2, r0, r1          // R2: micros * 52365
        mov     r0, r2              // R0: micros * 52365
        ldr     r1, =100000         // R1: 100000
        swi     9                   // R0: (micros * 52365) / 100000
        rsb     r0, r0, #0          // R0: divFreq = -divFreq

        ldr     r1, =TIMER0_DATA    // R1: @TIMER0_DATA
        strh    r0, [ r1 ]          // TIMER0_DATA = r1

        pop     { r0-r2, pc }
.end

.text
    .align 2
    .arm

/* RSI_dispo: Esta RSI es la rutina de servicio a la interrupción asociada
    al dispositivo de lectura de hojas. Incrementa el numero de filas leidas,
    inicializa la variable global marca_actual a 31 para que la use el timer0 y
    activa el timer 0 a una frecuencia de 5000Hz para que se active cada 0.2ms
    y sea capaz de leer los 32 bits ( 32 marcas ) en el espacio de 6.4ms*/
    .global RSI_timer0
RSI_dispo:
        push    { r0-r3, pc }

        ldr     r0, =marcas             // R0: @marcas
        ldr     r1, =num_filas          // R1: @num_filas

        ldrb    r2, [ r1 ]              // R2: num_filas
        mov     r3, #0                  // R3: 0
        str     r3, [ r0, r2, lsl #2 ]  // marcas[num_filas] = 0

        add     r2, #1                  // num_filas ++
        strb    r2, [ r1 ]              // Guardar num_filas en mem

        ldr     r0, =marca_actual       // R0: @marca_actual
        mov     r1, #31                 // R1: 31
        ldrb    r1, [ r0 ]              // marca_actual = 31

        ldr     r0, =5000               // R0: Constante 5000
        bl      inicializar_timer0      // inicializar_timer0( 5000 )

        pop     { r0-r3, lr}
.end

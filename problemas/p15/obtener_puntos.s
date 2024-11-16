/* CUIDADO: Para la resolucion del ejercicio se asume que la estructura en
memoria de base_ASCII es la siguiente:
byte 0 -5 : caracter espacio ( aunque podria ser un byte solo )
byte 6 -11: caracter ...
byte 12-17: caracter ...
...
*/

.text
    .align 2
    .arm

// char obtener_puntos ( char caracter, char num_columna )
//  R0: caracter
//  R1: num_columna
    .global obtener_puntos
obtener_puntos:
        push    { r1-r4, lr }

        sub     r0, #32             // caracter  -= 32;
        ldr     r2, =base_ASCII     // R2: @base_ASCII
        mov     r3, #6              // R3: 6
        mla     r4, r0, r3, r2      // R4: caracter * 6 + base_ASCII ( base letra )

        mov     r3, #5
        sub     r3, r1              // Calcular offset columna

        ldrb    r0, [ r4, r3 ]

        pop     { r1-r4, pc }

/*
    caracter  -= 32;
    base_letra = base_ASCII + caracter * 6; // Ir a la base de la letra
    offset     = 5;
    offset    -= num_columna;
    puntos     = base_letra + offset
*/

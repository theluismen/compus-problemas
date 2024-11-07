#define MAX_FILAS 64

/* Variables Globales */
unsigned char   marca_actual;
unsigned char   num_filas = 0;
unsigned short  num_hojas = 0;
unsigned int    marcas[ MAX_FILAS ];


int main () {
    /* Variables Locales */
    unsigned char llegint_full = 0;

    inicializaciones();

    /* Bucle Principal del Programa */
    while ( 1 ) {
        tareas_independientes();

        // if ( ( REG_MARCAS & 0x01 ) && ! llegint_full ) { // Hay una hoja en el dispositivo
        //     REG_MARCAS |= 0x80;     // Activar bit 7 para que el motor arranque
        //
        //     llegint_full = 1;       // Leyendo hoja a uno para que en la proxima ej. no entre al if
        //
        // }
        if ( ( REG_MARCAS & 0x01 ) != llegint_full ) { // Hay una hoja en el dispositivo
            REG_MARCAS ^= 0x80;     // Activar bit 7 para que el motor arranque

            if ( llegint_full ) {
                for ( i = 0; i < MAX_FILAS; i++ ) {
                    marcas[i] = 0;
                }
                swiWaitForVBlank();
                if ( enviar_hoja( marcas, num_fila ) ) {
                    printf("%d: OK", num_hojas);
                    num_hojas ++;
                } else {
                    printf("%d: ERROR", num_hojas);
                }
                num_fila = 0;
            }

            llegint_full = 1 - llegint_full;       // Leyendo hoja a uno para que en la proxima ej. no entre al if
        }
    }

    return 0;
}

#include <nds.h>

unsigned char capturar = 0;

int main(void) {
    char tiempo[6];
    char alarma[6] = { 24, 10, 17, 00, 00, 00 };

    inicializaciones();
    inicializar_timer0();

    /* Bucle principal */
    while ( 1 ) {
        tareas_independientes();

        if ( capturar ) {
            capturar = 0;
            capturar_tiempo( tiempo );
            detectar_alarma( tiempo, alarma );
            swiWaitForVBlank();  // Esperar al VBlank (sincronización vertical)
            mostrar_tiempo( tiempo );
        }
    }

    return 0;  // Nunca se llega aquí
}

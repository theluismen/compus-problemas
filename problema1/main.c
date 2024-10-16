#include <nds.h>

char capturar = 0;

int main(void) {
    // Inicializar el sistema de video de la Nintendo DS
    videoSetMode(MODE_FB0);  // Configura la pantalla en modo framebuffer 0
    vramSetBankA(VRAM_A_MAIN_BG);  // Asigna VRAM a fondo gráfico principal

    char * tiempo = {};
    char * alarma = {};

    inicializaciones();
    inicializar_timer0();

    /* Bucle principal */
    while ( 1 ) {
        tareas_independientes();

        if ( capturar ) {
            capturar = 0;
            capturar_tiempo( tiempo );
        }

        mostrar_tiempo( tiempo );
        detectar_alarma( tiempo, alarma );
        
        swiWaitForVBlank();  // Esperar al VBlank (sincronización vertical)
    }

    return 0;  // Nunca se llega aquí
}

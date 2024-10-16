#include <nds.h>

int main(void) {
    // Inicializar el sistema de video de la Nintendo DS
    videoSetMode(MODE_FB0);  // Configura la pantalla en modo framebuffer 0
    vramSetBankA(VRAM_A_MAIN_BG);  // Asigna VRAM a fondo gráfico principal

    // Bucle principal
    while (1) {
        swiWaitForVBlank();  // Esperar al VBlank (sincronización vertical)
    }

    return 0;  // Nunca se llega aquí
}

unsigned char x; // valor actual del ángulo
unsigned char pulse_state; // estado actual del pulso
unsigned short y_mic; // número de microsegundos a 1
unsigned int keys;

extern void fijar_divfrectim0 ( unsigned short micros );

int main () {

    inicializaciones();

    x = 0;
    keys = 0;
    pulse_state = 1;

    fijar_divfrectim0( y_mic );

    /* Bucle Principal del Programa */
    while ( 1 ) {

        scanKeys();
        keys = keysDown();

        if ( keys & KEYS_LEFT && x > 0 ) {
            x -= 1;
        } else if ( keys & KEYS_RIGHT && x < 180 ) {
            x += 1;
        } else if ( keys & KEYS_L && x >= 10 ) {
            x -= 10;
        } else if ( keys & KEYS_R && x <= 170 ) {
            x += 10;
        }

        y_mic = 1000 + x * 1000 / 180; // y_mic(microsegundos)

        tareas_independientes();

        swiWaitForVBlank();

    }
    return 0;
}

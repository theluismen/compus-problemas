/* Variables Globales */
unsigned char x;            // valor actual del ángulo
unsigned char pulse_state;  // estado actual del pulso
unsigned short y_mic;       // número de microsegundos a 1

extern void fijar_divfrectim0 ( unsigned short micros );

int main () {
    /* Variables Locales */
    unsigned int  keys;
    unsigned char x_old;    // Valor antiguo de x, para ver si se modifica

    inicializaciones();

    /* Inicializar Valores y primera interrupcion */
    x = 0;
    x_old = x;
    pulse_state = 1;
    y_mic = 1000;
    *(REG_SERVO) = *(REG_SERVO) | 0b1000;
    fijar_divfrectim0( y_mic );

    /* Bucle Principal del Programa */
    while ( 1 ) {
        tareas_independientes();        // < 100ms de ejecucion
        swiWaitForVBlank();
        /* Escanear Teclas */
        scanKeys();
        keys = keysDown();
        /* Modificar el angulo del servomotor */
        if ( keys & KEYS_LEFT && x > 0 ) {
            x --;
            x_new = 1;
        } else if ( keys & KEYS_RIGHT && x < 180 ) {
            x ++;
            x_new = 1;
        } else if ( keys & KEYS_L && x >= 10 ) {
            x -= 10;
            x_new = 1;
        } else if ( keys & KEYS_R && x <= 170 ) {
            x += 10;
            x_new = 1;
        }
        /* Controlar la ejecucion de printf y el cálculo de y_mic,
         si no se cambia la x no lo muestro otra vez */
        if ( x_old != x ) {
            swiWaitForVBlank();
            printf("angle = %d\n", x);
            x_new = 0;
            y_mic = 1000 + ( x * 1000 ) / 180; // y_mic(microsegundos), importante el ()
            x_old = x;
        }
    }

    return 0;
}

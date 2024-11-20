/* Definiciones */
#define NADA 0
#define ROJO 1
#define AMAR 2
#define VERD 4

/* Variables Globales */
char luces[2][4] = {
    {ROJO, VERD, AMAR, -1},     // ROJO >> VERDE >> AMARILLO
    {NADA, AMAR, -1, -1} };     // APAGADO >> AMARILLO

short tiempos[2][4] = {
    {30, 20, 15, -1},           // 3,0s > 2,0s > 1,5s
    {5 , 5 , -1, -1} };         // 0,5s > 0,5s

unsigned char patron    = 0; // Indica el patrón actual
unsigned char indx      = 0; // Índice del elemento actual del patrón actual
unsigned char botpul    = 0; // Indica si se ha pulsado el botón A
unsigned char timer0_on = 0; // Indica si el timer 0 está en marcha

int main () {
    /* Inicializaciones */
    INT_instalarRSIPrincipal( rsi_principal, , IRQ_VBLANK | IRQ_TIMER0 | IRQ_TIMER1 | IRQ_KEYS );
    initGraficosA();
    initGraficosB();

    KEYS_CR = KEY_A | ( 1<<14 );    // Habilitar interrupcion SOLO del boton A

    /* Bucle Principal del Programa */
    while ( 1 ) {

    }

    return 0;
}

























//

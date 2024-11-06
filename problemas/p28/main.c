#define MAX_FILAS 64

/* Variables Globales */
unsigned char   marca_actual;
unsigned char   num_filas = 0;
unsigned short  num_hojas = 0;
unsigned int    marcas[ MAX_FILAS ];
int main () {
    /* Variables Locales */


    inicializaciones();

    /* Bucle Principal del Programa */
    while ( 1 ) {
        tareas_independientes();

        // swiWaitForVBlank();
        // printf();
    }
    return 0;
}

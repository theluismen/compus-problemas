unsigned char currentChar;
unsigned char num_col;
unsigned char strobe;

int main () {

    char string[] = {'E','s','t','a',' ','e','s',' ','u','n','a',' ','f','r','a','s','e','\0'};
    byte index = 0;

    currentChar = string[ index ];
    num_col     = 0;
    strobe      = 0;

    inicializaciones();
    printf("%s\n", string);

    /* Bucle Principal del Programa */
    while ( 1 ) {
        tareas_independientes();

        if ( strobe == 1 ) {
            num_col = ( num_col < 5 ) ? num_col++ : 0 ;
            if ( num_col == 0 ) {
                index = ( index < strlen(string)-1 ) ? index++ : ;
                currentChar = string[index];
            }
        }

        swiWaitForVBlank();
    }

    return 0;
}

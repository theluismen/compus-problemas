#define MAXDIGITS 14

unsigned char NTel[MAXDIGITS];  // vector para almacenar número tel.
unsigned char ind_digit = 0;    // índice del dígito actual
unsigned char new_digit = 0;    // si vale 1 es que hay nuevos dígitos
unsigned char num_pulses = 0;   // número de pulsos actual

void main(void)
{
    unsigned char ind_digit_ant = 0;    // índice del dígito anterior
    inicializaciones();
    /* Hueco a */
    // 79 = 2^15 - (65457-2^15) = 2^16 - 65457
    TIMER0_DATA = 79;                    // fijar divisor de frecuencia máximo
    do
    {
        tareas_independientes();
        if ( new_digit ) {                       // si se han marcado nuevos dígitos
            swiWaitForVBlank();
            /* Hueco b */
            if ( ind_digit == 0 )                // si se trata del primer dígito
            {
                printf("Numero tel.: ");
            }
            while ( ind_digit_ant < ind_digit ) { // visualizar dígitos pendientes
                /* Hueco c */
                printf("%d", NTel[ind_digit_ant]);
                ind_digit_ant++;
            }
            if ( num_pulses == 0 ) {             // si se ha terminado la marcación de dígitos
                printf("\n");
                realizar_llamada(NTel, ind_digit);
                ind_digit_ant = 0;
                ind_digit = 0;                  // reiniciar proceso de marcación
            }
            new_digit = 0;
        }
    } while (1);
}

#define FREQ_ENT 32728   // frecuencia de entrada mínima (Hz)

short divfreq_vmax = -( FREQ_ENT / 30 );   // divisor freq. velocidad máx.
short divfreq_vmin = -( FREQ_ENT / 2  );   // divisor freq. velocidad mín.

short dec_actual = 0, dec_objetivo = 0; // [-9000..9000] centígrados
int   ra_actual  = 0, ra_objetivo  = 0;  // [0..86399] segundos
unsigned char seek_ra = 0, seek_dec = 0; // búsqueda de objetivo
unsigned char track = 0;    // seguimiento de objetivo

int main()
{
    inicializaciones();
    activar_timer(0, FREQ_ENT);    // timer 0 siempre activo
    do
    {
        tareas_independientes();
        if ( gestionar_interfaz( &ra_objetivo, &dec_objetivo ) )
        {       // activar giros de búsqueda
            activar_timer(1, divfreq_vmax);
            seek_ra = 1;
            track = 0;
            activar_timer(2, divfreq_vmax);
            seek_dec = 1;
        }
        swiWaitForVBlank();
        actualizar_pantallas();
    } while (1);
    return(0);
}

.text
    .align 2
    .arm
    
@; capture_digit(n_puls): converts the past number of pulses into a
@; digit value that will be stored in the global vector NTel[], at the
@; current position ind_digit (global variable). This ind_digit variable
@; will be increased and the global variable new_digit will be set to
@; 1; when number of pulses is ten, the stored digit value is 0.
@; Register R0 (parameter n_puls) always returns zero.
capture_digit:
        push    { r1-r3, lr }           @; save modified regs

        cmp     r0, #10
        movhs   r0, #0                  @; convert counts equal (or above) ten

        /* Hueco f */
        ldr     r1, =NTel               @; R1 is base address of digits vector
        ldr     r2, =ind_digit
        ldrb    r3, [r2]
        strb    r0, [r1, r3]            @; NTel[ind_digit] = digit value

        add     r3, #1
        strb    r3, [r2]                @; increase ind_digit

        ldr     r2, =REG_TEL
        mov     r3, #0
        strh    r3, [r2]                @; clear I/O register (turn off all LEDs)

        ldr     r1, =new_digit
        /* Hueco g */
        mov     r2, #1
        strb    r2, [r1]                @; signal for the main loop

        mov     r0, #0                  @; return reset value of number of pulses

        pop     { r1-r3, pc }

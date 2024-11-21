.text
    .align 2
    .arm

@; rsi_timer0(): activates when 2 seconds have passed since the last
@; pulse; in this case, the last digit of the telephone number must be
@; recorded, the counter of pulses must be reset and the timer must be
@; stopped.
    .global rsi_timer0
rsi_timer0:
        push    { r0-r1, lr }           @; save modified regs

        ldr     r1, =num_pulses
        ldrb    r0, [r1]
        bl      capture_digit

        @;mov     r0, #0                @; no need to set R0 to 0, because
                                        @; capture_digit() always returns R0 = 0
        /* Hueco h */
        strb    r0, [ r1 ]
        ldr     r1, =TIMER0_CR
        /* Hueco i */
        strh    r0, [ r1 ]              @; stop the timer

        pop     { r0-r1, pc }

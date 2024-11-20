TIMER0_DATA = 0x04000100
TIMER0_CR   = 0x04000102

.text
    .align 2
    .arm

@; rsi_sensor():activates at every rising pulse of the vintage telephone
@; dialer; to check whether the new pulse belongs to a sequence of
@; pulses of the current digit, or it is the start of a new digit,
@; the routine compares the current counter of the timer 0 and
@; decides if the pulse is the start of a new digit when
@; the counter is above 16364, which corresponds to half a second.
@; The processing of the new digit is carried out by an external
@; routine called capture_digit().
@; Whether the capture_digit() routine is called or not, the
@; current number of pulses is increased and the timer counting is
@; reset.
    .global rsi_sensor
rsi_sensor:
        push    { r0-r4, lr }           @; save modified regs

        ldr     r3, =TIMER0_DATA
        ldrh    r1, [r3]                @; R1 is the current counter value

        ldr     r2, =num_pulses
        ldrb    r0, [r2]                @; R0 is the current number of pulses

        ldr     r4, =16364
        cmp     r1, r4                  @; check if counter is above 50 cs
        /* Hueco d */
        blhi    capture_digit

        add     r0, #1                  @; update number of pulses
        strb    r0, [r2]                @; if capture_digit() is called, the
                                        @; current number of pulses will be 1
                                        @; (0+1) accounting the current pulse
                                        @; as the start of the new digit

        ldr     r2, =REG_TEL
        /* Hueco e */
        ldrh    r1, [r2]                @; read previous activations of LEDs
        mov     r4, #1                  @; create mask for the LED corresponding
        mov     r4, r4, lsl r0          @; to the current number of pulses
        orr     r1, r4                  @; activate the LED bit
        strh    r1, [r2]                  @; update I/O register

        add     r3, #2                  @; R3 points to TIMER0_CR
        mov     r0, #0
        strh    r0, [r3]
        mov     r0, #0xC3               @; start, enable IRQs, select input '11'
        strh    r0, [r3]                @; reset counter

        pop     { r0-r4, pc }

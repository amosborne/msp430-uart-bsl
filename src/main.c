#include <msp430g2553.h>
#include <stdbool.h>
#include "bsl.h"

int main( void ) {
    WDTCTL = WDTPW | WDTHOLD; // Stop watchdog timer

    P1DIR = BIT0;
    P2DIR = BIT3 | BIT4;

    if ( P1IN & BIT7 ) {
        P2OUT = BIT4;
        bsl_entry();
    } else {
        P2OUT = BIT3;
    }

    while ( true ) {}
}

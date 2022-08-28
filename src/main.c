#include <msp430g2553.h>
#include <stdbool.h>
#include "bsl.h"

int main( void ) {
    WDTCTL = WDTPW | WDTHOLD; // Stop watchdog timer

    P1DIR = BIT0;
    P2DIR = BIT3 | BIT4;
    P2OUT = BIT4; // Turn on the red LED

    while ( true ) {
        if ( !( P1IN & BIT7 ) ) { // Check if boot button is pressed
            P2OUT = BIT3; // Turn on the green LED
            bsl_entry();
        }
    }
}

#include <msp430g2553.h>

unsigned int __attribute__ ( ( section( ".infoD" ) ) ) BSL_ADDRESS = ID;

int main( void ) {
    WDTCTL = WDTPW | WDTHOLD;       // Stop watchdog timer
    P1DIR |= BSL_ADDRESS;           // Set P1.0 to output direction

    for ( ;; ) {
        volatile unsigned int i;    // volatile to prevent optimization

        P1OUT ^= BSL_ADDRESS;       // Toggle P1.0 using exclusive-OR

        i = 10000;                  // SW Delay

        do i--;

        while ( i != 0 );
    }

    return 0;
}

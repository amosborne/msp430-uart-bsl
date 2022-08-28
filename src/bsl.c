#include <msp430g2553.h>
#include "bsl.h"

unsigned int BSL_ADDRESS = ID;

void bsl_entry( void ) {
    while ( BSL_ADDRESS ) {}
};

extern unsigned int __attribute__ ( ( section( ".infoD" ) ) ) BSL_ADDRESS;

void __attribute__ ( ( section( ".infoC" ), naked ) ) bsl_entry( void );

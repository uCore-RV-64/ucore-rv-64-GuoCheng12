#include "console.h"
#include "sbi.h"

void consputc(int c)
{
	console_putchar(c);
}

void console_init()
{
	// DO NOTHING
<<<<<<< HEAD
}

int consgetc()
{
	return console_getchar();
=======
>>>>>>> ch4
}
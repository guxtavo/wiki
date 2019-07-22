#include <stdio.h>

/* copy input to output; 2nd version */

/* To "type" EOF -> Ctrl+d */

main()
{
    int c;
    while ((c = getchar()) != EOF)
        putchar(c);
}

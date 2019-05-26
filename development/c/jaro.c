#define _XOPEN_SOURCE 500
#include <stdio.h>
#include <unistd.h>

int main()
{
    int i = 0;
    int j = 0;
    int max = 30;
    int delta = 1;

    while (1)
    {
        fprintf(stderr,"\r");
        for (j = 0; j < i; ++j)
            fprintf(stderr," ");
        fprintf(stderr,"*");
        for (j = i + 1; j <= max; ++j)
            fprintf(stderr," ");

        usleep((useconds_t)30000);
        i += delta;
        if (i >= max || i <= 0)
            delta *= -1;
    }
}

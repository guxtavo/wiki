#include <stdio.h>
#include <sys/time.h>

int
main()
{
        struct timespec ts;
        long now;
 
        /* man 3 clock_gettime */
        clock_gettime(CLOCK_REALTIME, &ts);
        now = ts.tv_sec * 1000000000LU + ts.tv_nsec;
 
        /* man 3 printf */
        printf("%ld\n", now);
        return 0;
}

#include <stdio.h>
#include <sys/time.h>

/*
	How to use clock_gettime(2)

	It can be called with CLOCK_REALTIME, which is the a clock
	that increments 'as a wall clock should'. 
 
*/

/* emulates +%s%N from linux */

int
main()
{
		/* where to find this? */
        struct timespec ts;
        long now;
 
        /* man 3 clock_gettime */
        clock_gettime(CLOCK_REALTIME, &ts);
        now = ts.tv_sec * 1000000000LU + ts.tv_nsec;
 
        /* man 3 printf */
        printf("%ld\n", now);
        return 0;
k
}

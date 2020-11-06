#include <stdio.h>
#include <stdlib.h>

// Functions that return an array
//
// Just as a pointer to an array can be passed into a function, a
// pointer to an array can be returned, as in the following program:

// how many results to show
#define ITER 2102009

// declare get_evens as function returning pointer to int
int * get_evens();

// main function
int main() {
    int *a;
    int k;

    a = get_evens(ITER);
    for (k = 0; k < ITER; k++)
        printf("%d\n", a[k]);    // a[k] is the same as *(a + k)

    free(a);
    return 0;
}

// declare get_evens as function returning pointer to int
int * get_evens(int iter) {
    // An array can be of two types:
    // dynamic - number of elements known at runtime (given as input or a
    //           parameter of the function)
    int* nums = (int*)malloc(sizeof(int) * iter);
    // static - number of elements known at compile time
    //static int nums[2009];
    int k;
    int even = 0;

    for (k = 0; k < iter; k++) {
        nums[k] = even += 2;
    }

    return (nums);
}
/*
<dzejrou> the hint would be, you don't need the variable called even at all
*/

#include<stdio.h>

int main()
{
    // a = 5(00000101)
    unsigned char a = 5;

    // The result is
    printf("16 & 1<<a = %d\n", 16 & 1<<a);
    return 0;
}

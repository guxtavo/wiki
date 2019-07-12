#include <stdio.h>
#include <string.h>
// print a string in reverse order

int main()
{
    printf("Insert a word to be reversed: ");

    char myword[64];
    scanf("%s", myword);

    for (size_t i = strlen(myword); i > 0; i--)
        printf(" |%c| ", myword[i - 1]);

    printf("\n");
    return 0;
}

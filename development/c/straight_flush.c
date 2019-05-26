#include <stdio.h>
#include <string.h>

//  https://ideone.com/hyQIiB

int main()
{
    char* bug = "111134567";
    size_t start;
    int i;

    //  The  strlen() function calculates the length of the string pointed to
    //  by s, excluding the termi nating null byte ('\0').

    start = strlen(bug) - 5;

    for (i = start; i < strlen(bug) ; i++)
        printf("%c", bug[i]);

    printf("\n");
    return 0;
}

#include <stdio.h>

#define ALLOCSIZE 10000 /* size of available space */

static char allocbuf[ALLOCSIZE]; /* storage for alloc  */
static char *allocp = allocbuf;  /* next free position */

char *alloc(int n)  /* return pointer to n characteres */
{
  if (allocbuf + ALLOCSIZE - allocp >= n) { /* it fits */
    allocp += n;
    return allocp - n; /* old p */
  } else       /* not enough room */
    return 0;
}

void free (char *p)   /* free storage pointed to by p */
{
  if (p >= allocbuf && p < allocbuf + ALLOCSIZE)
    allocp = p;
}

int main()
{
  printf("hello world!\n");
}

#include <stdio.h>
#include <stdlib.h>

int main()
{
    void* heap = malloc(10);
    free(heap);
    free(heap);

    printf("hello mother fucker");

    return 0;
}
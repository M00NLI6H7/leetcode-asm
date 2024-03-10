#include <stdlib.h>
#include <stdio.h>

extern int maxArea(int* heights, int heightsSize);

int main(int argc, char** argv)
{
    if (argc < 2)
    {
        fprintf(stderr, "usage: ./11-Container-With-Most-Water heights...\n");
        return 0;
    }

    const int heightsSize = argc - 1;
    int* heights = malloc(sizeof(int) * heightsSize);

    for(size_t i = 1; i < argc; i++)
    {
        heights[i] = atoi(argv[i]);
    }

    printf("%d\n", maxArea(heights, heightsSize));

    free(heights);
    heights = NULL;

    return 0;
}

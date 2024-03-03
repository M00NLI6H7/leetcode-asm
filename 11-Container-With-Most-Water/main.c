#include <stdlib.h>
#include <stdio.h>


extern int maxArea(int* heights, int heightsSize);

int main()
{
    int heightsSize = 9;
    int* heights = malloc(sizeof(int)*heightsSize);

    // [1,8,6,2,5,4,8,3,7]
    heights[0] = 1;
    heights[1] = 8;
    heights[2] = 6;
    heights[3] = 2;
    heights[4] = 5;
    heights[5] = 4;
    heights[6] = 8;
    heights[7] = 3;
    heights[8] = 7;

    int max = maxArea(heights, heightsSize);
    printf("maxArea = %d", max);
    return max;
}

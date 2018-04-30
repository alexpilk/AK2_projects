#include <stdio.h>
float start(float A, float B, float N);

int main()
{
    float A = 1;
    float B = 90;
    float N = 999999;
    float result = start(A, B, N);
    printf("Integral is: %f\n", result);
    return 0;
}



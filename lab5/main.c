#include <stdio.h>
float calculate_integral(float A, float B, float N);

int main()
{
    float A = 1;
    float B = 90;
    float N = 999999;
    float result = calculate_integral(A, B, N);
    printf("Integral is: %f\n", result);
    return 0;
}



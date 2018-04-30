#include <stdio.h>
float calculate_integral(float A, float B, float N);

int main()
{
    float A = 8;  // starting point
    float B = 20;  // ending point
    float N = 999999;  // number of rectangles (bigger = more precise)
    float result = calculate_integral(A, B, N);
    printf("Integral is: %f\n", result);
    return 0;
}



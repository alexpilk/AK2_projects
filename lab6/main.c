#include <stdio.h>
void clean_registers();
float calculate_integral(float A, float B, float N);
float calculate_integral_sse(float A, float B, float N);

int main()
{
    float A = 8;  // starting point
    float B = 20;  // ending point
    float N = 64;  // number of rectangles (bigger = more precise)
    // printf("\n");
    // clean_registers();
    // printf("\n");
    
    // float result = calculate_integral(A, B, N);
    // printf("\n");
    // clean_registers();
    // printf("\n");
    // float r2= calculate_integral_sse(A, B, N);
    float result_sse= calculate_integral_sse(A, B, N);
    // printf("\n");
    // clean_registers();
    // printf("\n");
    // printf("Integral is: %f\n", result);
    printf("Integral is: %f\n", result_sse);
    return 0;
}



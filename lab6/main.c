#include <stdio.h>
#include <math.h>

unsigned long long int get_timestamp();
float calculate_integral(float A, float B, float N);
float calculate_integral_sse(float A, float B, float N);

int measure(float (*function)(float, float, float), float A, float B, float N){
    float cpu_frequency = 3600;
    unsigned long long int start = get_timestamp();
    int integral = function(A, B, N);
    unsigned long long int stop = get_timestamp();
    float result = (stop - start) / cpu_frequency;
    printf("Time taken: %f * 10^-6 s.\n", result);
    printf("Integral: %d\n", integral);
}

int main()
{
    float A = 2;  // starting point
    float B = 18;  // ending point
    float N = pow(4, 10);  // number of rectangles (bigger = more precise)
    printf("--- FPU only ---\n");
    measure(calculate_integral, A, B, N);
    printf("--- SSE ---\n");
    measure(calculate_integral_sse, A, B, N);
    return 0;
}



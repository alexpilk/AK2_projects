#include <stdio.h>
unsigned long long int get_timestamp(char rdtsc_switch);
const float cpu_frequency = 3600;

int measure(int (*function)(int), int n){
    unsigned long long int start = get_timestamp('0');
    int fibonacci_number = function(n);
    unsigned long long int stop = get_timestamp('1');
    printf("Start: %f\n", start/cpu_frequency);
    printf("Stop: %f\n", stop/cpu_frequency);
    float result = (stop - start) / cpu_frequency;
    printf("Time taken: %f * 10^-6 s.\n", result);
    printf("Fibonacci number: %d\n", fibonacci_number);
}

int fibonacci_iterative(int n)
{
    int prev, curr, tmp;
    prev = 0;
    curr = 1;
    for (int i = 0; i < n-1; i++)
    {
        tmp = prev + curr;
        prev = curr;
        curr = tmp;
    }
    return curr;
}

int fibonacci_recursive(int n)
{
    if (n <= 1)
        return n;
    return fibonacci_recursive(n-2) + fibonacci_recursive(n-1);
}

int main()
{
    int n = 8;
    measure(fibonacci_iterative, n);
    measure(fibonacci_recursive, n);
    return 0;
}



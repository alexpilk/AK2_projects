#include <stdio.h>
#include <math.h>

unsigned long long int get_timestamp();
const int SIZE = 25000;

int main() {
    int tmp;
    int a[25000] = {0};
    unsigned long long int start;
    unsigned long long int stop;
    float result;
    for (int i = 0; i < SIZE; i++){
        start = get_timestamp();
        tmp = a[i];
        stop = get_timestamp();
        result = stop - start;
        printf("%f\n", result);
    }
    return tmp;
}

#include <stdio.h>
#include <math.h>

unsigned long long int get_timestamp();

int main() {
    int tmp;
    const int SIZE = 1000;
    int a[1000][1000] = {0};
    unsigned long long int start;
    unsigned long long int stop;
    float result;

    start = get_timestamp();
    for(int i = 0; i < SIZE; i++){
        for (int j = 0; j < SIZE; j++){
            tmp = a[i][j];  // row - column
        }
    }
    stop = get_timestamp();
    result = stop - start;
    printf("%f\n", result);  // this is fast

    start = get_timestamp();
    for(int i = 0; i < SIZE; i++){
        for (int j = 0; j < SIZE; j++){
            tmp = a[j][i];  // column - row
        }
    }
    stop = get_timestamp();
    result = stop - start;
    printf("%f\n", result);  // this is slow
    return tmp;
}


/*
Results

row - column     8750060.000000
column - row    29201624.000000
*/
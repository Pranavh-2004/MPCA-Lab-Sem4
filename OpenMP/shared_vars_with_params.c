#include <stdio.h>
#include <omp.h>

void add(int a, int b, int *result)
{
#pragma omp parallel
    {
#pragma omp single
        *result = a + b;
    }
}

int main()
{
    int x = 5, y = 10, sum = 0;
    add(x, y, &sum);
    printf("Sum: %d\n", sum);
    return 0;
}

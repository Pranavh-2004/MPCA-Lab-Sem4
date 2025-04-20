#include <stdio.h>
#include <omp.h>

int main()
{
    int sharedVar = 0;

#pragma omp parallel shared(sharedVar)
    {
#pragma omp critical
        sharedVar += 1;
    }

    printf("Final value of sharedVar: %d\n", sharedVar);
    return 0;
}

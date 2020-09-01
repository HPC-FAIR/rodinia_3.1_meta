#include <stdio.h>
#include <stdlib.h> 

#include <omp.h>


int main() {
    const unsigned long N = (1 << 27);
    const float XVAL = rand() % 1000000;
    const float YVAL = rand() % 1000000;
    const float AVAL = rand() % 1000000;
    float x[N], y[N];

#pragma omp target data map(to:XVAL, YVAL, AVAL) map(x,y)
    {
#ifdef OMP_OFFLOAD
#pragma omp target teams distribute parallel for
#endif
    for (unsigned long i = 0; i < N; ++i) {
        x[i] = XVAL;
        y[i] = YVAL;
    }

#ifdef OMP_OFFLOAD
#pragma omp target teams distribute parallel for
#endif
    for (unsigned long i = 0; i < N; ++i) {
        y[i] += AVAL * x[i];
    }
    }
    return 0;
}


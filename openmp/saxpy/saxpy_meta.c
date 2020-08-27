#include <stdio.h>
#include <stdlib.h> 

#include <omp.h>


int main() {
    const unsigned N = (1 << 27);
    const float XVAL = rand() % 1000000;
    const float YVAL = rand() % 1000000;
    const float AVAL = rand() % 1000000;
    float x[N], y[N];

#pragma omp metadirective when(device={arch("nvptx64")}: target data map(to:XVAL, YVAL, AVAL) map(alloc:x,y))
    {
#pragma omp metadirective when(device={arch("nvptx64")}: target teams distribute parallel for) default(parallel for)
    for (int i = 0; i < N; ++i) {
        x[i] = XVAL;
        y[i] = YVAL;
    }

#pragma omp metadirective when(device={arch("nvptx64")}: target teams distribute parallel for) default(parallel for)
    for (int i = 0; i < N; ++i) {
        y[i] += AVAL * x[i];
    }
    }
    return 0;
}


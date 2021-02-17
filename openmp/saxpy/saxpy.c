#include <stdio.h>
#include <stdlib.h> 

#include <omp.h>
#define OPEN 1


int main(int argc, char** argv ) {
    int	 num_omp_threads = 4;
    const unsigned long N = (1 << 27);
    const float XVAL = rand() % 1000000;
    const float YVAL = rand() % 1000000;
    const float AVAL = rand() % 1000000;
    float x[N], y[N];
    if(argc==2)
	num_omp_threads = atoi(argv[1]);

#ifdef OPEN
        double start_time = omp_get_wtime();
#endif
#pragma omp target data map(to:XVAL, YVAL, AVAL) map(x,y)
    {
#ifdef OMP_OFFLOAD
    omp_set_num_threads(num_omp_threads);
#pragma omp target teams distribute parallel for
#endif
    for (unsigned long i = 0; i < N; ++i) {
        x[i] = XVAL;
        y[i] = YVAL;
    }

#ifdef OMP_OFFLOAD
    omp_set_num_threads(num_omp_threads);
#pragma omp target teams distribute parallel for
#endif
    for (unsigned long i = 0; i < N; ++i) {
        y[i] += AVAL * x[i];
    }
    }
#ifdef OPEN
        double end_time = omp_get_wtime();
//#ifdef _DEBUG
        printf("Compute time: %lf\n", (end_time - start_time));
//#endif
#endif
    return 0;
}


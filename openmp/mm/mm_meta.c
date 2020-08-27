#include <stdio.h>
#include <sys/time.h>
#include <stdlib.h>
#include <omp.h>

double total_in = 0;
double total_out = 0;

void gen_matrix(double* A, int N)
{
#pragma omp parallel for 
    for (int i = 0; i < N; i++) 
        for (int j = 0; j < N; j++) 
            A[i*N + j] = rand() % 10;
}

void print_matrix(double* A, int N, char *name)
{
    printf("Printing Matrix %s\n", name);
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) 
            printf("%.0f ", A[i*N + j]);
        printf("\n");
    }
    printf("\n");
}

int main(int argc, char **argv)
{
    int N = (argc==1 ? 5 : atoi(argv[1]));

    double A[N*N], B[N*N], C[N*N], C1[N*N], D[N*N];
    struct timeval  tv1, tv2;

    gen_matrix(A, N);
    gen_matrix(B, N);
    gen_matrix(C, N);

    gettimeofday(&tv1, NULL);
    double sum;
#pragma omp metadirective when(device={arch("nvptx")}: target data map(to:A,B,C) map(from:D) map(alloc:C1))
    {
#pragma omp metadirective when(device={arch("nvptx")}: target teams distribute parallel for collapse(2) private(sum)) default(parallel for collapse(2) private(sum))
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                sum = 0.0;
                for (int k = 0; k < N; k++)
                    sum = sum + A[i * N + k] * B[k * N + j];
                C1[i * N + j] = sum;
            }
        }

#pragma omp metadirective when(device={arch("nvptx")}: target teams distribute parallel for collapse(2) private(sum)) default(parallel for collapse(2) private(sum))
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                sum = 0.0;
                for (int k = 0; k < N; k++)
                    sum = sum + C1[i * N + k] * C[k * N + j];
                D[i * N + j] = sum;
            }
        }
    }
    gettimeofday(&tv2, NULL);

    printf("Time taken to multiply 3 matrices = %.2f\n",
            (double) (tv2.tv_usec - tv1.tv_usec) / 1000000 +
            (double) (tv2.tv_sec - tv1.tv_sec));
    if(argc > 2) 
    {
        print_matrix(A, N, (char*)"A");
        print_matrix(B, N, (char*)"B");
        print_matrix(C, N, (char*)"C");
        print_matrix(C1, N, (char*)"C1 = A*B");
        print_matrix(D, N, (char*)"D = A*B*C");
    }

    return 0;
}


CFLAGS = -Wall -O3 -fopenmp 
OFFLOAD_FLAG = -fopenmp-targets=nvptx64-nvidia-cuda 
CC=clang

all: jacobi jacobi_offload jacobi_meta

jacobi: jacobi.c
	$(CC) $(CFLAGS) jacobi.c -o jacobi

jacobi_offload: jacobi.c
	$(CC) $(CFLAGS) $(OFFLOAD_FLAG) -Xopenmp-target -march=sm_70 jacobi.c -o jacobi_offload -DOMP_OFFLOAD

jacobi_meta: jacobi_meta.c
	$(CC) $(CFLAGS) $(OFFLOAD_FLAG) -Xopenmp-target -march=sm_70 jacobi_meta.c -o jacobi_meta


clean:
	$(RM) jacobi jacobi_offload jacobi_meta

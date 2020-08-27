CFLAGS = -Wall -O0 -fopenmp
OFFLOAD_FLAG = -fopenmp-targets=nvptx64-nvidia-cuda 
CC=clang

all: mm offload meta

mm: mm.c
	$(CC) $(CFLAGS) mm.c -o mm

offload: mm.c
	$(CC) $(CFLAGS) $(OFFLOAD_FLAG) -Xopenmp-target -march=sm_70 mm.c -o mm_offload -DOMP_OFFLOAD

meta: mm_meta.c
	$(CC) $(CFLAGS) $(OFFLOAD_FLAG) -Xopenmp-target -march=sm_70 mm_meta.c -o mm_meta

clean:
	$(RM) mm mm_offload mm_meta

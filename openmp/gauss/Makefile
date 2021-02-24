CC = clang
CC_FLAGS =  -fopenmp -Wall
GPU_FLAGS = -fopenmp-targets=nvptx64-nvidia-cuda

all: origin offload meta

origin: gs_openmp_target.c
	$(CC) $(CC_FLAGS)  -o gs_origin gs_openmp_target.c -lm 

offload: gs_openmp_target.c
	$(CC) $(CC_FLAGS) $(GPU_FLAGS) -Xopenmp-target -march=sm_70 -o gs_offload gs_openmp_target.c -lm -DOMP_OFFLOAD

meta: gs_openmp_meta.c
	$(CC) $(CC_FLAGS) $(GPU_FLAGS) -Xopenmp-target -march=sm_70 -o gs_meta gs_openmp_meta.c -lm

clean:
	$(RM) gs_offload gs_meta


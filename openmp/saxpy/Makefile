CC = clang
CC_FLAGS =  -fopenmp -Wall
GPU_FLAGS = -fopenmp-targets=nvptx64-nvidia-cuda 

all: saxpy offload meta

saxpy: saxpy.c
	$(CC) $(CC_FLAGS) -o saxpy saxpy.c

offload: saxpy.c
	$(CC) $(CC_FLAGS) $(GPU_FLAGS) -DOMP_OFFLOAD -Xopenmp-target -march=sm_70 -o saxpy_offload saxpy.c

meta: saxpy_meta.c
	$(CC) $(CC_FLAGS) $(GPU_FLAGS) -Xopenmp-target -march=sm_70 -o saxpy_meta saxpy_meta.c

clean:
	$(RM) saxpy saxpy_offload saxpy_meta


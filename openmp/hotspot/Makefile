# C compiler
CC = clang++
CC_FLAGS = -fopenmp 
OFFLOAD_CC_FLAGS = -fopenmp-targets=nvptx64-nvidia-cuda -Xopenmp-target -march=sm_70

all: hotspot hotspot_offload hotspot_meta

hotspot: hotspot_openmp.cpp Makefile 
	$(CC) $(CC_FLAGS) hotspot_openmp.cpp -o hotspot 

hotspot_offload: hotspot_openmp.cpp Makefile
	$(CC) $(CC_FLAGS) $(OFFLOAD_CC_FLAGS) -DOMP_OFFLOAD hotspot_openmp.cpp -o hotspot_offload

hotspot_meta: hotspot_openmp_meta.cpp Makefile
	$(CC) $(CC_FLAGS) $(OFFLOAD_CC_FLAGS) hotspot_openmp_meta.cpp -o hotspot_offload_meta

clean:
	rm -f hotspot hotspot_offload hotspot_offload_meta *.out

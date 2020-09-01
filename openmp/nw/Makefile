# C compiler
CC = clang++
ICC = icc
CC_FLAGS = -g -fopenmp
OFFLOAD_CC_FLAGS =  -fopenmp-targets=nvptx64-nvidia-cuda -Xopenmp-target -march=sm_70

all: needle needle_offload needle_meta

needle: needle.cpp
	$(CC) $(CC_FLAGS) needle.cpp -o needle 

needle_offload: needle.cpp
	$(CC) $(CC_FLAGS) $(OFFLOAD_CC_FLAGS) -DOMP_OFFLOAD needle.cpp -o needle_offload

needle_meta: needle_meta.cpp
	$(CC) $(CC_FLAGS) $(OFFLOAD_CC_FLAGS) -DOMP_OFFLOAD needle_meta.cpp -o needle_meta

clean:
	rm -f needle needle_offload needle_meta

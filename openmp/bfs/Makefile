# C compiler
CC = g++
ICC = icc
CC_FLAGS = -g -fopenmp -O2
CLANG = clang++
CLANG_FLAGS = -g -fopenmp -fopenmp-targets=nvptx64-nvidia-cuda -Xopenmp-target -march=sm_70

all: bfs bfs_offload bfs_offload_meta

bfs: bfs.cpp
	$(CLANG) $(CC_FLAGS) bfs.cpp -o bfs

bfs_offload: bfs.cpp
	$(CLANG) $(CLANG_FLAGS) -DOMP_OFFLOAD=1 bfs.cpp -o bfs_offload

bfs_offload_meta: bfs_meta.cpp
	$(CLANG) $(CLANG_FLAGS) bfs_meta.cpp -o bfs_offload_meta

clean:
	rm -f bfs bfs_offload bfs_offload_meta result.txt

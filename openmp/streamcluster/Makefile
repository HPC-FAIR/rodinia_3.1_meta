PREFIX=${PARSECDIR}/pkgs/kernels/streamcluster/inst/${PARSECPLAT}

TARGET_C = sc_cpu

TARGET_O = sc_omp

TARGET_M = sc_meta

ifdef version
  ifeq "$(version)" "parallel"
    CXXFLAGS :=	$(CXXFLAGS) -DENABLE_THREADS -pthread
  endif
endif

all: cpu omp meta

cpu: streamcluster_original.cpp
	clang++ $(CXXFLAGS) $(LDFLAGS) streamcluster_original.cpp -o $(TARGET_C) $(LIBS) -DENABLE_THREADS -pthread

omp: streamcluster_omp.cpp
	clang++ -O3 -fopenmp -o $(TARGET_O) streamcluster_omp.cpp

meta: streamcluster_meta.cpp
	clang++ -O3 -fopenmp -o $(TARGET_M) streamcluster_meta.cpp


clean:
	rm -f *.o *~ *.txt sc_cpu sc_omp sc_meta
	

# C compiler
CC = clang
CC_FLAGS = -g -fopenmp -O2 

all: kmeans kmeans_meta

kmeans: cluster.o getopt.o kmeans.o kmeans_clustering.o 
	$(CC) $(CC_FLAGS) cluster.o getopt.o kmeans.o kmeans_clustering.o  -o kmeans

kmeans_meta: cluster.o getopt.o kmeans.o kmeans_clustering_meta.o 
	$(CC) $(CC_FLAGS) cluster.o getopt.o kmeans.o kmeans_clustering_meta.o  -o kmeans_meta

%.o: %.[ch]
	$(CC) $(CC_FLAGS) $< -c

cluster.o: cluster.c 
	$(CC) $(CC_FLAGS) cluster.c -c
	
getopt.o: getopt.c 
	$(CC) $(CC_FLAGS) getopt.c -c
	
kmeans.o: kmeans.c 
	$(CC) $(CC_FLAGS) kmeans.c -c

kmeans_clustering.o: kmeans_clustering.c kmeans.h
	$(CC) $(CC_FLAGS) kmeans_clustering.c -c

kmeans_clustering_meta.o: kmeans_clustering_meta.c kmeans.h
	$(CC) $(CC_FLAGS) kmeans_clustering_meta.c -c

clean:
	rm -f *.o *~ kmeans 

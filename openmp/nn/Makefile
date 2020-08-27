LOCAL_CC = gcc -g -O3 -Wall
CC = clang
CFLAGS = -lm -fopenmp -Wall


all : nn nn_meta

clean :
	rm -rf *.o nn nn_meta

nn : nn_openmp.c
	$(CC) -o nn nn_openmp.c -lm -fopenmp -Wall

meta : nn_meta.c
	$(CC) -o nn_meta nn_meta.c  -lm -fopenmp -Wall

hurricane_gen : hurricane_gen.c
	$(LOCAL_CC) -o $@ $< -lm


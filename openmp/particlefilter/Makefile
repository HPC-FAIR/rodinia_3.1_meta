#makefile

all: openmp meta

openmp: ex_particle_OPENMP_seq.c
	clang -O3 -fopenmp ex_particle_OPENMP_seq.c -o particle_filter -lm 

meta: ex_particle_OPENMP_seq_meta.c
	clang -O3 -fopenmp ex_particle_OPENMP_seq_meta.c -o particle_filter_meta -lm 

clean:
	rm particle_filter particle_filter_meta

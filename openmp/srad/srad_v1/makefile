# Example
# target: dependencies
	# command 1
	# command 2
          # .
          # .
          # .
	# command n

all: a.out meta

# link objects(binaries) together
a.out:	main.o
	clang main.o \
			-lm -fopenmp -o srad

meta:	main_meta.o
	clang main_meta.o \
			-lm -fopenmp -o srad_meta

# compile main function file into object (binary)
main.o: 	main.c \
				define.c \
				graphics.c
	clang	main.c \
			-c -O3 -fopenmp

main_meta.o: 	main_meta.c \
				define.c \
				graphics.c
	clang	main_meta.c \
			-c -O3 -fopenmp

# delete all object files
clean:
	rm *.o srad srad_meta

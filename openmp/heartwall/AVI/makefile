all: avimod.o avilib.o

# compile supporting function file into object (binary)
avimod.o: avilib.h avimod.c 
	clang -c avimod.c

# compile supporting function file into object (binary)
avilib.o: avilib.h avilib.c
	clang -c avilib.c

# delete files
clean:
	rm *.o *.out

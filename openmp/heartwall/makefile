
ifdef OUTPUT
override OUTPUT = -DOUTPUT
endif

all: heartwall heartwall_meta
# link objects(binaries) together
heartwall: main.o ./AVI/avilib.o ./AVI/avimod.o
	clang main.o ./AVI/avilib.o ./AVI/avimod.o -lm -fopenmp -o heartwall

heartwall_meta: main_meta.o ./AVI/avilib.o ./AVI/avimod.o
	clang main_meta.o ./AVI/avilib.o ./AVI/avimod.o -lm -fopenmp -o heartwall_meta

# compile main function file into object (binary)
main.o: main.c define.c kernel.c
	clang $(OUTPUT) main.c -I./AVI -c -O3 -fopenmp

main_meta.o: main_meta.c define.c kernel.c
	clang $(OUTPUT) main_meta.c -I./AVI -c -O3 -fopenmp

./AVI/avilib.o ./AVI/avimod.o:
	cd AVI; make;

# delete all object files
clean:
	rm -f *.o AVI/*.o heartwall heartwall_meta

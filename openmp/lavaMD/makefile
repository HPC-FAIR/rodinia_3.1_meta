# Example
# target: dependencies
	# command 1
	# command 2
          # .
          # .
          # .
	# command n
ifdef OUTPUT
override OUTPUT = -DOUTPUT
endif

all: a.out meta

C_C = clang
OMP_LIB = -lgomp
OMP_FLAG = -fopenmp

# link objects (binaries) together
a.out:		main.o \
			./kernel/kernel_cpu.o \
			./util/num/num.o \
			./util/timer/timer.o
	$(C_C)	main.o \
			./kernel/kernel_cpu.o \
			./util/num/num.o \
			./util/timer/timer.o \
			-lm \
			$(OMP_LIB) ${OMP_FLAG} \
			-o lavaMD
meta:		main.o \
			./kernel/kernel_cpu_meta.o \
			./util/num/num.o \
			./util/timer/timer.o
	$(C_C)	main.o \
			./kernel/kernel_cpu_meta.o \
			./util/num/num.o \
			./util/timer/timer.o \
			-lm \
			$(OMP_LIB) ${OMP_FLAG} \
			-o lavaMD_meta
# compile function files into objects (binaries)
main.o:		main.h \
			main.c \
			./kernel/kernel_cpu.h \
			./kernel/kernel_cpu.c \
			./util/num/num.h \
			./util/num/num.c \
			./util/timer/timer.h \
			./util/timer/timer.c
	$(C_C)	${OUTPUT} main.c \
			-c \
			-o main.o \
			-O3

./kernel/kernel_cpu.o:	./kernel/kernel_cpu.h \
						./kernel/kernel_cpu.c
	$(C_C)				./kernel/kernel_cpu.c \
						-c \
						-o ./kernel/kernel_cpu.o \
						-O3 \
						$(OMP_FLAG)

./kernel/kernel_cpu_meta.o:	./kernel/kernel_cpu.h \
						./kernel/kernel_cpu_meta.c
	$(C_C)				./kernel/kernel_cpu_meta.c \
						-c \
						-o ./kernel/kernel_cpu_meta.o \
						-O3 \
						$(OMP_FLAG)

./util/num/num.o:	./util/num/num.h \
					./util/num/num.c
	$(C_C)			./util/num/num.c \
					-c \
					-o ./util/num/num.o \
					-O3

./util/timer/timer.o:	./util/timer/timer.h \
						./util/timer/timer.c
	$(C_C)				./util/timer/timer.c \
						-c \
						-o ./util/timer/timer.o \
						-O3

# delete all object and executable files
clean:
	rm -f	*.o \
		./kernel/*.o \
		./util/num/*.o \
		./util/timer/*.o \
                ./util/device/*.o \
		lavaMD lavaMD_meta

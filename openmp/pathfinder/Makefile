CC = clang++
SRC = pathfinder.cpp
EXE = pathfinder
FLAGS = -fopenmp

all: release meta

release: pathfinder.cpp
	$(CC) $(SRC) $(FLAGS) -o $(EXE)

meta: pathfinder_meta.cpp
	$(CC) pathfinder_meta.cpp $(FLAGS) -o $(EXE)_meta

debug:
	$(CC) $(SRC) -g -Wall -o $(EXE)

clean:
	rm -f out pathfinder pathfinder_meta



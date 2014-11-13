# Makefile for neural2d.
#
# neural2d is the standalone console program for the neural net.
#
# This Makefile has the following targets:
#
#    make all    # same as make neural2d
#    make        # defaults to make all
#    make clean  # removes the neural2d object files
#    make test   # execute neural2d on a test set of data


# Specify a compiler invocation that understands C++11 with whatever options it requires:
COMPILER=g++ -std=c++11 -pthread -fopenmp

# Non-essential options:
EXTRACFLAGS=-g -O1 -Wall -Wextra -Wno-missing-field-initializers


all: neural2d

# The next rules make the neural2d program.

neural2d: neural2d.o neural2d-core.o Makefile
	$(COMPILER) $(EXTRACFLAGS) neural2d.o neural2d-core.o -o neural2d

neural2d.o: neural2d.cpp neural2d.h Makefile
	$(COMPILER) $(EXTRACFLAGS) -c neural2d.cpp -o neural2d.o

neural2d-core.o: neural2d-core.cpp neural2d.h Makefile
	$(COMPILER) $(EXTRACFLAGS) -c neural2d-core.cpp -o neural2d-core.o

clean:
	rm neural2d neural2d.o neural2d-core.o

# Run neural2d on a test set of images:

images/digits/test-1.bmp:
	@echo "Before running the test, you must extract the archive of images in images/digits/"
	@false

test: images/digits/test-1.bmp
	./neural2d topology.txt inputData.txt weights.txt

.PHONY: all clean test


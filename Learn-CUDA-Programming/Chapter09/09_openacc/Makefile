CUDA_PATH=/home/student_15030/cudaProj/cuda-12.4
PGCXX=pgc++
TARGET=merging

PGCXX_FLAGS= -acc -ta=tesla:managed -Minfo=accel

all: ${TARGET}

merging: image_merging.cpp scrImagePgmPpmPackage.cpp
	$(EXEC) $(PGCXX) -o $@ $+ 

clean:
	rm -f ${TARGET} *.o

CUDA_PATH=/home/student_15030/cudaProj/cuda-12.4/
HOST_COMPILER ?= g++
NVCC=${CUDA_PATH}/bin/nvcc -ccbin ${HOST_COMPILER}
TARGET=cufft.1d cufft.half cufft.mgpu
INCLUDES = -I${CUDA_PATH}/samples/common/inc
NVCC_FLAGS=-m64 # --resource-usage

IS_CUDA_11:=${shell expr `$(NVCC) --version | grep compilation | grep -Eo -m 1 '[0-9]+.[0-9]' | head -1` \>= 11.0}

# Gencode argumentes
SMS = 35 37 50 52 60 61 70 75
ifeq "$(IS_CUDA_11)" "1"
SMS = 52 60 61 70 75 80
endif
$(foreach sm, ${SMS}, $(eval GENCODE_FLAGS += -gencode arch=compute_$(sm),code=sm_$(sm)))

# Openmp
LIBRARIES += -lcufft -lcurand
ALL_CCFLAGS += -std=c++11 $(INCLUDES) -L/usr/local/cuda/lib

all : ${TARGET}

cufft.1d: cufft.1d.cpp
	$(EXEC) $(NVCC) $(ALL_CCFLAGS) $(GENCODE_FLAGS) -o $@ $+ $(LIBRARIES)

complex.o: complex.cu
	$(EXEC) $(NVCC) $(INCLUDES) $(ALL_CCFLAGS) $(GENCODE_FLAGS) -o $@ -c $<

fp16.o: fp16.cu
	$(EXEC) $(NVCC) $(INCLUDES) $(ALL_CCFLAGS) $(GENCODE_FLAGS) -o $@ -c $<

cufft.half: cufft.half.cpp complex.o fp16.o
	$(EXEC) $(NVCC) $(ALL_CCFLAGS) $(GENCODE_FLAGS) -o $@ $+ $(LIBRARIES)

cufft.mgpu: cufft.mgpu.cu complex.o
	$(EXEC) $(NVCC) $(ALL_CCFLAGS) $(GENCODE_FLAGS) -o $@ $+ $(LIBRARIES)

nvprof: cufft.1d
	nvprof -f -o $+.nvvp ./$+

clean:
	rm -f ${TARGET} *.o

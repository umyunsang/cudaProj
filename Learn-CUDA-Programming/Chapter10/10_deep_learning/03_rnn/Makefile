CUDA_PATH=/home/student_15030/cudaProj/cuda-12.4
HOST_COMPILER ?= g++
NVCC=${CUDA_PATH}/bin/nvcc -ccbin ${HOST_COMPILER}
TARGET=rnn

INCLUDES = -I${CUDA_PATH}/samples/common/inc -I$(CUDA_PATH)/include
NVCC_FLAGS=--resource-usage -Xcompiler -rdynamic -Xcompiler -fopenmp -rdc=true 

IS_CUDA_11:=${shell expr `$(NVCC) --version | grep compilation | grep -Eo -m 1 '[0-9]+.[0-9]' | head -1` \>= 11.0}

# Gencode argumentes
SMS = 35 37 50 52 60 61 70 75
ifeq "$(IS_CUDA_11)" "1"
SMS = 52 60 61 70 75 80
endif
$(foreach sm, ${SMS}, $(eval GENCODE_FLAGS += -gencode arch=compute_$(sm),code=sm_$(sm)))

LIBRARIES += -L/usr/local/cuda/lib -lcublas -lcudnn -lgomp -lcurand
ALL_CCFLAGS += -m64 -g -std=c++11 $(NVCC_FLAGS) $(INCLUDES) $(LIBRARIES)

all : ${TARGET}

rnn: rnn.cpp
	$(EXEC) $(NVCC) $(ALL_CCFLAGS) $(GENCODE_FLAGS) -o $@ $+

clean:
	rm -f ${TARGET} ${OBJ_DIR}/*.o


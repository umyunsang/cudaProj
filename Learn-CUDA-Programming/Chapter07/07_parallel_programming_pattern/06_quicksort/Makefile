CUDA_PATH=/home/student_15030/cudaProj/cuda-12.4
HOST_COMPILER ?= g++
NVCC=${CUDA_PATH}/bin/nvcc -ccbin ${HOST_COMPILER}
TARGET=quick_sort

INCLUDES = -I${CUDA_PATH}/samples/common/inc
NVCC_FLAGS=-m64 -lineinfo #--resource-usage

IS_CUDA_11:=${shell expr `$(NVCC) --version | grep compilation | grep -Eo -m 1 '[0-9]+.[0-9]' | head -1` \>= 11.0}

# Gencode argumentes
SMS = 35 37 50 52 60 61 70 75
ifeq "$(IS_CUDA_11)" "1"
SMS = 52 60 61 70 75 80
endif
$(foreach sm, ${SMS}, $(eval GENCODE_FLAGS += -gencode arch=compute_$(sm),code=sm_$(sm)))

ALL_CCFLAGS += -rdc=true $(NVCC_FLAGS) $(INCLUDES)

all : ${TARGET}
	
quick_sort: quick_sort.cu
	$(EXEC) $(NVCC) $(ALL_CCFLAGS) $(GENCODE_FLAGS) -o $@ $+ $(LIBRARIES)

nvprof: sgemm
	nvprof -f -o $+.nvvp --profile-from-start off ./$+
	nvprof -f -o $+-metrics.nvvp --analysis-metrics ./$+

clean:
	rm -f ${TARGET} *.o

CUDA_PATH=/home/student_15030/cudaProj/cuda-12.4
HOST_COMPILER ?= g++
NVCC=${CUDA_PATH}/bin/nvcc -ccbin ${HOST_COMPILER}
MPICC ?= mpicc
TARGET=simpleMPI

INCLUDES = -I${CUDA_PATH}/samples/common/inc -I/usr/local/include/
NVCC_FLAGS=-m64 -Xcompiler -fopenmp -rdc=true -lcudadevrt -lmpi # --resource-usage

IS_CUDA_11:=${shell expr `$(NVCC) --version | grep compilation | grep -Eo -m 1 '[0-9]+.[0-9]' | head -1` \>= 11.0}

# Gencode argumentes
SMS = 35 37 50 52 60 61 70 75
ifeq "$(IS_CUDA_11)" "1"
SMS = 52 60 61 70 75 80
endif
$(foreach sm, ${SMS}, $(eval GENCODE_FLAGS += -gencode arch=compute_$(sm),code=sm_$(sm)))

LIBRARIES += -lgomp
ALL_CCFLAGS += ${NVCC_FLAGS}

all : ${TARGET}

simpleMPI: simpleMPI.cu
	$(EXEC) $(NVCC) $(ALL_CCFLAGS) $(GENCODE_FLAGS) -o $@ $+ $(LIBRARIES) $(INCLUDES)

enable_mps:
	export CUDA_VISIBLE_DEVICES=0
	sudo nvidia-smi -c 3 -i 0
	sudo nvidia-cuda-mps-control -d

disable_mps:
	echo "quit" | sudo nvidia-cuda-mps-control
	sudo nvidia-smi -c 0 -i 0

nvprof: simpleMPI
	mpirun -np ${PROCS} nvprof -f -o $+.%q{OMPI_COMM_WORLD_RANK}_${STREAMS}.nvvp ./$+ ${STREAMS}

clean:
	rm -f ${TARGET} *.o *.nvvp

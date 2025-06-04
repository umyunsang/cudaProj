NVCC = nvcc
NVCCFLAGS = -O2 -arch=sm_75

# Chapter01 targets
CHAPTER01_TARGETS = Chapter01/hello_world Chapter01/vector_addition Chapter01/vector_addition_gpu

# Chapter02 targets  
CHAPTER02_TARGETS = Chapter02/sgemm Chapter02/unified_memory

all: $(CHAPTER01_TARGETS) $(CHAPTER02_TARGETS)

# Chapter01 rules
Chapter01/hello_world: Chapter01/hello_world.cu
	$(NVCC) $(NVCCFLAGS) -o $@ $<

Chapter01/vector_addition: Chapter01/vector_addition.cu
	$(NVCC) $(NVCCFLAGS) -o $@ $<

Chapter01/vector_addition_gpu: Chapter01/vector_addition_gpu.cu
	$(NVCC) $(NVCCFLAGS) -o $@ $<

# Chapter02 rules
Chapter02/sgemm: Chapter02/sgemm.cu
	$(NVCC) $(NVCCFLAGS) -o $@ $<

Chapter02/unified_memory: Chapter02/unified_memory.cu
	$(NVCC) $(NVCCFLAGS) -o $@ $<

clean:
	rm -f $(CHAPTER01_TARGETS) $(CHAPTER02_TARGETS)

.PHONY: all clean 
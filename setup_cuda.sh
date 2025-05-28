#!/bin/bash

# CUDA 12.4 환경 설정 스크립트
export CUDA_HOME=/home/student_15030/cudaProj/cuda-12.4
export CUDA_PATH=/home/student_15030/cudaProj/cuda-12.4
export PATH=$CUDA_HOME/bin:$PATH
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH

echo "CUDA 12.4 환경이 설정되었습니다!"
echo "CUDA_HOME: $CUDA_HOME"
echo "CUDA_PATH: $CUDA_PATH"
echo "nvcc 버전:"
nvcc --version 
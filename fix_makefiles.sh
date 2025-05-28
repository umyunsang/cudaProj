#!/bin/bash

# Learn-CUDA-Programming 디렉토리의 모든 Makefile에서 CUDA_PATH 수정
echo "Learn-CUDA-Programming 디렉토리의 Makefile들을 수정합니다..."

find /home/student_15030/cudaProj/Learn-CUDA-Programming -name "Makefile" -type f | while read makefile; do
    echo "수정 중: $makefile"
    sed -i 's|CUDA_PATH=/usr/local/cuda|CUDA_PATH=/home/student_15030/cudaProj/cuda-12.4|g' "$makefile"
done

echo "모든 Makefile 수정 완료!"
echo "수정된 파일 개수:"
find /home/student_15030/cudaProj/Learn-CUDA-Programming -name "Makefile" -type f | wc -l 
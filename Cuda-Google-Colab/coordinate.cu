
#include <cuda_runtime.h>
#include <stdio.h>

__global__ void printCoordinate(int *A,const int nx,const int ny)
{
  int ix=threadIdx.x+blockIdx.x*blockDim.x;
  int iy=threadIdx.y+blockIdx.y*blockDim.y;
  unsigned int idx=iy*nx+ix;
  printf("thread_id(%d,%d) block_id(%d,%d) coordinate(%d,%d)"
          "global index %2d ival %2d\n",threadIdx.x,threadIdx.y,
          blockIdx.x,blockIdx.y,ix,iy,idx,A[idx]);
}

int main(int argc,char ** argv)
{
  cudaSetDevice(0);
  int nx = 8;
  int ny = 6;
  // Malloc
  int* A_host = (int*)malloc(nx*ny*sizeof(int));
  for(int i = 0; i<nx*ny; ++i){
      A_host[i] = 0;
  }

  // cudaMalloc
  int *A_dev=NULL;
  cudaMalloc((void**)&A_dev, nx*ny*sizeof(int));
  cudaMemcpy(A_dev, A_host, nx*ny*sizeof(int), cudaMemcpyHostToDevice);

  dim3 block(4,2);
  dim3 grid((nx-1)/block.x+1,(ny-1)/block.y+1);

  printCoordinate<<<grid,block>>>(A_dev,nx,ny);
  cudaDeviceSynchronize();

  // Free
  cudaFree(A_dev);
  free(A_host);

  cudaDeviceReset();
  return 0;
}

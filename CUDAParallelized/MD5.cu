#include "MD5.cuh"

__global__ void MD5BreakerKernel(int * hps, std::string hashPassword)
{
    int index = threadIdx.x + blockIdx.x*blockDim.x;
    for(int i=0; i<n; i++){
        //TODO: Insert hashing an password functionality here
        hps[index]++;
    }
}
//Kernel for our function, 
#include <cstdint>

__global__ void MD5BreakerKernel(int * hps, uint16_t * hashPassword, uint8_t * foundPwd);

__host__ __device__ void MD5(const uint8_t * data, size_t length, uint8_t hash[16]);
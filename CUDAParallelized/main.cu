#include <iostream>
#include <string>
#include <cmath>
#include <vector>
#include "MD5.cuh"

#define MAX_PWD_LENGTH 12
int main(int argc, char* argv[]) {

    //check arg
    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <string>\n";
        return 1;
    }

    std::string passcode = argv[1];

    int * hps;
    //this will need to be updated based on MAX_PWD_LENGTH
    int threads = 62+62*62+62*62*62;
    int blocks = std::ceil((float)threads / 1024.0f);
    std::vector<int> hps_local(blocks);
    uint8_t foundPwd_local[MAX_PWD_LENGTH];
    uint16_t * cudaHash;
    uint8_t * foundPwd;

    cudaMalloc((void**)&hps, sizeof(int) * blocks);
    cudaMalloc((void**)&cudaHash, 16*sizeof(uint16_t));
    cudaMalloc((void**)&foundPwd, MAX_PWD_LENGTH*sizeof(uint8_t));

    uint8_t md5Hash[16];
    MD5(reinterpret_cast<const uint8_t*>(passcode.data()), passcode.length(), md5Hash);

    cudaMemcpy(cudaHash, &md5Hash, sizeof(md5Hash), cudaMemcpyHostToDevice);
	
	/*************Variables To Prepare For The Hash**************************************************
		1 Variable to hold the hash to compare to
		2 Variable to pull the string out of	
	
	//we need to make the hash to compare against 
	//this value must be able to be pointed to by our kernels. 
		//Will need to load this value into the memory for kernels to use.
	uint8_t md5HashHost[16];
	uint8_t md5HashDevice[16];
	MD5(passcode, md5HashHost);	
	
	//Need to validate if "sizeof(uint8_t) * (16)" will work for certian, but we can adjust it as needed
	cudaMalloc((void**)&md5HashDevice, sizeof(uint8_t) * (16));
	cudaMemcpy(md5HashDevice, &md5HashHost, sizeof(uint8_t) * (16), cudaMemcpyHostToDevice);
	
	//also need to pull a string out of the hash
	****************************************************/

    cudaEvent_t start;
    cudaEvent_t stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start);

    MD5BreakerKernel<<<blocks, 1024>>>(hps, cudaHash, foundPwd);

    cudaEventRecord(stop);
    cudaEventSynchronize(stop);

    float ms;
    cudaEventElapsedTime(&ms, start, stop);

    cudaMemcpy(hps_local.data(), hps, blocks*sizeof(int), cudaMemcpyDeviceToHost);
    cudaMemcpy(&foundPwd_local, foundPwd, MAX_PWD_LENGTH*sizeof(uint8_t), cudaMemcpyDeviceToHost);

    int hps_total = 0;

    for(int hp : hps_local){
        hps_total += hp;
    }

    hps_total = hps_total / ((int)ms/1000);
    std::cout << "Execution Time: " << ms << std::endl;
    std::cout << "Hashes per Second: " << hps_total << std::endl;
     
}
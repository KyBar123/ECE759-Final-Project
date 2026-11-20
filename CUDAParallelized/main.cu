int main(int argc, char* argv[]) {

    //check arg
    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <string>\n";
        return 1;
    }

    std::string passcode = argv[1];

    int * hps;
    int threads;
    int hps_local[threads;]

    cudaMalloc((void**)&hps, sizeof(int) * threads);
    cudaMemset(threads, 0, threads * sizeof(int));
	
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

    MD5BreakerKernel<<<std::ceil((float)n / 1024.0f), 1024>>>(hps, passcode);

    cudaEventRecord(stop);
    cudaEventSynchronize(stop);

    float ms;
    cudaEventElapsedTime(&ms, start, stop);

    cudaMemcpy(&hps_local, hps, threads*sizeof(int), cudaMemcpyDeviceToHost);

    int hps_total = 0;

    for(int hp : hps_local){
        hps_total += hps;
    }

    hps_total = hps_total / ((int)ms*1000);
    std::cout << hps_total << std::endl;
     
}
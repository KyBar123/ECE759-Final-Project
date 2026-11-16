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
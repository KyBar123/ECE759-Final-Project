#include <cstdlib>
#include <iostream>
#include <vector>
#include <chrono>
#include "MD5.h"
#include "wordGen.h"

using std::chrono::high_resolution_clock;
using std::chrono::duration;


int main(int argc, char* argv[]) {

    //check arg
    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <string>\n";
        return 1;
    }

    //itiallize timing.md fields
    high_resolution_clock::time_point start;
    high_resolution_clock::time_point end;
    duration<double, std::milli> duration_ms;
    duration<double> duration_sec;
    duration<double, std::ratio<60>> duration_min;


    //grab inputted passcode
    std::string passcode = argv[1];

    //time MD5 algorithm
    double hashes = 0;
   

    uint8_t md5Hash[16];
    MD5(passcode, md5Hash);
    hashes++;
	
	start = high_resolution_clock::now();
	
	uint8_t comp[16];
	//brute force cracking
	bool flag = 0;
    unsigned long long halfCharLimit = 62*62*62*62*62;
    unsigned long long charLimit = halfCharLimit * halfCharLimit;
	for(unsigned long long i = 0; i < charLimit; i++){
		wordGen(i,comp);
        hashes++;
		flag = 1;
		
		for(int j = 0; j < 16; j++){
			if(md5Hash[j] != comp[j]){
				flag = 0;
				break;
			}
			
		}
		
		if(flag == 1){
			std::cout << "Password Found!\n"; 
			break;
		}
	}
	
	if(!flag) std::cout << "Password NOT Found!\n"; 
		
    end = high_resolution_clock::now();

    duration_ms = std::chrono::duration_cast<duration<double, std::milli>>(end - start);
    duration_sec = std::chrono::duration_cast<duration<double>>(end - start);
    duration_min = std::chrono::duration_cast<duration<double, std::ratio<60>>>(end - start);
    
    //report timig and bounding elements
    std::cout << "Execution time: " << duration_min.count() << "\n";

    //report HPS
    double hps = hashes/ (duration_ms.count()/1000);
    std::cout << "Hashes per second: " << hps << "\n";

    return 0;
}

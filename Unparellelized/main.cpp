#include <cstdlib>
#include <iostream>
#include <vector>
#include <chrono>
#include "MD5.h"
#include "wordGen.h"

using std::chrono::high_resolution_clock;
using std::chrono::duration;



//g++ main.cpp MD5.cpp wordGen.cpp -Wall -O3 -std=c++17 -o passwordTest -fopenmp


int main(int argc, char* argv[]) {

    //check arg
    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <string>\n";
        return 1;
    }

    //itiallize timing.md fields
    high_resolution_clock::time_point start;
    high_resolution_clock::time_point end;
    duration<double, std::milli> duration_sec;

    //grab inputted passcode
    std::string passcode = argv[1];

    //time MD5 algorithm
    start = high_resolution_clock::now();
   

    uint8_t md5Hash[16];
    MD5(passcode, md5Hash);
	
	
	
	uint8_t comp[16];
	//brute force cracking
	bool flag = 0;
	for(int i = 1; i < 62*62*62; i++){
		wordGen(i,comp);
		flag = 1;
		
		for(int j = 0; j < 16; j++){
			if(md5Hash[j] != comp[j]){
				flag = 0;
				break;
			}
			
		}
		
		if(flag == 1){
			std::cout << "Password Found!"; 
			break;
		}
	}
	
	if(!flag) std::cout << "Password NOT Found!"; 
		
    end = high_resolution_clock::now();

    duration_sec = std::chrono::duration_cast<duration<double, std::milli>>(end - start);
    
    //report timig and bounding elements
    std::cout << duration_sec.count() << "\n";

    return 0;
}

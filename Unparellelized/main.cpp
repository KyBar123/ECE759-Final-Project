#include <cstdlib>
#include <iostream>
#include <vector>
#include <chrono>
#include "MD5.h"

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
    duration<double, std::milli> duration_sec;

    //grab inputted passcode
    std::string passcode = argv[1];

    //time MD5 algorithm
    start = high_resolution_clock::now();
    uint8_t md5Hash[16];
    MD5(passcode, md5Hash);
    end = high_resolution_clock::now();

    duration_sec = std::chrono::duration_cast<duration<double, std::milli>>(end - start);
    
    //report timig and bounding elements
    std::cout << duration_sec.count() << "\n";

    return 0;
}

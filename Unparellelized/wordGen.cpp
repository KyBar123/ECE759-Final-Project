#include <string>
#include <cstdlib>
#include <iostream>
#include <vector>
#include <chrono>
#include "wordGen.h"
#include "MD5.h"

using namespace std;

void wordGen(int uniqueNum, uint8_t compareHash[16]){
	
	
	
	//every loop divide i by 62, but process the remainder for the current loop. Should make a sitation like 62 result in 0 and 61 on a later loop be z
	int sub = 62;
	int digits = 1;
	std::string word = "";		
	
	//need to identify the digits we'll need to handle based on the number given
	while(uniqueNum >= sub){
			//decrease number by digit dimensions
			uniqueNum-=sub;
			//increase digit dimensions to next step
			sub = sub*62;
			//track digits needed
			digits++;
			
			//std::cout << "top" << uniqueNum << " vs   " << sub << " \n ";
	}
	
	//loop through the number of characters we determined by the loop above
	for(int i = 0; i < digits; i++){
		
		int sel;
		int rem = uniqueNum%62;
		
		if(rem<10) sel = (rem) + 48;
		//this shifts the entry of i to align with char(65)=A [This is due to i needing to be 10+ to reach this
		else if(rem<36) sel = (rem) + 55;
		//this shifts the entry of i to align with char(97)=A [This is due to i needing to be 10+ to reach this
		else sel = rem+61;
		
		//add character entry to word
		word += ((char)sel);
		
		//drag to the next digit slot
		uniqueNum = uniqueNum/62;
	}
	
	
	//implement the hash on the word we generate
	MD5(word, compareHash);	
}
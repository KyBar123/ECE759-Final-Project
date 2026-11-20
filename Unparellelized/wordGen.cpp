#include <iostream>
#include <string>
#include "wordGen.h"
#include "MD5.h"

using namespace std;

uint8_t wordGen(int uniqueNum){
	
	std::string word = "";	
		//every loop divide i by 62, but process the remainder for the current loop. Should make a sitation like 62 result in 0 and 61 on a later loop be z
	for(int i = uniqueNum; i > 0; i=i/62){
		int sel;
		int rem = i%62;
		if(rem<10) sel = (rem) + 48;
		//this shifts the entry of i to align with char(65)=A [This is due to i needing to be 10+ to reach this
		else if(rem<36) sel = (rem) + 55;
		//this shifts the entry of i to align with char(97)=A [This is due to i needing to be 10+ to reach this
		else sel = (i%62)+61;
		word += ((char)sel);
	}	
	
	//implement the hash on the word we generate
	uint8_t compareHash[16];
	MD5(passcode, compareHash);		
	return compareHash;
}

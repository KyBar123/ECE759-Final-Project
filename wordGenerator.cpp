#include <iostream>
#include <string>

using namespace std;

//g++ wordGenerator.cpp -Wall -O3 -std=c++17 -o wordTest -fopenmp

int main(int argc, char *argv[]){
	//Objective, take an int command line input and count from 0 to that number, then from that number down to 0
	
	//Initialize input as a int
	int topEnd = std::stoi(argv[1]);
		
	//every loop divide i by 62, but process the remainder for the current loop. Should make a sitation like 62 result in 0 and 61 on a later loop be z
	int sub = 62;
	int digits = 1;
	
	//need to identify the digits we'll need to handle based on the number given
	while(topEnd >= sub){
			//decrease number by digit dimensions
			topEnd-=sub;
			//increase digit dimensions to next step
			sub = sub*62;
			//track digits needed
			digits++;
			
			//std::cout << "top" << topEnd << " vs   " << sub << " \n ";
	}
	
	std::string word = "";	
	
	//loop through the number of characters we determined by the loop above
	for(int i = 0; i < digits; i++){
		
		int sel;
		int rem = topEnd%62;
		
		if(rem<10) sel = (rem) + 48;
		//this shifts the entry of i to align with char(65)=A [This is due to i needing to be 10+ to reach this
		else if(rem<36) sel = (rem) + 55;
		//this shifts the entry of i to align with char(97)=A [This is due to i needing to be 10+ to reach this
		else sel = rem+61;
		
		//add character entry to word
		word += ((char)sel);
		
		//drag to the next digit slot
		topEnd = topEnd/62;
	}
	
	std::cout << word;

}



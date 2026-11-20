#include <iostream>
#include <string>

using namespace std;

//g++ wordGenerator.cpp -Wall -O3 -std=c++17 -o wordTest -fopenmp

int main(int argc, char *argv[]){
	//Objective, take an int command line input and count from 0 to that number, then from that number down to 0
	
	//Initialize input as a int
	int topEnd = std::stoi(argv[1]);
	//topEnd = 63;
	//For loop to count up from 0 to the taken number. On ending, set a new line
    //for(int count = 0; count <= topEnd; count++ ){
	//	 char hold = (char)count;
    //     printf("\n %d = %c", count, hold);
	//}
	//printf("\n");
	/*******************************************************
		Method 1, array pairing
			Removing after this push 
			Why? This method has a higher a mem cost
				Not good when handling a ton of threads
	*******************************************************/
	
	
	/*******************************************************
		Method 1, char casting pairing
	*******************************************************/
	
	//first make a loop to handle generating all of the letters and numbers you want		
	/******Commenting out test code**************************************************
	for(int i = 0; i < 62; i++){
		//shifts the entry of i to align with char(48)=0
		int sel;
		if(i<10) sel = i + 48;
		//this shifts the entry of i to align with char(65)=A [This is due to i needing to be 10+ to reach this
		else if(i<36) sel = i + 55;
		//this shifts the entry of i to align with char(97)=A [This is due to i needing to be 10+ to reach this
		else sel = i+61;
		char hold = (char)sel;
		//printf("\n %d = %c", i, hold);
	}
	**********************************************************************************/
	//the above code will cover all the possible values we would be concerned about.
	
	//okay it takes 62 values to cover all characters we are looking to cover
		//need a clever way to ensure that we can cover multiple at once
		//Plan, leverage remainder of %62 and shift the value down until it is 0
		
		
	std::string word = "";	
		//every loop divide i by 62, but process the remainder for the current loop. Should make a sitation like 62 result in 0 and 61 on a later loop be z
	for(int i = topEnd; i > 0; i=i/62){
		int sel;
		int rem = i%62;
		if(rem<10) sel = (rem) + 48;
		//this shifts the entry of i to align with char(65)=A [This is due to i needing to be 10+ to reach this
		else if(rem<36) sel = (rem) + 55;
		//this shifts the entry of i to align with char(97)=A [This is due to i needing to be 10+ to reach this
		else sel = (i%62)+61;
		word += ((char)sel);
		std::cout << word;
		std::cout << "\n";
	}	
		
	

}



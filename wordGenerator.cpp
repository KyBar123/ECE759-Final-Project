#include <iostream>

using namespace std;


int main(int argc, char *argv[]){
	//Objective, take an int command line input and count from 0 to that number, then from that number down to 0
	
	//Initialize input as a int
	int topEnd = std::stoi(argv[1]);
	
	//For loop to count up from 0 to the taken number. On ending, set a new line
    //for(int count = 0; count <= topEnd; count++ ){
	//	 char hold = (char)count;
    //     printf("\n %d = %c", count, hold);
	//}
	//printf("\n");
	/*******************************************************
		Method 1, array pairing
	*******************************************************/
	for(int i = 0; i <= topEnd; i++ ){
		
		
		
	}
	
	
	
	/*******************************************************
		Method 1, char casting pairing
	*******************************************************/
	
	//first make a loop to handle generating all of the letters and numbers you want

	for(int i = 0; i < 62; i++){
		//shifts the entry of i to align with char(48)=0
		int sel;
		if(i<10) sel = i + 48;
		//this shifts the entry of i to align with char(65)=A [This is due to i needing to be 10+ to reach this
		else if(i<36) sel = i + 55;
		//this shifts the entry of i to align with char(97)=A [This is due to i needing to be 10+ to reach this
		else sel = i+61;
		char hold = (char)sel;
		printf("\n %d = %c", i, hold);
	}
	//okay it takes 62 values to cover all characters we are looking to cover
		//need a clever way to ensure that we can cover multiple at once
	

}



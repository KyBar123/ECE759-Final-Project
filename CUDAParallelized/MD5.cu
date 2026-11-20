#include "MD5.cuh"

__global__ void MD5BreakerKernel(int * hps, std::string hashPassword)
{
    int index = threadIdx.x + blockIdx.x*blockDim.x;
    //DELETION REQUEST: THIS FOR LOOP IS UNNEEDED
	for(int i=0; i<n; i++){
		
        //TODO: Insert hashing an password functionality here
        hps[index]++;
		
	//index should easily be able to leverage the for loop from wordGen.cpp to generate the word to be hashed and we should be able to compare here.
		//This should be pretty lightweight for each run
	/*****************************************************
	std::string word = "";	
	//every loop divide i by 62, but process the remainder for the current loop. Should make a sitation like 62 result in 0 and 61 on a later loop be z
	for(int i = index; i > 0; i=i/62){
		int sel;
		int rem = i%62;
		if(rem<10) sel = (rem) + 48;
		//this shifts the entry of i to align with char(65)=A [This is due to i needing to be 10+ to reach this
		else if(rem<36) sel = (rem) + 55;
		//this shifts the entry of i to align with char(97)=A [This is due to i needing to be 10+ to reach this
		else sel = (i%62)+61;
		word += ((char)sel);
	}
	*****************************************************/
	
	
	//DELETION REQUEST: THIS FOR ENDING FOR THE LOOP IS UNNEEDED
	}
	
	// implement an MD5 Hash here
	/*************
		Can we just pull the info from before for hashing?
	**************/
	
	
	/****************
	if(successful pair)
		print out the word here
		set flag to kill event
	****************/
	
}
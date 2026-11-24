#include "MD5.cuh"
__device__ unsigned int done = 0;

__global__ void MD5BreakerKernel(int * hps, uint16_t * hashedPassword, uint8_t * foundPwd)
{
	bool hashed = false;
	if(done != 0) return;
    int index = threadIdx.x + blockIdx.x*blockDim.x;
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

	
	// implement an MD5 Hash here
	/*************
		Can we just pull the info from before for hashing?
	**************/
	//Insert this after calls to MD5
	hashed = true;
	
	/****************
	if(successful pair)
		print out the word here
		set flag to kill event
	****************/
    //add this to if after finding password
    done = 1;


	const int blockHashes = __syncthreads_count(hashed);
	if(threadIdx.x == 0){
		hps[blockIdx.x] = blockHashes;
	}
	
}

__host__ __device__ void MD5(const uint8_t * data, size_t length, uint8_t hash[16]){

    //shift amounts for the operations
    const uint32_t s[64] = {7, 12, 17, 22,  7, 12, 17, 22,  7, 12, 17, 22,  7, 12, 17, 22, 
        5,  9, 14, 20,  5,  9, 14, 20,  5,  9, 14, 20,  5,  9, 14, 20, 
        4, 11, 16, 23,  4, 11, 16, 23,  4, 11, 16, 23,  4, 11, 16, 23,
        6, 10, 15, 21,  6, 10, 15, 21,  6, 10, 15, 21,  6, 10, 15, 21 };
   
    //Assign constants to provide uniqueness for steps that use the same fucntion and shift amount
    // (Or just use the following precomputed table):
    const uint32_t K[64] = { 0xd76aa478, 0xe8c7b756, 0x242070db, 0xc1bdceee, 
        0xf57c0faf, 0x4787c62a, 0xa8304613, 0xfd469501,
        0x698098d8, 0x8b44f7af, 0xffff5bb1, 0x895cd7be, 
        0x6b901122, 0xfd987193, 0xa679438e, 0x49b40821,
        0xf61e2562, 0xc040b340, 0x265e5a51, 0xe9b6c7aa,
        0xd62f105d, 0x02441453, 0xd8a1e681, 0xe7d3fbc8,
        0x21e1cde6, 0xc33707d6, 0xf4d50d87, 0x455a14ed,
        0xa9e3e905, 0xfcefa3f8, 0x676f02d9, 0x8d2a4c8a,
        0xfffa3942, 0x8771f681, 0x6d9d6122, 0xfde5380c,
        0xa4beea44, 0x4bdecfa9, 0xf6bb4b60, 0xbebfbc70,
        0x289b7ec6, 0xeaa127fa, 0xd4ef3085, 0x04881d05,
        0xd9d4d039, 0xe6db99e5, 0x1fa27cf8, 0xc4ac5665,
        0xf4292244, 0x432aff97, 0xab9423a7, 0xfc93a039,
        0x655b59c3, 0x8f0ccc92, 0xffeff47d, 0x85845dd1, 
        0x6fa87e4f, 0xfe2ce6e0, 0xa3014314, 0x4e0811a1,
        0xf7537e82, 0xbd3af235, 0x2ad7d2bb, 0xeb86d391 };

    //Initialize the 32 bit constants
    uint32_t a0 = 0x67452301;  // A
    uint32_t b0 = 0xefcdab89;  // B
    uint32_t c0 = 0x98badcfe;  // C
    uint32_t d0 = 0x10325476;  // D

    //Save the original passwords length
    uint64_t passLen = (uint64_t)length;
    uint64_t passLenBits = static_cast<uint64_t>(passLen) * 8;
	uint8_t buf[64];
	for(size_t i = 0; i<length; i++){
		buf[i] = data[i];
	}

    //Add padding
    buf[length] = 0x80;
	size_t index = length;
    while (((index+1)* 8) % 512 != 448){
		index++;
        buf[index] = 0x00;
    }

    //add the original length of the password to the hash
    for (int i = 0; i < 8; i++){
		index++;
        buf[index] = ((passLenBits >> (8 * i)) & 0xff);
    }

    //Break the password into 512 bit blocks
    size_t numBlocks = (index+1) / 64;
    uint32_t M[16];
    for (size_t j=0; j<numBlocks; j++){
        for (int k=0; k<16; k++){
            size_t base = j*64 + k * 4;
            M[k] =  static_cast<uint32_t>(buf[base])
                | (static_cast<uint32_t>((buf[base + 1])) <<  8)
                | (static_cast<uint32_t>((buf[base + 2])) << 16)
                | (static_cast<uint32_t>((buf[base + 3])) << 24);
        }
        //Initialize the hash value for the block. (The 4 32-bit words - A, B, C, D)
        uint32_t A = a0;
        uint32_t B = b0;
        uint32_t C = c0;
        uint32_t D = d0;
        for (int l=0; l<16; l++){
            uint32_t F, g;
            F = (B & C)| ((~B) & D);
            g = l;
            F = F + A + K[l] + M[g];
            A = D;
            D = C;
            C = B;
            B = B + ((F << s[l]) | (F >> (32 - s[l])));
        }
        for (int m=16; m<32; m++){
            uint32_t F, g;
            F = ((D & B) | ((~D) & C));
            g = (5 * m + 1) % 16;
            F = F + A + K[m] + M[g];
            A = D;
            D = C;
            C = B;
            B = B + ((F << s[m]) | (F >> (32 - s[m])));
        }

        for (int n=32; n<48; n++){
            uint32_t F, g;
            F = (B ^ C ^ D);
            g = (3 * n + 5) % 16;
            F = F + A + K[n] + M[g];
            A = D;
            D = C;
            C = B;
            B = B + ((F << s[n]) | (F >> (32 - s[n])));
        }

        for (int o=48; o<64; o++){
            uint32_t F, g;
            F = (C ^ (B | (~D)));
            g = (7 * o) % 16;
            F = F + A + K[o] + M[g];
            A = D;
            D = C;
            C = B;
            B = B + ((F << s[o]) | (F >> (32 - s[o])));
        }
        //Add the chuncks for this block
        a0 = a0 + A;
        b0 = b0 + B;
        c0 = c0 + C;
        d0 = d0 + D;
    }

    //String the 4 32-bit words together
    uint32_t words[4] = {a0, b0, c0, d0};
    for (int w=0; w<4; w++){
        for (int b=0; b<4; b++){
            hash[w * 4 + b] = ((words[w]) >> (8*b)) & 0xff;
        }
    }

    // for (int printtest=0; printtest<16; printtest++){
    //     std::cout << hash[printtest];
    // }
}
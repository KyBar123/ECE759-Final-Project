#ifndef MD5_H
#define MD5_H
#include <string>
#include <cstdint>

void MD5(std::string password, uint8_t hash[16]);

#endif
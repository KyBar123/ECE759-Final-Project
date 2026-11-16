#ifndef MD5_H
#define MD5_H
#include <string>
#include <cstddef>

// Performs a brute force attack on an MD5 hashed password
uint8_t MD5(std::string password);

#endif
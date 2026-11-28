#!/usr/bin/env zsh

#SBATCH -J unparallelSlurm
#SBATCH -o unparallelSlurm-%j.out 
#SBATCH -e unparallelSlurm-%j.err
#SBATCH -p instruction
#SBATCH -t 0-00:30:00
#SBATCH --mem=16G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

g++ main.cpp MD5.cpp wordGen.cpp -Wall -O3 -std=c++17 -o main

./main zz
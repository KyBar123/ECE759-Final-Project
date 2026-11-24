#!/usr/bin/env zsh
#SBATCH --partition=instruction
#SBATCH --time 00:10:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --output="main.out"

cd $SLURM_SUBMIT_DIR
# load the gcc for compiling C++ programs
module load nvidia/cuda/12.9.1

nvcc main.cu MD5.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std=c++17 -o main

./main abc
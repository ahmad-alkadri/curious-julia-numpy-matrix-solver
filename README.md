# NumPy and Julia Benchmarking

This repository contains scripts to benchmark the performance of matrix equation solving (`Ax = B`) using NumPy (Python) and Julia.

## Overview

The benchmarking process is divided into three main parts:
1. **Matrix Generation**: Random matrices and vectors are generated using NumPy.
2. **NumPy Benchmarking**: The `numpy.linalg.solve` function is used to solve the equation and its performance is recorded.
3. **Julia Benchmarking**: The `\` operator in Julia is used to solve the equation and its performance is recorded.

All the generated matrices, vectors, and results of the benchmarking are stored as `.txt` and `.csv` files respectively.

## Dependencies

- Python 3
- NumPy
- Julia
- Python `memory_profiler` library
- Julia packages: `BenchmarkTools`, `DelimitedFiles`, `CSV`, `DataFrames`

## Directory Structure

- `matrix_generation.py`: Python script to generate matrices and vectors.
- `numpy_side.py`: Python script for benchmarking with NumPy.
- `julia_side.jl`: Julia script for benchmarking with Julia.
- `Makefile`: Automates the setup, matrix generation, benchmarking, and cleanup processes.

## How to Run the Benchmark Tests

Ensure you have Python 3, NumPy, and Julia installed on your machine. 

### Step-by-step Instructions:

1. **Clone the Repository**:

```bash
git clone https://github.com/ahmad-alkadri/curious-julia-numpy-matrix-solver.git julia_numpy_matrix
cd julia_numpy_matrix
```

2. **Run the Benchmark Tests:**

Use the provided Makefile to run the benchmark tests:

```bash
make all
```
Explanation of major Makefile targets:

- `genmatrix`: Generates matrices and vectors used for testing.
- `numpy`: Runs the NumPy benchmark.
- `julia`: Runs the Julia benchmark.
- `combine_results`: Combines the results of NumPy and Julia benchmarks into a single .csv file.
- `all`: Runs all of the above targets in order.

3. **View Results:**

Once the tests have run, the results will be available in the `results.csv` file.

4. **Clean Up (Optional)**

To clean up generated files and reset the environment, run:

```bash
make reset
```

This will remove generated matrices, vectors, results, and virtual environments.


from julia.api import Julia
import numpy as np
import time

jl = Julia(compiled_modules=True)  # Use True for faster subsequent runs
from julia import Main

# Include the Julia code file
Main.eval('include("matrix_solver.jl")')

# Random Seed for Reproducibility
np.random.seed(0)

# List of matrix sizes to benchmark
matrix_sizes = [10, 100, 500, 1000, 1500]

# Benchmarking
for n in matrix_sizes:
    print(f"\nMatrix Size: {n}x{n}")

    # Generating Random Matrices and Vectors
    A_np = np.random.rand(n, n)
    B_np = np.random.rand(n)
    
    A_jl = A_np.tolist()
    B_jl = B_np.tolist()
    
    # NumPy
    start_time = time.time()
    x_np = np.linalg.solve(A_np, B_np)
    numpy_time = time.time() - start_time
    print(f"NumPy Time: {numpy_time:.6f} seconds")
    
    # Julia
    start_time = time.time()
    x_jl = Main.solve_matrix(A_jl, B_jl)
    julia_time = time.time() - start_time
    print(f"Julia Time: {julia_time:.6f} seconds")

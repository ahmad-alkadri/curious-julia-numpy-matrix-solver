from memory_profiler import memory_usage
import numpy as np
import timeit
import gc

matrix_sizes = [10, 100, 500, 1000, 1500, 2000]


def solve_equation(A, B):
    return np.linalg.solve(A, B)


results = []

for matrix_size in matrix_sizes:
    # Load matrices
    matrix_A = np.loadtxt(f"matrix_A_{matrix_size}.txt")
    vector_B = np.loadtxt(f"vector_B_{matrix_size}.txt")

    # Time the function using timeit
    elapsed_time = timeit.timeit(
        "solve_equation(matrix_A, vector_B)",
        setup=f"from __main__ import solve_equation, matrix_A, vector_B",
        number=1,  # Number of executions
    )

    # Measure memory
    mem_usage_before = memory_usage(max_usage=True)
    mem_usage, vector_x = memory_usage(
        (solve_equation, (matrix_A, vector_B)), max_usage=True, retval=True
    )
    mem_usage_increment = mem_usage - mem_usage_before

    # Append results
    results.append((matrix_size, elapsed_time, mem_usage_increment))

    # Cleanup
    del matrix_A, vector_B, vector_x
    gc.collect()

# Save results to CSV
np.savetxt(
    "numpy_results.csv",
    results,
    delimiter=",",
    header="MatrixSize,Time,Memory",
    comments="",
    fmt=["%d", "%.6f", "%.6f"],
)

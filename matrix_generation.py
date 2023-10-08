import numpy as np

# Define matrix sizes
matrix_sizes = [10, 100, 500, 1000, 1500, 2000]

# Set the seed for reproducibility
np.random.seed(0)

# Define the range for matrix elements
low_value = -10
high_value = 10

for matrix_size in matrix_sizes:
    # Generate matrices
    A = np.random.uniform(low_value, high_value, (matrix_size, matrix_size))
    x = np.random.uniform(low_value, high_value, matrix_size)

    # Calculate B such that Ax = B
    B = np.dot(A, x)

    # Save matrices with size info
    np.savetxt(f"matrix_A_{matrix_size}.txt", A)
    np.savetxt(f"vector_B_{matrix_size}.txt", B)

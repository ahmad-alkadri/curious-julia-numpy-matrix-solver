using BenchmarkTools, CSV, DataFrames, DelimitedFiles

matrix_sizes = [10, 100, 500, 1000, 1500, 2000]

results = []

function solve_equation(A, B)
	x = A \ B
end

for matrix_size in matrix_sizes
	# Use let block to limit the scope of variables and help with memory management
	let matrix_A = Matrix(CSV.File("matrix_A_$(matrix_size).txt"; header = false) |> DataFrame),
		df_B = CSV.File("vector_B_$(matrix_size).txt"; header = false) |> DataFrame,
		vector_B = df_B[!, 1]  # Extract the first column without copying

		# Run the function and benchmark
		bm = @benchmark solve_equation($matrix_A, $vector_B)

		push!(results, (matrix_size, mean(bm).time / 1e9, mean(bm).memory / 1e6))

		# Explicitly call the garbage collector
		GC.gc()
	end
end

# Save results to CSV
open("julia_results.csv", "w") do io
	println(io, "MatrixSize,Time,Memory")  # Adding a header line
	writedlm(io, results, ',')  # Writing data below the header
end

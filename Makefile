.PHONY: julia numpy genmatrix all setup_julia setup_python check_python_venv check_numpy install_numpy

VENV_NAME=venv
JULIA_ENV_NAME=JuliaEnv

all: genmatrix numpy julia combine_results

combine_results:
	@echo "Combining results..."
	@echo "MatrixSize,NumPyTime,NumPyMemory,JuliaTime,JuliaMemory" > results.csv
	@paste -d, numpy_results.csv <(cut -d, -f2- julia_results.csv) | sed '1d' >> results.csv

julia: setup_julia
	@echo "Running Julia benchmarks..."
	@julia --project=$(JULIA_ENV_NAME) -e 'using Pkg; Pkg.activate("."); include("./julia_side.jl")'

numpy: setup_python
	@echo "Running NumPy benchmarks..."
	@$(VENV_NAME)/bin/python numpy_side.py 

genmatrix: setup_python
	@echo "Generating matrices..."
	@$(VENV_NAME)/bin/python matrix_generation.py 

setup_julia: $(JULIA_ENV_NAME)/Manifest.toml

setup_python: check_python_venv check_numpy check_memory_profiler

check_python_venv: 
	@if [ ! -d "$(VENV_NAME)" ]; then python3 -m venv $(VENV_NAME); fi

check_numpy:
	@$(VENV_NAME)/bin/python -c "import numpy" || make install_numpy

check_memory_profiler:
	@$(VENV_NAME)/bin/python -c "import memory_profiler" || make install_profiler

install_profiler:
	@$(VENV_NAME)/bin/pip install memory-profiler	

install_numpy:
	@$(VENV_NAME)/bin/pip install numpy

# Sets up a Julia environment in a subfolder $(JULIA_ENV_NAME) and installs necessary packages
$(JULIA_ENV_NAME)/Manifest.toml: 
	@echo "Setting up Julia environment..."
	@julia --project=$(JULIA_ENV_NAME) -e 'using Pkg; Pkg.activate("."); Pkg.add(["BenchmarkTools", "DelimitedFiles", "CSV", "DataFrames"]); Pkg.precompile(); Pkg.instantiate()'

reset:
	rm -rf venv && rm *.toml && rm *.txt && rm *.csv
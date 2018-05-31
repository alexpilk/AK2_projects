# Optimizing integrals with SSE
Clean: `make clean`  
Build: `make`  
Run: `make run`  
Clean, build and run: `make all`  
Debug: `make debug`

## Example
1. Put **A**, **B** and **N** values in `main.c`
2. Run `make all`

## Results  
```
--- FPU only ---
Time taken: 12866.693359 * 10^-6 s.
Integral: 1909

--- SSE ---
Time taken: 2514.093262 * 10^-6 s.
Integral: 1909
```
**511%** performance increase was achieved.
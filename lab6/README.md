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
Time taken: 12847.139648 * 10^-6 s.
Integral: 1909

--- SSE ---
Time taken: 1059.088867 * 10^-6 s.
Integral: 1909
```
In given example SSE version is **12** times faster.
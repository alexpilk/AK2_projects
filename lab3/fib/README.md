# Converting string from ASCII characters to bytes
Clean: `make clean`  
Build: `make`  
Run: `make run`  
Clean, build and run: `make all`

## Example
1. Start debugging `make debug`
2. Press `<Enter>`
3. Set breakpoint at exit e.g. `b 63`
4. Run `r`
5. Check number in memory `x /4xb &curr`

For `$N = 47` this should output:  `0xb1    0x19    0x24    0xe1`  
which is `2971215073` in decimal.
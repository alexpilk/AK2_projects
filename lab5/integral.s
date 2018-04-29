SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
SUCCESS_CODE = 0
REAL_N = 250

.data
x: .float 34.4
const_b: .float 2
A: .float 1
B: .float 9
N: .float 250  # number of rectangles
zero: .float 0  # number of rectangles

.global _start

/*
st0 - ongoing operations
st1 - rectangle width
st2 - accumulating area
st3 - current x
*/

_start:
call get_rectangle_width
fst %st(1)  # put rect width into %st1
call process_rectangles


get_rectangle_width:
mov $B, %eax
fld (%eax)
fsub A
fdiv N
ret  # stores result in st0


process_rectangles:
mov $x, %eax

fmul zero
fst %st(2)
fadd A

xor %ecx, %ecx # counts rectangles
loop:
fst %st(3)
call parabol
call get_area
fadd %st(0), %st(2)  # put area into %st2

inc %ecx
cmp $REAL_N, %ecx
je exit

fmul zero
fadd %st(3), %st(0)
#fld %st(3)
fadd %st(1), %st(0)
jmp loop


parabol:
#fld (%eax) # put x into st0
#fmul (%eax) # x^2
fmul %st(0) # x^2
fsub const_b  # subtract b factor
ret


get_area:
fmul %st(1)
ret


exit:
mov $SYSEXIT, %eax
mov $0, %ebx
int $0x80

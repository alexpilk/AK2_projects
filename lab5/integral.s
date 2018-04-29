SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
SUCCESS_CODE = 0

.data
const_b: .float 2
A: .float 1
B: .float 90
N: .float 999999  # number of rectangles
zero: .float 0  # number of rectangles
one: .float 1

.global _start

/*
st0 - ongoing operations
st1 - rectangle width
st2 - accumulating area
st3 - current x
st6 - counter
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
fmul zero
fst %st(2)
fst %st(6)
fadd A

xor %ecx, %ecx # counts rectangles

loop:
fst %st(3)
call parabol
call get_area
fadd %st(0), %st(2)  # put area into %st2

inc %ecx

fmul zero
fadd %st(6)
fadd one
fst %st(6)
#cmp $REAL_N, %ecx

fmul zero
fadd %st(6), %st(0)
# FCOM example: http://www.website.masmforum.com/tutorials/fptute/fpuchap7.htm#fcom
fcom N
fstsw %ax          #copy the Status Word containing the result to AX
fwait             #insure the previous instruction is completed
sahf
jz exit
#jge exit

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

SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
SUCCESS_CODE = 0

.data
x: .float 34.4
const_b: .float 2
A: .float 1
B: .float 6
N: .float 10  # number of rectangles

.global _start

/*
st0 - ongoing operations
st1 - rectangle width
st2 - accumulating area
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
call parabol
call get_area
fst %st(2)  # put area into %st2
jmp exit


parabol:
fld (%eax) # put x into st0
fmul (%eax) # x^2
fsub const_b  # subtract b factor
ret


get_area:
fmul %st(1)
ret


exit:
mov $SYSEXIT, %eax
mov $0, %ebx
int $0x80

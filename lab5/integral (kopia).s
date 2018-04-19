SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
SUCCESS_CODE = 0

# For $N = 47 program correctly outputs:    0xb1    0x19    0x24    0xe1
# which is 2971215073 in decimal
# It is the largest fibonacci number that can be represented on 4 bytes

.data
x: .float 34.4
const_b: .float 2
A: .float 1
B: .float 6
N: .float 10
rect_width: .float

.global _start


_start:
jmp get_rectangle_width


get_rectangle_width:
mov $B, %eax
fld (%eax)
fsub A
fdiv N
jmp process_rectangles


process_rectangles:
fstp rect_width
mov $A, %ecx
mov $x, %eax
jmp parabol


get_area:
fmul rect_width
jmp exit


parabol:
fld (%eax)
fmul (%eax)
fsub const_b
jmp get_area


exit:
mov $SYSEXIT, %eax
mov $0, %ebx
int $0x80

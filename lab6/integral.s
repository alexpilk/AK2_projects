.data
consttt_b: .float 2
A1: .float 0
B1: .float 0
N1: .float 0  # number of rectangles
result: .float
zero: .float 0  # number of rectangles
onnne: .float 1

.global calculate_integral
.global clean_registers

/*
st0 - ongoing operations
st1 - rectangle width
st2 - accumulated area
st3 - current X
st6 - counter
*/

clean_registers:
# Clear registers
# fldz# zero  # zero out %st0
# fst %st(1)  # zero out %st2
# fst %st(2)  # zero out %st6
# fst %st(3)  # zero out %st6
# fst %st(4)  # zero out %st6
# fst %st(5)  # zero out %st6
# fst %st(6)  # zero out %st6
# fst %st(7)  # zero out %st6
ret

calculate_integral:
pushl %ebp  # save frame pointer (%ebp) on the stack
movl %esp, %ebp

# Collect arguments
movl 8(%esp), %edx
movl %edx, A1
movl 12(%esp), %edx
movl %edx, B1
movl 16(%esp), %edx
movl %edx, N1

call get_rectangle_width
fst %st(1)  # put rectangle width into %st1
call process_rectangles
fld %st(2)  # load accumulated area into %st0
fst result  # store %st0 value in $result
mov $result, %eax  # copy result to return address

leave
ret


get_rectangle_width:
fld B1  # load B into %st0
fsub A1  # subtract starting point (A) from ending point (B)
fdiv N1  # divide by the number of rectangles
ret  # store result in %st0


process_rectangles:
fmul zero  # zero out %st0
fst %st(2)  # zero out %st2
fst %st(6)  # zero out %st6
fadd A1  # put starting point A into %st0 (this is the first X value)

area_accumulation_loop:
fst %st(3)  # copy last X value into %st3
call parabol
call get_area
fadd %st(0), %st(2)  # put area into %st2

fmul zero  # zero out %st0
fadd %st(6)  # copy counter %st6 into %st0
fadd onnne  # increment the counter
fst %st(6)  # put it back into %st6

# FCOM example: http://www.website.masmforum.com/tutorials/fptute/fpuchap7.htm#fcom
fcom N1  # compare current counter in 5st0 to number of rectangles
fstsw %ax  # copy the Status Word containing the result to AX
fwait  # insure the previous instruction is completed
sahf
jz exit  # if counter == number of rectangles: exit
#jge exit  # this can be usedinstead of jz to add a rectangle in the end

# otherwise if counter < number of rectangles:
fmul zero  # zero out %st0
fadd %st(3), %st(0)  # put last X into %st0
fadd %st(1), %st(0)  # add rectangle width
jmp area_accumulation_loop  #


parabol:
fmul %st(0) # x^2
fsub consttt_b  # subtract b factor
ret


get_area:
fmul %st(1)
ret


exit:
ret

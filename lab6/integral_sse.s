.data
.align 16
# const_b: .float 2
A: .float 0
B: .float 0
N: .float 0  # number of rectangles
result: .float 6
zero: .float 0  # number of rectangles
four: .float 4


x_es: .float 0, 1, 2, 3
const_b: .float 2, 2, 2, 2
one: .float 1, 1, 1, 1
step: .float 4, 4, 4, 4
rectangle_width: .float 0, 0, 0, 0

dupa: .float 5, 0, 0, 0

.section .bss
.lcomm out, 4

.section .text

.global calculate_integral_sse
.global clean_registers


/*
st0 - ongoing operations
st1 - rectangle width
st2 - accumulated area
st3 - current X
st6 - counter

xmm0 - x_es
xmm1 - parabol
xmm2 - const_b
xmm3 - rectangle widths
xmm4 - area
*/

calculate_integral_sse:
	pushl %ebp  # save frame pointer (%ebp) on the stack
	movl %esp, %ebp

	# Collect arguments
	movl 8(%esp), %edx
	movl %edx, A
	movl 12(%esp), %edx
	movl %edx, B
	movl 16(%esp), %edx
	movl %edx, N

	call get_rectangle_width
	fst %st(1)  # put rectangle width into %st1
	call process_rectangles
	#fld %st(2)  # load accumulated area into %st0
	fst result  # store %st0 value in $result

	haddps %xmm4, %xmm5
	haddps %xmm5, %xmm5
	shufps $1, %xmm5, %xmm5
	/*movd %xmm2, out
	movd out, %xmm6

    #mov $four, %eax
	#fld 0(%xmm2)

	shufps $1, %xmm5, %xmm5
    movups %xmm5, out
    /*mov out, %eax
    mov %eax, result
    fld out*/
    #movsd %xmm5, -8(%ebp)
    #fldl -8(%ebp)*/
    #movups dupa, %xmm5
    movsd  %xmm5, -8(%ebp)
    movsd  %xmm5, result
   	fld   -8(%ebp)
	#fmul zero  # zero out %st0
	#fadd -4(%ebp)  # zero out %st0
	#fld four

    s:
    nop
	leave
	ret


get_rectangle_width:
	fld B  # load B into %st0
	fsub A  # subtract starting point (A) from ending point (B)
	fdiv N  # divide by the number of rectangles
	fst rectangle_width
	movd rectangle_width, %xmm3
	shufps $0, %xmm3, %xmm3
	ret  # store result in %st0

process_rectangles:
	fmul zero  # zero out %st0
	fst %st(2)  # zero out %st2
	fst %st(6)  # zero out %st6
	fadd A  # put starting point A into %st0 (this is the first X value)
	movups x_es, %xmm0
	movups const_b, %xmm2

area_accumulation_loop:
	fst %st(3)  # copy last X value into %st3
	call parabol
	call get_area
	#fadd %st(0), %st(2)  # put area into %st2
    addps %xmm1, %xmm4

	fmul zero  # zero out %st0
	fadd %st(6)  # copy counter %st6 into %st0
	fadd four  # increment the counter
	fst %st(6)  # put it back into %st6

	# FCOM example: http://www.website.masmforum.com/tutorials/fptute/fpuchap7.htm#fcom
	fcom N  # compare current counter in 5st0 to number of rectangles
	fstsw %ax  # copy the Status Word containing the result to AX
	fwait  # insure the previous instruction is completed
	sahf
	jz exit  # if counter == number of rectangles: exit

	# otherwise if counter < number of rectangles:
	fmul zero  # zero out %st0
	fadd %st(3), %st(0)  # put last X into %st0
	fadd %st(1), %st(0)  # add rectangle width
	jmp area_accumulation_loop  #


parabol:
	movups %xmm0, %xmm1
	mulps %xmm1, %xmm1  # x ^ 2
	subps %xmm2, %xmm1  # - 2
	ret


get_area:
	fmul %st(1)
	mulps %xmm3, %xmm1
	ret


exit:
	ret

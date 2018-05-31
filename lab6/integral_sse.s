.data
A: .float 0
B: .float 0
N: .float 0  # number of rectangles
zero: .float 0  # number of rectangles
four: .float 4

x_es: .float 0, 1, 2, 3
const_b: .float 2, 2, 2, 2
rectangle_width: .float 0

.global calculate_integral_sse
/*
xmm0 - x_es
xmm1 - parabol
xmm2 - const_b
xmm3 - rectangle widths (vectorized)
xmm4 - current area
xmm5 - summed area
xmm6 - A (vectorized)
xmm7 - step interval (vectorized)
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
	call process_rectangles

	haddps %xmm4, %xmm5
	haddps %xmm5, %xmm5
	shufps $1, %xmm5, %xmm5
    movsd  %xmm5, -8(%ebp)
    fstp A
   	fld   -8(%ebp)

	leave
	ret


get_rectangle_width:
	fld B  # load B into %st0
	fsub A  # subtract starting point (A) from ending point (B)
	fdiv N  # divide by the number of rectangles
	fst rectangle_width
	# vectorize rectangle width and store it in xmm3
	movd rectangle_width, %xmm3
	shufps $0, %xmm3, %xmm3
	ret

process_rectangles:
	fmul zero  # zero out %st0
	fst %st(6)  # zero out %st6
	fadd A  # put starting point A into %st0 (this is the first X value)

    # Copy A into %xmm6
	movd A, %xmm6
	shufps $0, %xmm6, %xmm6

    # Store starting (x) points in %xmm0
	movups x_es, %xmm0
	mulps %xmm3, %xmm0
	addps %xmm6, %xmm0

    # Put step distance into %xmm7
    movups four, %xmm7
	shufps $0, %xmm7, %xmm7
    mulps %xmm3, %xmm7

	movups const_b, %xmm2

area_accumulation_loop:
	call parabol
	call get_area

	# Add current area (xmm1) to area accumulator (xmm4)
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

    # Shift X in xmm0 by step in xmm7
    addps %xmm7, %xmm0
	jmp area_accumulation_loop


parabol:
	movups %xmm0, %xmm1
	mulps %xmm1, %xmm1  # x ^ 2
	subps %xmm2, %xmm1  # - 2
	ret


get_area:
	mulps %xmm3, %xmm1
	ret


exit:
	ret

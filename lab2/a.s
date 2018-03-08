SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
EXIT_SUCCESS = 0

.data
hello:
	.string "helLe wORld\n"

.globl	_start


_start:
	mov    	$12, %esi
	mov	$0, %edi
# 	mov    	$hello, %eax

	myloop:
	sub $1, %esi
	movb    hello(,%esi,1), %al
	movb	hello(,%edi,1), %dl

	mov	%al, hello(,%edi,1)
	mov	%dl, hello(,%esi,1)

	add	$1, %edi

	cmp $6, %esi
    	je end

    	jmp myloop

    	end:
	movl	$SYSWRITE,%eax
	movl	$STDOUT,%ebx
	movl	$hello,%ecx
	movl	$12,%edx
	int	    $0x80

	mov $SYSEXIT, %eax
	mov $EXIT_SUCCESS, %ebx
	int $0x80

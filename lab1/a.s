SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
EXIT_SUCCESS = 0

.data
hello:
	.string "helLo wORld\n"

.globl	_start


_start:
	# uppercaseing
	mov    $12, %esi
	mov    $hello, %edi
	myloop:
	sub $1, %esi
	movb    (%edi,%esi), %al
	movl  (%edi,%esi), %edx
	andl  $0x60, %edx

	cmp $0x60, %edx
    jne aftersub     # jump if not equal

	sub $0x20, %al

	aftersub:
	movb    %al,(%edi,%esi)
	

    cmp $0, %esi
    je end

    jmp myloop

    end:
	movl	$SYSWRITE,%eax
	movl	$STDOUT,%ebx
	movl	%edi,%ecx
	movl	$12,%edx
	int	    $0x80

	mov $SYSEXIT, %eax
	mov $EXIT_SUCCESS, %ebx
	int $0x80

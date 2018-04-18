SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
SUCCESS_CODE = 0

N = 7
BYTES_AVAILABLE = 4

.bss
.comm prev, 4
.comm curr, 4

.text
.global _start

/*
%edi - previous number
%esi - current number
*/

_start:
mov $3, %eax  # memory register
movb $250, %dh  # first fib number
movb $255, %dl  # second fib number
movb %dh, prev(,%eax,1)
movb %dl, curr(,%eax,1)
mov $2, %eax  # memory register
movb $255, %dh  # first fib number
movb $255, %dl  # second fib number
movb %dh, prev(,%eax,1)
movb %dl, curr(,%eax,1)

big_endian_add:
mov $BYTES_AVAILABLE, %eax  # eax = digit position counter, starting from end
mov $0, %ebx  # reset carry register
mov $1, %edi  # default carry value

big_endian_add_loop:
sub $1, %eax
movb prev(,%eax,1), %dh  # copy previous number to %dh
movb curr(,%eax,1), %dl  # copy current number to %dl
add  %bl, %dl  # add carry do destination
mov $0, %ebx  # reset carry
cmovc %edi, %ebx  # set carry to default carry value if carry eflag is set
addb  %dh, %dl  # add previous number to current
cmovc %edi, %ebx  # set carry to default carry value if carry eflag is set

movb %dl, curr(,%eax,1)  # save results on current position to memory
movb %dh, prev(,%eax,1)

cmp $0, %eax  # exit if digit position is zero
je exit_big_endian_add
jmp big_endian_add_loop  # otherwise continue to the next digit


exit_big_endian_add:
movb %dl, curr(,%eax,1)
#movb prev(,%eax,4), %dh
#movzx %dh, %esi

jmp exit


exit:
mov $SYSEXIT, %eax
mov %esi, %ebx
int $0x80

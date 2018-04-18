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
movb $150, %bl  # first fib number
movb $150, %dl  # second fib number
movb %bl, prev(,%eax,1)
movb %dl, curr(,%eax,1)
mov $2, %eax  # memory register
movb $150, %bl  # first fib number
movb $150, %dl  # second fib number
movb %bl, prev(,%eax,1)
movb %dl, curr(,%eax,1)
mov $4, %eax  # memory register

big_endian_add:
sub $1, %eax
movb prev(,%eax,1), %bl
movb curr(,%eax,1), %dl
addb  %dh, %dl
addb  %bl, %dl

jnc no_carry
#sub $1, %eax
#add $1, curr(,%eax,1)
#add $1, %eax
mov $1, %dh
jmp continue_loop
no_carry:
mov $0, %dh
continue_loop:

movb %dl, curr(,%eax,1)
movb %bl, prev(,%eax,1)
# jmp skip_carry
# jc dupa
cmp $0, %eax
je exit_big_endian_add
jmp big_endian_add
#no_carry:
#jmp big_endian_add
#add $1, %eax

exit_big_endian_add:
movb %dl, curr(,%eax,1)
#movb prev(,%eax,4), %bl
#movzx %bl, %esi

jmp exit


exit:
mov $SYSEXIT, %eax
mov %esi, %ebx
int $0x80

SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
SUCCESS_CODE = 0

# 47 correctly outputs 0xb1    0x19    0x24    0xe1
# which is 2971215073
# It is the largest fibonacci number that can be represented on 4 bytes
BYTES_AVAILABLE = 4
N = 47

.bss
.comm prev, 4
.comm curr, 4

.text
.global _start


_start:
mov $3, %eax  # memory register
movb $0, %dh  # first fib number
movb $1, %dl  # second fib number
movb %dh, prev(,%eax,1)  # move starting numbers to memory
movb %dl, curr(,%eax,1)
mov $1, %ecx  # start fib counter from 2 (0 and 1 fibonacci numbers are hardcoded)
jmp count_fibonacci_numbers

count_fibonacci_numbers:
cmp $N, %ecx  # check if the given number N has been found
je exit  # if so - exit
inc %ecx  # else increment the counter and add prev to curr
jmp big_endian_add

big_endian_add:
mov $BYTES_AVAILABLE, %eax  # %eax = digit position counter, starting from end
mov $0, %ebx  # reset %ebx (%ebx = carry register)
mov $1, %edi  # %edi = default carry value

big_endian_add_loop:
sub $1, %eax
movb prev(,%eax,1), %dh  # copy previous number to %dh
movb curr(,%eax,1), %dl  # copy current number to %dl
movb %dl, prev(,%eax,1)  # overwrite previous number in memory with the current number

add  %bl, %dl  # add carry do destination
mov $0, %ebx  # reset carry
cmovc %edi, %ebx  # set carry to default carry value if carry eflag is set
addb  %dh, %dl  # add previous number to current
cmovc %edi, %ebx  # set carry to default carry value if carry eflag is set

movb %dl, curr(,%eax,1)  # save results on current position to memory

cmp $0, %eax  # exit if digit position is zero
je exit_big_endian_add
jmp big_endian_add_loop  # otherwise continue to the next digit

exit_big_endian_add:
jmp count_fibonacci_numbers


exit:
mov $SYSEXIT, %eax
mov $0, %ebx
int $0x80

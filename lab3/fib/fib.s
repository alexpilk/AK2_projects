SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
SUCCESS_CODE = 0

N = 6

.bss
.comm prev, 4
.comm curr, 4
# previous db 0abcdh
.equ previous, 84
.text
.global _start

/*
%edi - previous number
%esi - current number
*/

_start:
mov $0, %eax  #memory index

mov $2, %ebx  # start fib counter (0 and 1 fibonacci numbers are hardcoded)


mov $0, %edi  # first fib number
mov $1, %esi  # second fib number
mov %edi, prev(,%eax,4)
mov %esi, curr(,%eax,4)


jmp fibonacci_generator

fibonacci_generator:
mov prev(,%eax,4), %edi  # load prev from memory
mov curr(,%eax,4), %esi  # load prev from memory
add %esi, %edi  # add two numbers and store result in %edi
mov %esi, %edx  # copy %esi (old largest number) to temp register %edx
mov %edi, %esi  # copy the new largest number (%edi) to %esi
mov %edx, %edi  # copy old largest number (%edx) to new smallest number (%edi)
cmp $N, %ebx
je exit
inc %ebx

mov %edi, prev(,%eax,4)  # load results back into memory
mov %esi, curr(,%eax,4)

jmp fibonacci_generator

exit:
mov $SYSEXIT, %eax
mov %esi, %ebx
int $0x80

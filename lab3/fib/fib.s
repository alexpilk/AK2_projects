SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
SUCCESS_CODE = 0

N = 14

.data
.text
.global _start

/*
%edi - 
%esi - buffer index register
%edx - holds number characters before they are added to the buffer (remainder register)
%ebx - divisor register
*/

_start:
mov $2, %ebx

mov $0, %edi
mov $1, %esi

jmp fibonacci_generator

fibonacci_generator:
add %esi, %edi  # add two numbers and store result in %edi
mov %esi, %edx  # copy %esi (old largest number) to temp register %edx
mov %edi, %esi  # copy the new largest number (%edi) to %esi
mov %edx, %edi  # copy old largest number (%edx) to new smallest number (%edi)
cmp $N, %ebx
je exit
inc %ebx
jmp fibonacci_generator

exit:
mov $SYSEXIT, %eax
mov %esi, %ebx
int $0x80

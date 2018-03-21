SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
SUCCESS_CODE = 0

.data
msg: .ascii "Hello Worlds!!!"
msg_len = . - msg
buffer: .ascii ""
 
.text
.global _start

/*
%edi - main message index register (starts from max index)
%esi - buffer index register
%edx - holds number characters before they are added to the buffer (remainder register)
%ebx - divisor register
*/

_start:
mov $msg_len, %edi
add $9, %edi
mov msg(,%edi,1), %dh
movzb %dh, %eax  # put last character into %eax
jmp convert_char_to_numbers

convert_char_to_numbers:
mov $0, %edx   # write 0 to 'remainder' register
mov $10, %ebx  # set divisor to 10
div %ebx       # divide eax by 10
add $48, %edx  # add 48 (index of 0 in ascii) to the remainder (edx)
mov %edx, buffer(,%esi,1)  # store edx on 'esi' index in buffer
inc %esi  # add 1 to 'esi'
inc %ebp
cmp $0, %eax  # if eax (quotient) == 0 after division --> get_next_char
je get_next_char
jmp convert_char_to_numbers  # if there are more numbers for ascii character --> repeat

get_next_char:
mov $32, %edx  # write 'space' character to edx
mov %edx, buffer(,%esi,1)  # put 'space' into buffer after the last character converted
inc %esi   # increment buffer index
dec %edi   # decrement main message index
cmp $0, %edi
jl reverse_buffer  # if 'edi' < 0 (iteration over message is finished) --> reverse buffer
movb msg(,%edi,1), %dh  # else move next char to eax
movzb %dh, %eax
jmp convert_char_to_numbers  # convert char to numbers and add to buffer

reverse_buffer:
# 'edi' iterates from 0 upwards, 'esi' - from buffer length downwards
# once they meet in a passionate 'cmp' --> exit
cmp %edi, %esi
jle exit

mov buffer(,%edi,1), %cl
mov buffer(,%esi,1), %dl
mov %cl, buffer(,%esi,1)
mov %dl, buffer(,%edi,1)
dec %esi
inc %edi
jmp reverse_buffer

exit:
mov $SYSWRITE, %eax
mov $STDOUT, %ebx     
mov $buffer, %ecx
mov %ebp, %edx  # move buffer length to 4th print parameter
int	    $0x80

mov $SYSEXIT, %eax
mov $SUCCESS_CODE, %ebx
int	    $0x80
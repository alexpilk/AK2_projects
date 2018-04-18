.global get_timestamp


get_timestamp:
pushl %ebp  # save frame pointer (%ebp) on the stack
movl %esp, %ebp
movl 8(%esp), %edx  # move first argument to %edx
movl $48, %eax  # ascii character for '0'
cmp %eax, %edx
je _rdtsc  # if switch == 0 go to rdtsc
jmp _rdtscp # if switch == 1 go to rdtscp

_rdtsc:
xor %eax, %eax
xor %edx, %edx
cpuid
rdtsc
jmp exit

_rdtscp:
xor %eax, %eax
xor %edx, %edx
rdtscp
jmp exit

exit:
leave  # restore frame pointer (same as "pop %ebp")
ret

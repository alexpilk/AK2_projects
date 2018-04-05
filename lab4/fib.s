SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
EXIT_SUCCESS = 0
# A program to be called from a C program
# Declaring data that doesn't change
# .section .data
#     string: .ascii  "Hello from assembler\n"
#     length: .quad   . - string
#     buffer: .ascii ""
#     hello:
#         .string "helLo wORld\n"

# The actual code
.section .text
.global as_print
.type as_print, @function              #<-Important

as_print:
    pop     %esi
    xor     %eax, %eax  # reset %eax
    cpuid
    # rdtsc
    # mov     $255, %edx
    
    #popl %ebx
    #popl %esi
    #popl %edi
    mov     %edi, %eax
    leave
    
    # movl    $SYSWRITE,%eax

    # mov    $hello, %edi
    # mov $0, %esi
    # movb    $3,(%edi,%esi)
    # movl    $STDOUT,%ebx
    # movl    %edi,%ecx
    # movl    $12,%edx
    # int     $0x80
    ret

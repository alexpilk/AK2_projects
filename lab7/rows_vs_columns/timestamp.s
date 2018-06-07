
.global get_timestamp

get_timestamp:
xor %eax, %eax
xor %edx, %edx
rdtscp
ret
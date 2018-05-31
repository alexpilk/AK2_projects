
.PHONY : clean run
.DEFAULT_GOAL := build

C_CODE_PATH = main.c
AS_CODE_PATH = integral.s
SSE_CODE_PATH = integral_sse.s
TIMESTAMP_CODE_PATH = timestamp.s

NAME = fib
OUTPUT_DIR = bin
OUTPUT_PATH = ${OUTPUT_DIR}/${NAME}

build:
	mkdir -p ${OUTPUT_DIR}
	gcc -m32 -g -o ${OUTPUT_PATH} ${C_CODE_PATH} ${TIMESTAMP_CODE_PATH} ${AS_CODE_PATH} ${SSE_CODE_PATH} -std=c99 -std=gnu99
clean:
	-rm ${NAME}.o
	-rm -rf ${OUTPUT_DIR}
run:
	./${OUTPUT_PATH}
all: clean build run
debug: clean build
	gdb ${OUTPUT_PATH}

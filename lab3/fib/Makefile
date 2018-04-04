
.PHONY : clean run
.DEFAULT_GOAL := build

NAME = fib
OUTPUT_DIR = bin
OUTPUT_PATH = ${OUTPUT_DIR}/${NAME}

build: ${NAME}.o
	ld -o ${OUTPUT_PATH} ${OUTPUT_PATH}.o
${NAME}.o: ${NAME}.s
	mkdir -p ${OUTPUT_DIR}
	as -g -o ${OUTPUT_PATH}.o ${NAME}.s

clean :
	-rm -rf ${OUTPUT_DIR}
run:
	./${OUTPUT_PATH}
all: clean build run
debug: clean build
	gdb ${OUTPUT_PATH}

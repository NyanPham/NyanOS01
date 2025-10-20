BUILD_DIR=../build
OS_DIR=$(BUILD_DIR)/os
OS=$(OS_DIR)/os

CFLAGS+=-ffreestanding -nostdlib -gdwarf-4 -m32 -ggdb3 -fno-pic

OS_SRCS := $(wildcard *.c)
OS_OBJS := $(patsubst %.c, $(OS_DIR)/%.o, $(OS_SRCS))

all: $(OS)

$(OS_DIR)/%.o: %.c
	mkdir -p $(OS_DIR)
	gcc $(CFLAGS) -c $< -o $@

$(OS): $(OS_OBJS)
	ld -m elf_i386 -nmagic -Tos.lds $(OS_OBJS) -o $@	

clean:
	rm $(OS_OBJS)

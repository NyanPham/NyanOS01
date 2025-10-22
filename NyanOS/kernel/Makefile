BUILD_DIR=../build
KERN_DIR=$(BUILD_DIR)/kernel
KERN=$(KERN_DIR)/kernel

CFLAGS+=-ffreestanding -nostdlib -gdwarf-4 -m32 -ggdb3 -fno-pic

KERN_SRCS := $(wildcard *.c)
KERN_OBJS := $(patsubst %.c, $(KERN_DIR)/%.o, $(KERN_SRCS))

all: $(KERN)

$(KERN_DIR)/%.o: %.c
	mkdir -p $(KERN_DIR)
	gcc $(CFLAGS) -c $< -o $@

$(KERN): $(KERN_OBJS)
	ld -m elf_i386 -nmagic -Tkernel.lds $(KERN_OBJS) -o $@	

clean:
	rm $(KERN_OBJS)

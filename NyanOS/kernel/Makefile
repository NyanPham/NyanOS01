BUILD_DIR=../build
KERN_DIR=$(BUILD_DIR)/kernel
KERN=$(KERN_DIR)/kernel

CFLAGS+=-ffreestanding -nostdlib -gdwarf-4 -m32 -ggdb3 -fno-pic
ASFLAGS+=-f elf -F dwarf -g 

C_SRCS := $(wildcard *.c)
ASM_SRCS := $(wildcard *.s)

C_OBJS := $(patsubst %.c, $(KERN_DIR)/%.c.o, $(C_SRCS))
ASM_OBJS := $(patsubst %.s, $(KERN_DIR)/%.s.o, $(ASM_SRCS))
ALL_OBJS := $(C_OBJS) $(ASM_OBJS)

all: $(KERN)

$(KERN_DIR)/%.c.o: %.c
	mkdir -p $(KERN_DIR)
	gcc $(CFLAGS) -c $< -o $@

$(KERN_DIR)/%.s.o: %.s
	mkdir -p $(KERN_DIR) 
	nasm $(ASFLAGS) $< -o $@

$(KERN): $(ALL_OBJS) kernel.lds
	ld -m elf_i386 -nmagic -Tkernel.lds $(ALL_OBJS) -o $@	

clean:
	rm $(ALL_OBJS) $(KERN)

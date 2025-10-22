BUILD_DIR=build
BOOTLOADER=$(BUILD_DIR)/bootloader/bootloader.o
KERNEL=$(BUILD_DIR)/kernel/kernel
DISK_IMG=disk.img

all: bootdisk

.PHONY: bootdisk bootloader kernel

bootloader:
	make -C bootloader

kernel:
	make -C kernel

bootdisk: bootloader kernel
	dd if=/dev/zero of=$(DISK_IMG) bs=512 count=2880
	dd conv=notrunc if=$(BOOTLOADER) of=$(DISK_IMG) bs=512 count=1 seek=0
	dd conv=notrunc if=$(KERNEL) of=$(DISK_IMG) bs=512 count=$$(($(shell stat --printf="%s" $(KERNEL))/512)) seek=1

clean:
	make -C bootloader clean
	make -C kernel clean

qemu:
	qemu-system-i386 -machine q35 -fda $(DISK_IMG) -gdb tcp::26000 -S


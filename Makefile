ARCH=x86_64
ASM=nasm
CC=$(ARCH)-elf-gcc
CXX=$(ARCH)-elf-g++
LD=$(ARCH)-elf-ld
PWD=$(shell pwd)
SYSROOT=$(PWD)/root
DEST_DIR=$(SYSROOT)
export

.PHONY: all headers libs iso clean
all: kernel

kernel: headers libs
	@$(MAKE) -C kernel install-kernel

headers:
	@$(MAKE) -C kernel install-headers
	@$(MAKE) -C libc install-headers

libs:
	@$(MAKE) -C libc install-libs
	
run: iso
	qemu-system-x86_64 -cdrom lilac.iso

iso: kernel
	grub-mkrescue -o lilac.iso root

clean:
	-rm -rf root lilac.iso
	@$(MAKE) -C kernel clean
	@$(MAKE) -C libc clean


# all: $(KERNEL)
# $(KERNEL) : $(KERNEL_BUILD_DIR)/$(KERNEL).iso

# $(KERNEL_BUILD_DIR)/$(KERNEL).iso : $(KERNEL_BUILD_DIR)/$(KERNEL).bin
# 	cp $< $(KERNEL_ARCH_DIR)/iso/boot/kernel.bin
# 	grub-mkrescue /usr/lib/grub/i386-pc -o $@ $(KERNEL_ARCH_DIR)/iso
ARCH=x86_64
ASM=nasm
CC=$(ARCH)-elf-gcc
CXX=$(ARCH)-elf-g++
LD=$(ARCH)-elf-ld
PWD=$(shell pwd)
DEST_DIR=$(PWD)/root
INCLUDE_DIR=/usr/include
LIB_DIR=/usr/lib
export
MAKE:=$(MAKE) --no-print-directory

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
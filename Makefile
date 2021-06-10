# $(kernel_object_files): build/kernel/%.o : src/impl/kernel/%.c
# 	mkdir -p $(dir $@) && \
# 	x86_64-elf-gcc -c -I src/intf -ffreestanding $(patsubst build/kernel/%.o, src/impl/kernel/%.c, $@) -o $@

# $(x86_64_c_object_files): build/x86_64/%.o : src/impl/x86_64/%.c
# 	mkdir -p $(dir $@) && \
# 	x86_64-elf-gcc -c -I src/intf -ffreestanding $(patsubst build/x86_64/%.o, src/impl/x86_64/%.c, $@) -o $@

# $(x86_64_asm_object_files): build/x86_64/%.o : src/impl/x86_64/%.asm
# 	mkdir -p $(dir $@) && \
# 	nasm -f elf64 $(patsubst build/x86_64/%.o, src/impl/x86_64/%.asm, $@) -o $@

# .PHONY: all build-x86_64
# all: build-x86_64

# build-x86_64: $(kernel_object_files) $(x86_64_object_files)
# 	mkdir -p dist/x86_64 && \
# 	x86_64-elf-ld -n -o dist/x86_64/kernel.bin -T targets/x86_64/linker.ld $(kernel_object_files) $(x86_64_object_files) && \
# 	cp dist/x86_64/kernel.bin targets/x86_64/iso/boot/kernel.bin && \
# 	grub-mkrescue /usr/lib/grub/i386-pc -o dist/x86_64/kernel.iso targets/x86_64/iso

KERNEL=x86_64/kernel
KERNEL_BIN=$(KERNEL).bin
KERNEL_ISO=$(KERNEL).iso
BUILD_DIR=./build

ASM=nasm
CC=x86_64-elf-gcc
CXX=x86_64-elf-g++
LDD=x86_64-elf-ld

ASM_FLAGS=-felf64
C_FLAGS=-std=c99 -pipe -ffreestanding -Wall
CXX_FLAGS=-std=c++11 -pipe -ffreestanding -Wall

ASM_FILES=$(wildcard src/*/*/*.asm)
C_FILES=$(wildcard src/*/*.c)
CXX_FILES=$(wildcard src/*/*.cpp)

ASM_OBJ=$(ASM_FILES:%.asm=$(BUILD_DIR)/%.o)
CXX_OBJ=$(CXX_FILES:%.cpp=$(BUILD_DIR)/%.o)
C_OBJ=$(C_FILES:%.c=$(BUILD_DIR)/%.o)

OBJ=$(ASM_OBJ) $(CXX_OBJ) $(C_OBJ)

DEP=$(CXX_OBJ:%.o=%.d) $(C_OBJ:%.o=%.d)

INCLUDE=-I./include
LDFLAGS=

.PHONY: all clean

all: $(KERNEL)
$(KERNEL) : $(BUILD_DIR)/$(KERNEL_ISO)

$(BUILD_DIR)/$(KERNEL_ISO) : $(BUILD_DIR)/$(KERNEL_BIN)
	cp $< targets/x86_64/iso/boot/kernel.bin
	grub-mkrescue /usr/lib/grub/i386-pc -o $@ targets/x86_64/iso

$(BUILD_DIR)/$(KERNEL_BIN) : $(ASM_OBJ) $(CXX_OBJ) $(C_OBJ)
	mkdir -p $(@D)
	$(LD) -n -o $@ -T targets/x86_64/linker.ld $(OBJ)

-include $(DEP)

$(BUILD_DIR)/%.o : %.asm
	@mkdir -p $(@D)
	$(ASM) $(ASM_FLAGS) $< -o $@

$(BUILD_DIR)/%.o : %.c
	@mkdir -p $(@D)
	$(CC) $(C_FLAGS) $(INCLUDE) -MMD -c $< -o $@

$(BUILD_DIR)/%.o : %.cpp
	@mkdir -p $(@D)
	$(CXX) $(CXX_FLAGS) $(INCLUDE) -MMD -c $< -o $@

run: $(KERNEL)
	qemu-system-x86_64 -cdrom $(BUILD_DIR)/$(KERNEL_ISO)
clean:
	-rm -rf $(BIN) $(OBJ) $(DEP) $(BUILD_DIR)
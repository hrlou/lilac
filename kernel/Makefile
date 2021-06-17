DEST_DIR?=./root
INCLUDE_DIR?=/usr/include
LIB_DIR?=/usr/lib
ARCH?=x86_64
BUILD_DIR?=./build
ARCH_DIR=./arch/$(ARCH)
KERNEL=$(BUILD_DIR)/lilac.kernel

ASMFLAGS=-felf64
CFLAGS=-std=c11 -pipe -ffreestanding -Wall
CXXFLAGS=-std=c++17 -pipe -ffreestanding -Wall

ASMFILES=$(shell find . -type f -regex ".*\.asm")
CFILES=$(shell find . -type f -regex ".*\.c")
CXXFILES=$(shell find . -type f -regex ".*\.cpp")

OBJS=$(ASMFILES:%.asm=$(BUILD_DIR)/%.o) $(CFILES:%.c=$(BUILD_DIR)/%.o) $(CXXFILES:%.cpp=$(BUILD_DIR)/%.o)
INCLUDE=-I./include -I$(DEST_DIR)$(INCLUDE_DIR)
LDFLAGS=-L$(DEST_DIR)$(LIB_DIR) -lk

.PHONY: install clean

all: $(KERNEL)

$(KERNEL): $(OBJS)
	@mkdir -p $(@D)
	$(LD) -n -o $@ -T $(ARCH_DIR)/linker.ld $(OBJS) $(LDFLAGS)

$(BUILD_DIR)/%.o : %.asm
	@mkdir -p $(@D)
	$(ASM) $(ASMFLAGS) $< -o $@

$(BUILD_DIR)/%.o : %.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) $(INCLUDE) -MMD -c $< -o $@

$(BUILD_DIR)/%.o : %.cpp
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(INCLUDE) -MMD -c $< -o $@

install: install-headers install-kernel

install-headers:
	@mkdir -p $(DEST_DIR)$(INCLUDE_DIR)
	-cp -R --preserve=timestamps include/. $(DEST_DIR)$(INCLUDE_DIR)/.

install-kernel: $(KERNEL)
	@mkdir -p $(DEST_DIR)/boot
	-cp $< $(DEST_DIR)/boot/
	-cp -r $(ARCH_DIR)/grub $(DEST_DIR)/boot/

clean:
	-rm -rf $(BUILD_DIR)

-include $(CXXOBJS:%.o=%.d) $(COBJS:%.o=%.d)
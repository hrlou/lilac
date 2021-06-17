DEST_DIR?=./root
INCLUDE_DIR?=/usr/include
LIB_DIR?=/usr/lib
ARCH?=x86_64
BUILD_DIR?=./build

CFLAGS=-std=c11 -pipe -ffreestanding -Wall -Wextra -D__is_libk
CXXFLAGS=-std=c++17 -pipe -ffreestanding -Wall -D__is_libk

CFILES=$(shell find . -type f -regex ".*\.c")
CXXFILES=$(shell find . -type f -regex ".*\.cpp")

OBJS=$(CFILES:%.c=$(BUILD_DIR)/%.o) $(CXXFILES:%.cpp=$(BUILD_DIR)/%.o)

INCLUDE=-I./include -I$(DEST_DIR)$(INCLUDE_DIR)
BINARIES=libk.a

.PHONY: install clean

all: $(BINARIES)

libk.a: $(OBJS)
	$(AR) rcs $@ $(OBJS)

$(BUILD_DIR)/%.o : %.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) $(INCLUDE) -MMD -c $< -o $@

$(BUILD_DIR)/%.o : %.cpp
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(INCLUDE) -MMD -c $< -o $@

install: install-headers install-libs

install-headers:
	@mkdir -p $(DEST_DIR)$(INCLUDE_DIR)
	-cp -R --preserve=timestamps include/. $(DEST_DIR)$(INCLUDE_DIR)/.

install-libs: $(BINARIES)
	@mkdir -p $(DEST_DIR)/usr/lib
	-cp $(BINARIES) $(DEST_DIR)/usr/lib/.

clean:
	-rm -rf $(BUILD_DIR) *.a
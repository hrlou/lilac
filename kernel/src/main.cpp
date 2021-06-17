#include <kernel/kernel.hpp>
#include <kernel/vga.hpp>

#include <stdio.h>
#include <string.h>

void kernel_early_main(void) {
    vga::clear();
}

void kernel_main(void) {
    ::printf("Lilac Operating System");
}
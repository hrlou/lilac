#include <kernel/kernel.hpp>
#include <kernel/vga.hpp>
#include <kernel/tty.hpp>

void kernel_main(void) {
    // tty tty1;

    uint16_t buf[20];
    buf[0] = vga::entry('E');
    vga::eat_buffer(buf);
}
#pragma once

#include <kernel/vga.hpp>

class tty {
public:
    tty() = default;
    void clear_column(size_t col) {
        for (size_t i = 0; i <= t_width; i++) {

        }
    }
    void clear(void) {

    }
private:
    uint16_t* t_buffer;
    const size_t t_width = VGA_WIDTH;
    const size_t t_height = VGA_HEIGHT;
    size_t t_row = 0;
    size_t t_column = 0;
    vga::colour t_fg = vga::LIGHT_GRAY;
    vga::colour t_bg = vga::BLACK;
};
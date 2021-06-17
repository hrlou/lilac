#include <kernel/vga.hpp>

#include <string.h>

namespace vga {

static uint16_t* vga_buffer = (uint16_t*)VGA_ADDRESS;
static size_t vga_row = 0;
static size_t vga_column = 0;

static void advance_row(void) {
    vga_column = 0;
    if (vga_row++ == VGA_HEIGHT) {
        vga_row = 0;
    }
}

static void advance_column(void) {
    if (vga_column++ == VGA_WIDTH) {
        advance_row();
    }
}

uint8_t make_entry_colour(colour fg, colour bg) {
    return fg | bg << 4;
}

uint16_t make_entry(const unsigned char uch, colour fg, colour bg) {
    return (make_entry_colour(fg, bg) << 8) | uch;
}

uint16_t* buffer(void) {
    return vga_buffer;
}

void entry_insert(uint16_t entry, size_t x, size_t y) {
    vga_buffer[y * VGA_WIDTH + x] = entry;
}

void entry_write(uint16_t entry) {
    entry_insert(entry, vga_column, vga_row);
    advance_column();
}

void clear(void) {
    vga_row = vga_column = 0;
    // ::memset(vga_buffer, (uint16_t)make_entry(' ', BLACK, WHITE), VGA_BUFSIZE * sizeof(uint16_t));
    do {
        entry_write(make_entry(' '));
    } while (!(vga_row == 0 && vga_column == 0));
}

void write(const char* s, size_t l) {
    for (; *s && l != 0; s++, l--) {
        if (*s == '\n') {
            advance_row();
        } else {
            entry_write(make_entry(*s));
        }
    }
}

}
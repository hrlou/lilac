#pragma once

#include <stddef.h>
#include <stdint.h>

#define VGA_WIDTH 80
#define VGA_HEIGHT 25
#define VGA_BUFSIZE VGA_WIDTH * VGA_HEIGHT
#define VGA_ADDRESS (uint16_t*)(0xB8000)

namespace vga {

enum colour : uint8_t {
    BLACK = 0,
    BLUE = 1,
    GREEN = 2,
    CYAN = 3,
    RED = 4,
    MAGENTA = 5,
    BROWN = 6,
    LIGHT_GRAY = 7,
    DARK_GRAY = 8,
    LIGHT_BLUE = 9,
    LIGHT_GREEN = 10,
    LIGHT_CYAN = 11,
    LIGHT_RED = 12,
    PINK = 13,
    YELLOW = 14,
    WHITE = 15,
};

uint8_t entry_colour(colour fg, colour bg);
uint16_t entry(unsigned char uch, colour fg = LIGHT_GRAY, colour bg = BLACK);
void eat_buffer(uint16_t* buffer);
uint16_t* buffer(void);

}
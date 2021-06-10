#include <kernel/vga.hpp>

namespace vga {

static uint16_t* _buffer = VGA_ADDRESS;

uint8_t entry_colour(colour fg, colour bg) {
    return fg | bg << 4;
}

uint16_t entry(const unsigned char uch, colour fg, colour bg) {
    return (entry_colour(fg, bg) << 8) | uch;
}

void eat_buffer(uint16_t* buffer) {
    // _buffer = buffer;
    for (auto i : )

    /*for (size_t i = 0; i <= 10; i++) {
        _buffer[i] = entry('a', BLACK, WHITE);
    }*/
}

uint16_t* buffer(void) {
    return _buffer;
}

}
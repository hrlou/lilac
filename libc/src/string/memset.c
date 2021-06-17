#include <string.h>

void* memset(void* dest, int c, size_t n) {
    unsigned char* buf = (unsigned char*)dest;
    for (size_t i = 0; i < n; i++) {
        buf[i] = (unsigned char)c;
    }
    return dest;
}
#include <stdint.h>
#include "registry.h"
#include "vga.h"

int kernel_main() {
    for (int i = 0; i < 512; i++) {
        registry[i] = 0;
    }
    for (int i = 0; i < 80*25; i++) {
        video_memory[i] = 0;
    }
    puts("mine turtle, HELLO!",0x0c);
    cursor2d_t cursor = get_cursor_2d(registry[0]);
    cursor.row += 2;
    set_cursor_2d(cursor);
    return 0;
}
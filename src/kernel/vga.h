#pragma once

#include <stdint.h>
#include "io.h"
#include "registry.h"

#define VGA_CTRL_REGISTER 0x3d4
#define VGA_DATA_REGISTER 0x3d5
#define VGA_OFFSET_LOW 0x0f
#define VGA_OFFSET_HIGH 0x0e

uint16_t* video_memory = (uint16_t*)0xb8000;

typedef struct {
    uint8_t row;
    uint8_t column;
} cursor2d_t;

void update_hardware_cursor() {
    outb(VGA_CTRL_REGISTER, VGA_OFFSET_HIGH);
    outb(VGA_DATA_REGISTER, (unsigned char) (registry[0] >> 8));
    outb(VGA_CTRL_REGISTER, VGA_OFFSET_LOW);
    outb(VGA_DATA_REGISTER, (unsigned char) (registry[0] & 0xff));
}

cursor2d_t init_cursor(uint8_t row, uint8_t column) {
    cursor2d_t out;
    out.row = row;
    out.column = column;
    return out;
}

cursor2d_t get_cursor_2d(uint32_t cursor) {
    return init_cursor((cursor-cursor%80)/80,cursor%80);
}

void set_cursor_format(uint8_t formatting) {
    video_memory[registry[0]] = (video_memory[registry[0]] & 0x00ff) | (formatting << 8);
}

void set_cursor_1d(uint16_t cursor_dest) {
    registry[0] = cursor_dest;
    set_cursor_format(registry[1]);
    update_hardware_cursor();
}

void set_cursor_2d(cursor2d_t cursor_dest) {
    uint32_t offset;
    offset = (cursor_dest.row*80) + cursor_dest.column;
    set_cursor_1d(offset);
}

void putc(char character, uint8_t formatting) {
    volatile uint16_t* video_memory = (uint16_t*)0xb8000;
    video_memory[registry[0]] = (formatting << 8) | character;
    registry[0]++;
    set_cursor_format(formatting);
    update_hardware_cursor();
    registry[1] = formatting;
}

void puts(char* string, uint8_t formatting) {
    volatile uint32_t x = 0;

    while (string[x] != '\0') {
        putc(string[x],formatting);
        x++;
    }
}
; bootloader
; 3/14/25 Notoriginal

org 0x7c00
bits 16

_start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov gs, ax
    mov ss, ax
    mov sp, 0x7c00

    mov ax, 0xb800
    mov fs, ax

    mov ah, 0x00
    mov al, 0x03
    int 0x10

    mov ah, 0x02
    mov al, 4
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov bx, 0x7e00
    int 0x13

    cli

    lgdt [gdt_ptr]
    mov eax, cr0
    or eax, 1
    mov cr0, eax

    jmp 0x08:_32bit

    jmp $

bits 32
_32bit:
    cli
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, 0x90000
    
    call 0x7e00

    jmp $

%include "src/boot/gdt.asm"

times 510-($-$$) db 0
dw 0xaa55
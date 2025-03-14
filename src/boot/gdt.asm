gdt_start:
    ; null descriptor (entry 0) - not used, but required
    dq 0x0000000000000000
    
    ; code segment descriptor (entry 1)
    dq 0x00CF9A000000FFFF
    
    ; data segment descriptor (entry 2)
    dq 0x00CF92000000FFFF

gdt_end:

gdt_ptr:
    dw gdt_end - gdt_start - 1      ; limit
    dd gdt_start                    ; base address
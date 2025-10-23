; cli, lgdt, far jump, reset the CS, load other segment registers

[GLOBAL gdt_load]

gdt_load:
    mov eax, [esp + 4] ; gdt_ptr->base
    lgdt [eax]

    ; we reload the DS, SS, ES, FS, and GS with the offset of data segment
    ; data segment is at index 2, each entry is 8 bytes large, so the offset is 0x10.
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    ; We're done, let's jump to the code segment
    jmp 0x08:.reload_cs

.reload_cs:
    ret


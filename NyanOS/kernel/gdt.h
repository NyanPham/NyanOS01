// Define GDT entry struct and encodeGDTEntry function prototype

#ifndef GDT_H
#define GDT_H

#include <stdint.h>

// a precise memory layout of an 8-byte GDT entry
struct gdt_entry_strct {
    uint16_t limit_low;     // +4 lower bits of granularity-> 20 bits of segment limit (size)
    uint16_t base_low;
    uint8_t base_mid;
    uint8_t access;         // flags to determine seg's type(Code/Data), privilege level (ring 0-3), read/write permission 
    uint8_t granularity;    // flags for Granularity(G), Default Operand/Stack Ptr size, Long mode
    uint8_t base_high;      // base_low + mid + high -> 32 bits of base addr of segment
} __attribute__((packed));

// a 6-byte struct that `lgdt` asm insn expects
struct gdt_ptr_strct {
    uint16_t limit;
    uint32_t base;
} __attribute__((packed));

// execute lgdt insn, and reload seg registers
extern void gdt_load(uint32_t gdt_ptr_addr);

void gdt_init();

#endif

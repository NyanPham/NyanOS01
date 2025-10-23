// Definition of the GDT table and implementation of encodeGDTEntry

#include "gdt.h"

#define GDT_ENTRIES 3 // We have 3 entries (null descriptor, Code, and Data)

struct gdt_entry_strct gdt_entries[GDT_ENTRIES];

struct gdt_ptr_strct gdt_ptr;

static void gdt_set_entry(int num, uint32_t base, uint32_t limit, uint8_t access, uint8_t gran) 
{
    gdt_entries[num].base_low = base & 0xFFFF;
    gdt_entries[num].base_mid = (base >> 16) & 0xFF;
    gdt_entries[num].base_high = (base >> 24) & 0xFF;

    gdt_entries[num].limit_low = limit & 0xFFFF;
    gdt_entries[num].granularity = ((limit >> 16) & 0x0F);
    gdt_entries[num].granularity |= gran & 0xF0;

    gdt_entries[num].access = access;
}

void gdt_init() 
{
    // set up the GDT ptr
    gdt_ptr.limit = (sizeof(struct gdt_entry_strct) * GDT_ENTRIES) - 1;
    gdt_ptr.base = (uint32_t)&gdt_entries;

    // set up the GDT entries for a flat 4GB memory model
    gdt_set_entry(0, 0, 0, 0, 0); // null segment
    gdt_set_entry(1, 0, 0xFFFFFFFF, 0x9A, 0xCF);    // Data segment, ring 0, exe/read
    gdt_set_entry(2, 0, 0xFFFFFFFF, 0x92, 0xCF);    // Data setment, ring 0, exe/write
                                                    
    gdt_load((uint32_t)&gdt_ptr);
}

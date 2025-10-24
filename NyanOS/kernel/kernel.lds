ENTRY(_start);

PHDRS
{
    code PT_LOAD FLAGS(rx); 
}

SECTIONS
{
    .text 0x2000: ALIGN(0x1000) { *(.text) } :code
    .data : { *(.data) }
    .bss : { *(.bss) } 
    /DISCARD/ : { * (.eh_frame) }
}

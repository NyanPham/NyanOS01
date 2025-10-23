ENTRY(main);

PHDRS
{
    code PT_LOAD FLAGS(rx); 
}

SECTIONS
{
    .text 0x8000: ALIGN(0x1000) { *(.text) } :code
    .data : { *(.data) }
    .bss : { *(.bss) } 
    /DISCARD/ : { * (.eh_frame) }
}

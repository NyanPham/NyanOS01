ENTRY(main);

PHDRS
{
    code PT_LOAD FLAGS(rx); 
}

SECTIONS
{
    .text 0x600: ALIGN(0x100) { *(.text) } :code
    .data : { *(.data) }
    .bss : { *(.bss) } 
    /DISCARD/ : { * (.eh_frame) }
}

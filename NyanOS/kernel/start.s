section .text
extern main
global _start
_start:
    mov esp, stack_top
    call main
    hlt


section .bss
align 16
stack_bottom:
    resb 4096
stack_top:

;********************************************
; bootloader.asm
; A Simple Bootloader
;********************************************
org 0x7c00
bits 16
starts: jmp boot

;; constant and variable definitions
msg db "Welcome to NyanOS!", 0ah, 0dh, 0h

boot:
	cli ; no interrupts
	cld ; all that we need to init
   
    mov bh, 14
    mov bl, 24
    call MovCursor

    mov si, msg
    call Print

	hlt ; halt the system

%include "io.asm"

; We have to be 512 bytes. Clear the rest of the bytes with 0
times 510 - ($-$$) db 0
dw 0xAA55



;********************************************
; bootloader.asm
; A Simple Bootloader
;********************************************
bits 16
start: jmp boot

;; constant and variable definitions
welcome_msg db "Welcome to NyanOS!", 0ah, 0dh, 0h
err_msg db "E", 0h

boot:
	cli ; no interrupts
	cld ; all that we need to init
    
    mov bh, 0xe
    mov bl, 0x18
    call MovCursor
    
    mov si, welcome_msg
    call Print

    mov ax, 0x100

    ;; set the buffer at es:bx (0x50:0x0)
    mov es, ax  
    xor bx, bx
    
    mov al, 18  ; read 18 sectors
    mov ch, 0   ; track 0
    mov cl, 2   ; sector to start reading (from the second sector)
    mov dh, 0   ; head number
    mov dl, 0   ; drive number

    mov ah, 0x02    ;read sectors from disk 
    int 0x13    ; call the BIOS routine
    
    jc .disk_err    ; failed to read disk

    jmp [0x1000 + 0x18]   ; jump and execute the sector!
    
.disk_err:
    mov bh, 0xf
    mov bl, 0x15
    call MovCursor

    mov si, err_msg
    call Print
    
	hlt ; halt the system

%include "io.asm"

; We have to be 512 bytes. Clear the rest of the bytes with 0
times 510 - ($-$$) db 0
dw 0xAA55



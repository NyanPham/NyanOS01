;============================================
; constants and variables
;============================================
cursor_x db 0
cursor_y db 0


;============================================
; MovCursor
; Move a cursor to a specific location on 
; screen and remember this location.
; 
; Params:
; - bh = y coord
; - bl = x coord
;
; Return: none
;============================================

MovCursor:
    mov dl, bl
    mov dh, bh
    mov [cursor_x], bl
    mov [cursor_y], bh
    mov ah, 0x2
    mov bh, 0x0
    int 0x10
    ret


;============================================
; PutChar
; Print a character on screen, at the cursor 
; position previously set by MovCursor.
; 
; Params:
; - al = char to print
; - bl = text color
; - cx = char repeat times
;
; Return: none
;============================================
PutChar:
    mov ah, 0x9
    mov bh, 0x0
    int 0x10
    
    add [cursor_x], cx
    mov bh, [cursor_y]
    mov bl, [cursor_x]
    call MovCursor
    ret

;============================================
; Print
; Print a string
;
; Params:
; - ds:si = null terminated string
;
; Return: none
;============================================
Print:
.nxt_char:
    lodsb
    test al, al
    jz .done
    mov bl, 0x7
    mov cx, 1
    call PutChar
    jmp .nxt_char
.done:
    ret

;==========================================
; nasmw boot.asm -f bin -o boot.bin
; partcopy boot.bin 0 200 -f0
[bits 16]
[ORG 0x7c00]      ; add to offsets
   jmp start

   %include "print.inc"

start:   
  xor ax, ax   ; make it zero
   mov ds, ax   ; DS=0
   mov ss, ax   ; stack starts at 0
   mov sp, 0x7bff

   mov ax, 0xb800   ; text video memory
   mov es, ax

  mov si, msg_loading
  call sprint

  mov ax, 0x0000
  mov es, ax

  mov ah, 0x02
  mov al, 10
  mov ch, 0
  mov cl, 2
  mov dh, 0
  mov dl, 0x80
  mov bx, 0x8000
  int 0x13
  jc disk_error

  jmp 0x0000:0x8000

disk_error:
   mov si, msg_error
   call sprint
   jmp $

msg_loading db "LOADING KERNEL.....", 13, 10, 0
msg_found db "KERNEL FOUND", 13, 10, 0
msg_error db "DISK ERROR", 13, 10, 0

times 510-($-$$) db 0
dw 0xAA55

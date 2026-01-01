[bits 16]
section .text
global start_kernel
start_kernel:
  jmp _kernel
%include "boot/print.inc"
%include "boot/gdt.inc"
%include "boot/a20line.asm"
_kernel:
  mov sp, 0x8bff
  mov ax, 0xb800
  mov es, ax
  mov si, kernel_loaded_msg
  call sprint
  jmp enter_pm

enter_pm:
  cli
  call check_a20
  cmp ax, 1
  jne a20_off

  mov si, a20_on_msg
  call sprint

  lgdt[gdt_descriptor]
  mov eax, cr0
  or al, 1
  mov cr0, eax

  jmp 0x8:protected_mode

a20_off: 
   mov si, a20_off_msg
   call sprint
   mov si, enabling_a20_msg
   call sprint
   in al, 0x92
   or al, 2
   out 0x92, al
   jmp enter_pm

msg_enter_pm  db "ENTERING PROTECTED MODE", 13, 10, 0
a20_on_msg  db "A20 LINE IS ENABLED", 13, 10, 0
a20_off_msg    db "A20 LINE IS DISABLED", 13, 10, 0
protected_mode_enabled db "PROTECTED MODE IS ENABLED", 13, 10, 0
enabling_a20_msg db "ENABLING A20 LINE", 13, 10, 0
kernel_loaded_msg db "KERNEL LOADED!", 13, 10, 0

[bits 32]
extern kernel_main
protected_mode:
  mov ax, 0x10
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov ss, ax
  mov esp, 0x200000


  mov edi, 0xb8000
  mov ah, 0x4f
  add edi, 640

  mov al, 'P'
  mov [edi], ax
  add edi, 2
  mov al, 'R'
  mov [edi], ax
  add edi, 2
  mov al, 'O'
  mov [edi], ax
  add edi, 2
  mov al, 'T'
  mov [edi], ax
  add edi, 2
  mov al, 'E'
  mov [edi], ax
  add edi, 2
  mov al, 'C'
  mov [edi], ax
  add edi, 2
  mov al, 'T'
  mov [edi], ax
  add edi, 2
  mov al, 'E'
  mov [edi], ax
  add edi, 2
  mov al, 'D'
  mov [edi], ax
  add edi, 2

  call kernel_main
  
forever_young:
  jmp forever_young

;==========================================


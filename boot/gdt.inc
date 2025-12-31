[bits 16]

gdt_descriptor:
  dw gdt_end - gdt_start - 1
  dd gdt_start

gdt_start:
gdt_null: dq 0
gdt_code: dq 0x00CF9A000000FFFF
gdt_data: dq 0x00CF92000000FFFF
gdt_end:

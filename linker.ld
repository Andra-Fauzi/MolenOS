/* Output Flat Binary */
OUTPUT_FORMAT("binary")

/* entry point */
ENTRY(start_kernel)

SECTIONS {
  . = 0x8000;

  .text : AT(0x8000)
  {
    kernel.o(.text)
    *(.text)
  }

  .rodata : 
  {
    *(.rodata)
  }

  .data :
  {
    *(.data)
  }

  .bss :
  {
    *(.bss)
  }
}

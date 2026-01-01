void kernel_main(void) {

  unsigned short *VGA_MEMORY = (unsigned short *)0xB8000;

  char *halo = "andra fauzi";

  *(VGA_MEMORY) = (0x0F << 8) | 'A';
  *(VGA_MEMORY + 1) = (0x0F << 8) | 'N';
  *(VGA_MEMORY + 2) = (0x0F << 8) | 'D';
  *(VGA_MEMORY + 3) = (0x0F << 8) | 'R';
  *(VGA_MEMORY + 4) = (0x0F << 8) | 'A';
  return;

}

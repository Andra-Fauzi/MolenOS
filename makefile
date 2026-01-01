all:
	nasm boot/boot.asm -f bin -o boot.bin
	nasm -f elf32 boot/kernel.asm -o kernel.o
	x86_64-elf-gcc -m32 -ffreestanding -c kernel/main.c -o main.o
	x86_64-elf-ld -m elf_i386 -T linker.ld kernel.o main.o -o kernel.bin
	# bikin disk
	dd if=/dev/zero of=disk.img bs=512 count=2880
	# tulis 512 byte pertama (sector 1)
	dd if=boot.bin of=disk.img bs=512 count=1 conv=notrunc
	# tulis kernel nya 
	dd if=kernel.bin of=disk.img bs=512 seek=1 conv=notrunc
	qemu-system-i386 -drive format=raw,file=disk.img -monitor stdio


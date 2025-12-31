all:
	nasm boot.asm -f bin -o boot.bin
	nasm kernel.asm -f bin -o kernel.bin
	dd if=/dev/zero of=disk.img bs=512 count=2880
	dd if=boot.bin of=disk.img bs=512 count=1 conv=notrunc
	# tulis 512 byte pertama (sector 1)
	dd if=kernel.bin of=disk.img bs=512 seek=1 conv=notrunc


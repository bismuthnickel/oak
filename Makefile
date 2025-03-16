DUMPcmd:=objdump
DUMPflags:=-D -Mintel,i80386 -b binary -m i386 

.PHONY: all default test run debug mega dump clean

default: test

all:
	mkdir -p build/
	
	nasm src/boot/boot.asm -f bin -o build/boot.bin
	
	nasm src/kernel/entry.asm -f elf32 -o build/entry.o
	gcc -e main -ffreestanding -m32 -nostdlib -fno-pie -fno-pic -c src/kernel/kernel.c -o build/kernel.o
	
	ld -m elf_i386 -nostdlib -Tlinker.ld build/entry.o build/kernel.o -o build/kernel.bin
	
	cat build/boot.bin build/kernel.bin > oak.img
	truncate -s 1440k oak.img

test: all run

run:
	qemu-system-x86_64 -drive file=oak.img,if=floppy,format=raw -name oak

debug: all dump

dump:
	$(DUMPcmd) $(DUMPflags) build/kernel.bin

mega: all dump run clean

clean:
	rm -rf build
	rm -f oak.img
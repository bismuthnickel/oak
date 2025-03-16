DUMPcmd:=objdump
DUMPflagsS:=-Mintel,i80386 -m i386
DUMPflagsI:=-D -b binary $(DUMPflagsS)
DUMPflagsi:=-d $(DUMPflagsS)

.PHONY: all default test run debug mega dump clean

default: test

all:
	mkdir -p build/
	
	nasm src/boot/boot.asm -O0 -f bin -o build/boot.bin
	
	nasm src/kernel/entry.asm -O0 -f elf32 -o build/entry.o
	gcc -O0 -e main -ffreestanding -m32 -nostdlib -fno-pie -fno-pic -c src/kernel/kernel.c -o build/kernel.o
	
	ld -m elf_i386 -nostdlib -Tlinker.ld build/entry.o build/kernel.o -o build/kernel.bin
	
	cat build/boot.bin build/kernel.bin > oak.img
	truncate -s 1440k oak.img

test: all run

run:
	qemu-system-x86_64 -drive file=oak.img,if=floppy,format=raw -name oak

debug: all dumpind

dumpimg:
	$(DUMPcmd) $(DUMPflagsI) build/kernel.bin

dumpind:
	$(DUMPcmd) $(DUMPflagsi) -d build/*.o

mega: all dump run clean

clean:
	rm -rf build
	rm -f oak.img
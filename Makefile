ASM=yasm
ASFLAGS=-f bin -a x86
DD="dd"
DDFLAGS=conv=notrunc bs=512 count=1
QEMU=qemu-system-i386
all: cleanup run
bootldr.bin:
	$(ASM) $(ASFLAGS) -o $@ bootldr.asm
bootldr.flp: bootldr.bin
	$(DD) $(DDFLAGS) if=$? of=$@
run: bootldr.flp
	$(QEMU) -fda $?
cleanup:
	$(RM) *.flp *.bin

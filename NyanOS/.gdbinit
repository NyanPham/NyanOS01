define hook-stop
    # Translate the segment:offset into a physical address
    printf "[%4x:%4x] ", $cs, $eip
    x/i $cs*16+$eip
end

set disassembly-flavor intel
layout asm
layout reg
set architecture i8086
target remote localhost:26000
b *0x7c00
symbol-file build/kernel/kernel 
b *_start
commands
    silent
    set architecture i386 
    define hook-stop
    end
    printf "GDB switched to 32-bit protected mode"
    x/10i $eip
end

b *main

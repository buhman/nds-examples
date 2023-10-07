OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
OUTPUT_ARCH(arm)
MEMORY
{
  rom : ORIGIN = 0x00000000, LENGTH = 256K
  ram : ORIGIN = 0x02000000, LENGTH = 256K
}
SECTIONS
{
  . = 0x00000000;

  .text.header ALIGN(4) : SUBALIGN(4)
  {
    KEEP(*(.text.header))
  } > rom AT> rom

  . = 0x02000000;

  .text.arm7 ALIGN(4) : SUBALIGN(4)
  {
    KEEP(*(.text.7start))
  } > ram AT> rom

  .text.arm9 ALIGN(4) : SUBALIGN(4)
  {
    KEEP(*(.text.9start))
  } > ram AT> rom

  .text ALIGN(4) : SUBALIGN(4)
  {
    *(.text)
    *(.text.*)
  } > ram AT> rom

  .data ALIGN(4) : SUBALIGN(4)
  {
    *(.data)
    *(.data.*)
  } > ram AT> rom

  .rodata ALIGN(4) : SUBALIGN(4)
  {
    *(.rodata)
    *(.rodata.*)
  } > ram AT> rom

  .ctors ALIGN(4) : SUBALIGN(4)
  {
    KEEP(*(.ctors))
    KEEP(*(.ctors.*))
  } > ram AT> rom

  .bss ALIGN(4) (NOLOAD) : SUBALIGN(4)
  {
    *(.bss)
    *(.bss.*)
  } > ram AT> rom

  __bss_link_start = ADDR(.bss);
  __bss_link_end = ADDR(.bss) + SIZEOF(.bss);

  __ctors_link_start = ADDR(.ctors);
  __ctors_link_end = ADDR(.ctors) + SIZEOF(.ctors);
}

_arm9_offset = LOADADDR(.text.arm9);
_arm9_entry = ADDR(.text.arm9);
_arm9_addr = ADDR(.text.arm9);
_arm9_size = SIZEOF(.text.arm9) + SIZEOF(.text) + SIZEOF(.data) + SIZEOF(.rodata) + SIZEOF(.ctors) + SIZEOF(.bss);

_arm7_offset = LOADADDR(.text.arm7);
_arm7_entry = ADDR(.text.arm7);
_arm7_addr = ADDR(.text.arm7);
_arm7_size = SIZEOF(.text.arm7);

_rom_size = SIZEOF(.text.header) + SIZEOF(.text.arm9) + SIZEOF(.text.arm7);
_header_size = SIZEOF(.text.header);

OUTPUT_ARCH( "riscv" )
ENTRY( _start )
SECTIONS
{
  RAM_START = DEFINED(RAM_START) ? RAM_START : 0x80000000;
  STACK_SIZE = DEFINED(STACK_SIZE) ? STACK_SIZE : 0x1000;
  PAGE_SIZE = 0x1000;

  /* text: test code section */
  . = DEFINED(ROM_START) ? ROM_START : RAM_START;
  .text : { *(.text) }

  .user_text RAM_START + 0x1000 : { *(.user_text) }
  . += PAGE_SIZE;

  /* data: Initialized data segment */
  .rodata : { *(.rodata) }
  /* build-id: Store after readonly data */
  build_id = .;
  .gnu_build_id : { *(.note.gnu.build-id) }
  . = DEFINED(ROM_START) ? RAM_START : .;
  .data : { *(.data) }
  .sdata : { *(.sdata) }
  .debug : { *(.debug) }
  stack_bottom = .;
  . += STACK_SIZE;
  stack_top = .;

  /* End of uninitialized data segment */
  _end = .;
}

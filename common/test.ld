/*======================================================================*/
/* Proxy kernel linker script                                           */
/*======================================================================*/
/* This is the linker script used when building the proxy kernel. */

/*----------------------------------------------------------------------*/
/* Setup                                                                */
/*----------------------------------------------------------------------*/

/* The OUTPUT_ARCH command specifies the machine architecture where the
   argument is one of the names used in the BFD library. More
   specifically one of the entires in bfd/cpu-mips.c */

OUTPUT_ARCH( "riscv" )

/* The ENTRY command specifies the entry point (ie. first instruction
   to execute). The symbol _start should be defined in each test. */

ENTRY( _start )

/*----------------------------------------------------------------------*/
/* Sections                                                             */
/*----------------------------------------------------------------------*/

SECTIONS
{

  /* text: test code section */
  . = 0x00002000;
  .text : 
  {
    crt.o(.text)
    *(.text)
  }

  /* data segmemt */
  .data : { *(.data) }
  .bss : { *(.bss) }

  /* thread-local data segment */
  .tdata :
  {
    _tls_data = .;
    crt.o(.tdata.begin)
    *(.tdata)
    crt.o(.tdata.end)
  }
  .tbss :
  {
    *(.tbss)
    crt.o(.tbss.end)
  }

  /* End of uninitalized data segement */
  _end = .;
}


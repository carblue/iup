/** \file
 * \brief IUP driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cdiup;

version(CD) :
version(DigitalMars) { pragma(lib, "iupcd"); }

import cd.cd : cdContext;

extern(C) @nogc nothrow :

/* NOTICE: implementation done in IUP at the IUPCD library. 
   Only this file is at the CD files. */

cdContext* cdContextIup();
cdContext* cdContextIupDBuffer();
cdContext* cdContextIupDBufferRGB();
alias CD_IUP           = cdContextIup;
alias CD_IUPDBUFFER    = cdContextIupDBuffer;
alias CD_IUPDBUFFERRGB = cdContextIupDBufferRGB;

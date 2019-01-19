/** \file
 * \brief IUP driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cdiup;

version(CD) :

import cd.cd : cdContext;

version(DigitalMars) version(Windows) { pragma(lib, "iupcd.lib"); } // even without version=CD, libiupcd.so (depending on libcd.so) is used anyway as libiupcontrols.so depends on it

extern(C) @nogc nothrow :

/* NOTICE: implemented in IUP at the IUPCD library.
   Only this file is at the CD includes. */

cdContext* cdContextIup();  // even with version=CD defined, cdContext* may not be dereferenced, as it is known only via (non-published) cd_private.d
cdContext* cdContextIupDBuffer();
cdContext* cdContextIupDBufferRGB();
alias CD_IUP           = cdContextIup;
alias CD_IUPDBUFFER    = cdContextIupDBuffer;
alias CD_IUPDBUFFERRGB = cdContextIupDBufferRGB;

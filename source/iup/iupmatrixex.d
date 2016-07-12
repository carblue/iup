/** \file
 * \brief IupMatrix Expansion Library.
 *
 * See Copyright Notice in "iup.h"
 */
 
module iup.iupmatrixex;

import iup.iup : Ihandle;

version(DigitalMars) version(Windows) { pragma(lib, "iupmatrixex.lib"); } // libiupmatrixex.so depends on libiup.so,...

extern(C) @nogc nothrow :

void IupMatrixExOpen();

Ihandle* IupMatrixEx();

void IupMatrixExInit(Ihandle* ih);

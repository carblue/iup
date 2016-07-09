/** \file
 * \brief IupMatrix Expansion Library.
 *
 * See Copyright Notice in "iup.h"
 */
 
module iup.iupmatrixex;
version(DigitalMars) { pragma(lib, "iupmatrixex"); }

import iup.iup : Ihandle;

extern(C) @nogc nothrow :

void IupMatrixExOpen();

Ihandle* IupMatrixEx();

void IupMatrixExInit(Ihandle* ih);

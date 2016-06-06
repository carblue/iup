/** \file
 * \brief Ole control.
 *
 * See Copyright Notice in "iup.h"
 */

module iup.iupole;

import iup.iup : Ihandle;

extern(C) @nogc nothrow :

Ihandle* IupOleControl(const(char)* progid);

int IupOleControlOpen();

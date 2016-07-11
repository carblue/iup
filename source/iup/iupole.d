/** \file
 * \brief Ole control.
 *
 * See Copyright Notice in "iup.h"
 */

module iup.iupole;

version(Windows) :

import iup.iup : Ihandle;

version(DigitalMars) { pragma(lib, "iupole.lib"); }

extern(C) @nogc nothrow :

Ihandle* IupOleControl(const(char)* progid);

int IupOleControlOpen();

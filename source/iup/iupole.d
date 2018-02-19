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

Ihandle* IupOleControl(const(char)* progid); /// See_Also: https://webserver2.tecgraf.puc-rio.br/iup/en/ctrl/iupole.html

int IupOleControlOpen(); /// See_Also: https://webserver2.tecgraf.puc-rio.br/iup/en/ctrl/iupole.html

/** \file
 * \brief Web control.
 *
 * See Copyright Notice in "iup.d"
 */

module iup.iupweb;

import iup.iup : Ihandle;

version(DigitalMars) version(Windows)
{
/*version(Posix)		pragma(lib, "libiupweb.so"); */
/*version(Windows)*/	pragma(lib, "iupole.lib");
}

extern(C) @nogc nothrow :

int IupWebBrowserOpen(); // where on Windows?

Ihandle* IupWebBrowser();

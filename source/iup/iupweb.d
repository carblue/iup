/** \file
 * \brief Web control.
 *
 * See Copyright Notice in "iup.d"
 */

/* Read about IupWebBrowser in the documentation, if it is available for Your platform */

module iup.iupweb;

import iup.iup : Ihandle;

version(DigitalMars) version(Windows)
{
/*version(Posix)		pragma(lib, "libiupweb.so"); // requires WebKitGTK+ installation */
/*version(Windows)*/	pragma(lib, "iupole.lib");
}

extern(C) @nogc nothrow :

int IupWebBrowserOpen();  /// See_Also: https://webserver2.tecgraf.puc-rio.br/iup/en/ctrl/iupweb.html

Ihandle* IupWebBrowser(); /// See_Also: https://webserver2.tecgraf.puc-rio.br/iup/en/ctrl/iupweb.html

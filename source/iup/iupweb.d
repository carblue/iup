/** \file
 * \brief Web control.
 *
 * See Copyright Notice in "iup.d"
 */


module iup.iupweb;

import iup.iup : Ihandle;

/* Read about IupWebBrowser in the documentation, if it is available for Your platform */
/*
version(Posix)      pragma(lib, "libiupweb.so"); // requires WebKitGTK+ installation, e.g. Ubuntu package libwebkitgtk-3.0-dev
version(Windows)    pragma(lib, "iupweb.lib");
version(Windows)    pragma(lib, "iupole.lib");
*/

extern(C) @nogc nothrow :

int IupWebBrowserOpen();  /// See_Also: https://webserver2.tecgraf.puc-rio.br/iup/en/ctrl/iupweb.html

Ihandle* IupWebBrowser(); /// See_Also: https://webserver2.tecgraf.puc-rio.br/iup/en/ctrl/iupweb.html

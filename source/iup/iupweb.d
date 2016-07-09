/** \file
 * \brief Web control.
 *
 * See Copyright Notice in "iup.d"
 */

module iup.iupweb;
version(DigitalMars)
{
version(Posix)		pragma(lib, "iupweb"); 
//version(Windows)	pragma(lib, "iupole"); 
}

import iup.iup : Ihandle;

extern(C) @nogc nothrow :

int IupWebBrowserOpen(); // where on Windows?

Ihandle* IupWebBrowser();

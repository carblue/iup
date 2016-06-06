/** \file
 * \brief Web control.
 *
 * See Copyright Notice in "iup.d"
 */

module iup.iupweb;

import iup.iup : Ihandle;

extern(C) @nogc nothrow :

int IupWebBrowserOpen();

Ihandle* IupWebBrowser();

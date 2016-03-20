/** \file
 * \brief Web control.
 *
 * See Copyright Notice in "iup.d"
 */

module iup.iupweb;

import iup.iup : Ihandle;

extern(C) :

int IupWebBrowserOpen();

Ihandle* IupWebBrowser();

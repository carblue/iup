/** \file
 * \brief IupTuioClient control
 *
 * See Copyright Notice in "iup.d"
 */

module iup.iuptuio;

import iup.iup : Ihandle;

//version(Posix)      pragma(lib, "libiuptuio.so");
//version(Windows)    pragma(lib, "iuptuio.lib");

extern(C) @nogc nothrow :

int IupTuioOpen();                /// See_Also: https://webserver2.tecgraf.puc-rio.br/iup/en/ctrl/iuptuio.html
Ihandle* IupTuioClient(int port); /// See_Also: https://webserver2.tecgraf.puc-rio.br/iup/en/ctrl/iuptuio.html

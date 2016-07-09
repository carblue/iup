/** \file
 * \brief IupTuioClient control
 *
 * See Copyright Notice in "iup.d"
 */

module iup.iuptuio;
version(DigitalMars) { pragma(lib, "iuptuio"); }

import iup.iup : Ihandle;

extern(C) @nogc nothrow :

int IupTuioOpen();
Ihandle* IupTuioClient(int port);

/** \file
 * \brief IupTuioClient control
 *
 * See Copyright Notice in "iup.d"
 */

module iup.iuptuio;

import iup.iup : Ihandle;

version(DigitalMars) version(Windows) { pragma(lib, "iuptuio.lib"); }

extern(C) @nogc nothrow :

int IupTuioOpen();
Ihandle* IupTuioClient(int port);

/** \file
 * \brief IupTuioClient control
 *
 * See Copyright Notice in "iup.d"
 */

module iup.iuptuio;

import iup.iup : Ihandle;

extern (C) :

int IupTuioOpen();
Ihandle* IupTuioClient(int port);

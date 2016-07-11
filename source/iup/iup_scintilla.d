/** \file
 * \brief Scintilla control.
 *
 * See Copyright Notice in "iup.h"
 */

module iup.iup_scintilla;

import core.stdc.config : c_ulong, c_long;
import iup.iup : Ihandle;

version(DigitalMars) version(Windows) { pragma(lib, "iup_scintilla.lib"); }

extern(C) @nogc nothrow :

void IupScintillaOpen();

Ihandle* IupScintilla();

c_long IupScintillaSendMessage(Ihandle* ih, uint iMessage, c_ulong wParam, c_long lParam);

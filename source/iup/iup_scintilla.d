/** \file
 * \brief Scintilla control.
 *
 * See Copyright Notice in "iup.h"
 */

module iup.iup_scintilla;

import core.stdc.config : c_ulong, c_long;
import iup.iup : Ihandle;

version(DigitalMars) version(Windows) { pragma(lib, "iup_scintilla.lib"); } // libiup_scintilla.so depends on libiup.so, ...  
version(DigitalMars) version(Windows) { pragma(lib, "imm32.lib"); } // link with the "imm32.lib" library on Windows.

extern(C) @nogc nothrow :

void IupScintillaOpen();

Ihandle* IupScintilla();
Ihandle* IupScintillaDlg();

c_long IupScintillaSendMessage(Ihandle* ih, uint iMessage, c_ulong wParam, c_long lParam);

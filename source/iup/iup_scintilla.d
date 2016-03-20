/** \file
 * \brief Scintilla control.
 *
 * See Copyright Notice in "iup.h"
 */

module iup.iup_scintilla;

import iup.iup : Ihandle;

extern (C) :

void IupScintillaOpen();

Ihandle* IupScintilla();
/+
#ifdef SCINTILLA_H
sptr_t IupScintillaSendMessage(Ihandle* ih, unsigned int iMessage, uptr_t wParam, sptr_t lParam);
#endif
+/
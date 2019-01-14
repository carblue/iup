/** \file
 * \brief New FileDlg (Windows Only).
 *
 * See Copyright Notice in "iup.h"
 */
 
module iup.iupfiledlg;

extern(C) @nogc nothrow :

/* the only exported function, 
   once called it will replace regular IupFileDlg */

int IupNewFileDlgOpen();

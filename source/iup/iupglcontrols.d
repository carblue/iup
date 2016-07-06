/** \file
 * \brief GL Controls.
 *
 * See Copyright Notice in "iup.h"
 */
 
module iup.iupglcontrols;

import iup.iup;

extern(C) @nogc nothrow :

int  IupGLControlsOpen();

Ihandle* IupGLCanvasBoxv(Ihandle** children);
Ihandle* IupGLCanvasBox(Ihandle* child, ...);

Ihandle* IupGLSubCanvas();

Ihandle* IupGLLabel(const(char)* title);
Ihandle* IupGLSeparator();
Ihandle* IupGLButton(const(char)* title);
Ihandle* IupGLToggle(const(char)* title);
Ihandle* IupGLLink(const(char)* url, const(char)* title);
Ihandle* IupGLProgressBar();
Ihandle* IupGLVal();
Ihandle* IupGLFrame(Ihandle* child);
Ihandle* IupGLExpander(Ihandle* child);
Ihandle* IupGLScrollBox(Ihandle* child);
Ihandle* IupGLSizeBox(Ihandle* child);
Ihandle* IupGLText();

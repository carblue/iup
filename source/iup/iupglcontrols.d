/** \file
 * \brief GL Controls.
 *
 * See Copyright Notice in "iup.h"
 */
 
module iup.iupglcontrols;

import iup.iup : Ihandle;

version(DigitalMars) version(Windows) { pragma(lib, "iupglcontrols.lib"); } // libiupglcontrols.so depends on libiupgl.so, libiup.so, ...

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


/* Utilities */
void IupGLDrawImage(Ihandle* ih, const(char)* name, int x, int y, int active);
void IupGLDrawText(Ihandle* ih, const(char)* str, int len, int x, int y);
void IupGLDrawGetTextSize(Ihandle* ih, const(char)* str, int* w, int* h);
void IupGLDrawGetImageInfo(const(char)* name, int* w, int* h, int* bpp);

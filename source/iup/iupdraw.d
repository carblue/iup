/** \file
 * \brief Canvas Draw API
 *
 * See Copyright Notice in "iup.h"
 */

module iup.iupdraw;

import iup.iup : Ihandle;

//version(DigitalMars) version(Windows) { pragma(lib, "iup.lib"); } // import iup.iup required anyway, that comes with this pragma

extern(C) @nogc nothrow :

/* all functions can be used only in IUP canvas and inside the ACTION callback */

void IupDrawBegin(Ihandle* ih); /// See_Also: https://webserver2.tecgraf.puc-rio.br/iup/en/func/iupdraw.html
void IupDrawEnd(Ihandle* ih); /// See_Also: https://webserver2.tecgraf.puc-rio.br/iup/en/func/iupdraw.html

/* all primitives can be called only between calls to Begin and End */

void IupDrawSetClipRect(Ihandle* ih, int x1, int y1, int x2, int y2);
void IupDrawResetClip(Ihandle* ih);

/* color controlled by the attribute DRAWCOLOR */
/* line style or fill controlled by the attribute DRAWSTYLE */

void IupDrawParentBackground(Ihandle* ih);
void IupDrawLine(Ihandle* ih, int x1, int y1, int x2, int y2);
void IupDrawRectangle(Ihandle* ih, int x1, int y1, int x2, int y2);
void IupDrawArc(Ihandle* ih, int x1, int y1, int x2, int y2, double a1, double a2);
void IupDrawPolygon(Ihandle* ih, int* points, int count);
void IupDrawText(Ihandle* ih, const(char)* text, int len, int x, int y);
void IupDrawImage(Ihandle* ih, const(char)* name, int make_inactive, int x, int y);
void IupDrawSelectRect(Ihandle* ih, int x1, int y1, int x2, int y2);
void IupDrawFocusRect(Ihandle* ih, int x1, int y1, int x2, int y2);

void IupDrawGetSize(Ihandle* ih, int *w, int *h);
void IupDrawGetTextSize(Ihandle* ih, const(char)* str, int *w, int *h);
void IupDrawGetImageInfo(const(char)* name, int *w, int *h, int *bpp);

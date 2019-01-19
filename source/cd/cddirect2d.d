/** \file
 * \brief Direct2D extra drivers.
 *
 * See Copyright Notice in cd.h
 */
module cd.cddirect2d;

version(Windows) :

version(CD) :

import cd.cd : cdContext;

version(DigitalMars) version(Windows) { pragma(lib, "cddirect2d.lib"); }

extern(C) @nogc nothrow :


cdContext* cdContextDirect2DNativeWindow(); /* already double buffered */
cdContext* cdContextDirect2DImage();        /* to draw on an image */
cdContext* cdContextDirect2DImageRGB();     /* to draw on an RGBA image */
cdContext* cdContextDirect2DDBuffer();      /* Not necessary, used to test image drawing */
cdContext* cdContextDirect2DPrinter();      /* NOT working */

alias CD_DIRECT2D_NATIVEWINDOW = cdContextDirect2DNativeWindow;
alias CD_DIRECT2D_IMAGE = cdContextDirect2DImage;
alias CD_DIRECT2D_IMAGERGB = cdContextDirect2DImageRGB;
alias CD_DIRECT2D_DBUFFER = cdContextDirect2DDBuffer;
alias CD_DIRECT2D_PRINTER = cdContextDirect2DPrinter;

void cdInitDirect2D();
void cdFinishDirect2D();

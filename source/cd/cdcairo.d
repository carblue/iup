/** \file
 * \brief Cairo extra drivers.
 *        Rendering PDF, PS, SVG and IMAGERGB.
 *
 * See Copyright Notice in cd.h
 */
module cd.cdcairo;

version(CD) :
//version(DigitalMars) { pragma(lib, "cd"); } // required anyway

import cd.cd : cdContext;

extern(C) @nogc nothrow :

/* Some of these context can be used directly or by cdInitContextPlus,
   as  CD_NATIVEWINDOW, CD_IMAGE, CD_EMF, CD_PRINTER and CD_DBUFFER.
   The others only directly. 
*/

cdContext* cdContextCairoNativeWindow();
cdContext* cdContextCairoImage();
cdContext* cdContextCairoDBuffer();
cdContext* cdContextCairoPrinter();
cdContext* cdContextCairoPS();
cdContext* cdContextCairoPDF();
cdContext* cdContextCairoSVG();
cdContext* cdContextCairoImageRGB();
cdContext* cdContextCairoEMF();

alias CD_CAIRO_NATIVEWINDOW = cdContextCairoNativeWindow;
alias CD_CAIRO_IMAGE = cdContextCairoImage;
alias CD_CAIRO_DBUFFER = cdContextCairoDBuffer;
alias CD_CAIRO_PRINTER = cdContextCairoPrinter;
alias CD_CAIRO_PS = cdContextCairoPS;
alias CD_CAIRO_PDF = cdContextCairoPDF;
alias CD_CAIRO_SVG = cdContextCairoSVG;
alias CD_CAIRO_IMAGERGB = cdContextCairoImageRGB;
alias CD_CAIRO_EMF = cdContextCairoEMF;

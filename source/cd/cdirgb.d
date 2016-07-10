/** \file
 * \brief IMAGERGB driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cdirgb;

version(CD) :

import cd.cd : cdContext, cdCanvas;

//version(DigitalMars) version(Windows) { pragma(lib, "cd.lib"); } // import cd.cd required anyway, that comes with this pragma

extern(C) @nogc nothrow :

cdContext* cdContextImageRGB();
cdContext* cdContextDBufferRGB();
alias CD_IMAGERGB = cdContextImageRGB;
alias CD_DBUFFERRGB = cdContextDBufferRGB;

/* DEPRECATED functions, use REDIMAGE, GREENIMAGE, 
   BLUEIMAGE, and ALPHAIMAGE attributes. */
deprecated("use REDIMAGE, GREENIMAGE, BLUEIMAGE, and ALPHAIMAGE attributes.") {
	ubyte* cdRedImage(cdCanvas* cnv);
	ubyte* cdGreenImage(cdCanvas* cnv);
	ubyte* cdBlueImage(cdCanvas* cnv);
	ubyte* cdAlphaImage(cdCanvas* cnv);
}
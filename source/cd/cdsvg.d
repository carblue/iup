/** \file
 * \brief SVG driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cdsvg;

version(CD) :
//version(DigitalMars) { pragma(lib, "cd"); } // required anyway

import cd.cd : cdContext;

extern(C) @nogc nothrow :

cdContext* cdContextSVG();
alias CD_SVG = cdContextSVG;

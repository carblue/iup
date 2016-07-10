/** \file
 * \brief PDF driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cdpdf;

version(CD) :

import cd.cd : cdContext;

version(DigitalMars) version(Windows) { pragma(lib, "cdpdf.lib"); }

extern(C) @nogc nothrow :

cdContext* cdContextPDF();
alias CD_PDF = cdContextPDF;

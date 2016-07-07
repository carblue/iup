/** \file
 * \brief PDF driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cdpdf;

version(CD) :

import cd.cd : cdContext;

extern(C) @nogc nothrow :

cdContext* cdContextPDF();
alias CD_PDF = cdContextPDF;

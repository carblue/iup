/** \file
 * \brief Printer driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cdprint;

version(CD) :
//version(DigitalMars) { pragma(lib, "cd"); } // required anyway

import cd.cd : cdContext;

extern(C) @nogc nothrow :

cdContext* cdContextPrinter();
alias CD_PRINTER = cdContextPrinter;

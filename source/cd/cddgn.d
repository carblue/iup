/** \file
 * \brief DGN driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cddgn;

version(CD) :
//version(DigitalMars) { pragma(lib, "cd"); } // required anyway

import cd.cd : cdContext;

extern(C) @nogc nothrow :

cdContext* cdContextDGN();

alias CD_DGN = cdContextDGN;

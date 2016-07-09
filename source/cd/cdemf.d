/** \file
 * \brief EMF driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cdemf;

version(CD) :
//version(DigitalMars) { pragma(lib, "cd"); } // required anyway

import cd.cd : cdContext;

extern(C) @nogc nothrow :

cdContext* cdContextEMF();

alias CD_EMF = cdContextEMF;


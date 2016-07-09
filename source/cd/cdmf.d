/** \file
 * \brief CD Metafile driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cdmf;

version(CD) :
//version(DigitalMars) { pragma(lib, "cd"); } // required anyway

import cd.cd : cdContext;

extern(C) @nogc nothrow :

cdContext* cdContextMetafile();
alias CD_METAFILE = cdContextMetafile;

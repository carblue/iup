/** \file
 * \brief CD Metafile driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cdmf;

version(CD) :

import cd.cd : cdContext;

//version(DigitalMars) version(Windows) { pragma(lib, "cd.lib"); } // import cd.cd required anyway, that comes with this pragma

extern(C) @nogc nothrow :

cdContext* cdContextMetafile();
alias CD_METAFILE = cdContextMetafile;

/** \file
 * \brief Double Buffer driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cddbuf;

version(CD) :

import cd.cd : cdContext;

//version(DigitalMars) version(Windows) { pragma(lib, "cd.lib"); } // import cd.cd required anyway, that comes with this pragma

extern(C) @nogc nothrow :

cdContext* cdContextDBuffer();

alias CD_DBUFFER = cdContextDBuffer;

/** \file
 * \brief DXF driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cddxf;

version(CD) :

import cd.cd : cdContext;

//version(DigitalMars) version(Windows) { pragma(lib, "cd.lib"); } // import cd.cd required anyway, that comes with this pragma

extern(C) @nogc nothrow :

cdContext* cdContextDXF();

alias CD_DXF = cdContextDXF;

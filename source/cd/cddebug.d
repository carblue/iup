/** \file
 * \brief CD Debug driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cddebug;

version(CD) :

import cd.cd : cdContext;

//version(DigitalMars) version(Windows) { pragma(lib, "cd.lib"); } // import cd.cd required anyway, that comes with this pragma

extern(C) @nogc nothrow :

cdContext* cdContextDebug();

alias CD_DEBUG = cdContextDebug;

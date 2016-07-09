/** \file
 * \brief CD Debug driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cddebug;

version(CD) :
//version(DigitalMars) { pragma(lib, "cd"); } // required anyway

import cd.cd : cdContext;

extern(C) @nogc nothrow :

cdContext* cdContextDebug();

alias CD_DEBUG = cdContextDebug;

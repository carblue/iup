/** \file
 * \brief Clipboard driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cdclipbd;

version(CD) :
//version(DigitalMars) { pragma(lib, "cd"); } // required anyway

import cd.cd : cdContext;

extern(C) @nogc nothrow :

cdContext* cdContextClipboard();

alias CD_CLIPBOARD =cdContextClipboard;

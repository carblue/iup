/** \file
 * \brief Clipboard driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cdclipbd;

version(CD) :

import cd.cd : cdContext;

extern(C) @nogc nothrow :

cdContext* cdContextClipboard();

alias CD_CLIPBOARD =cdContextClipboard;

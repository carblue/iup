/** \file
 * \brief CD Picture driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cdpicture;

version(CD) :

import cd.cd : cdContext;

extern(C) @nogc nothrow :

cdContext* cdContextPicture();
alias CD_PICTURE = cdContextPicture;

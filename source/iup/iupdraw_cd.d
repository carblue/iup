/** \file
 * \brief IupDraw CD driver
 *
 * See Copyright Notice in iup.h
 */

module iup.iupdraw_cd;

version(CD) :  // without CD-binding, type cdContext is unknown

import cd.cd : cdContext;

extern(C) @nogc nothrow :

cdContext* cdContextIupDraw();
alias  CD_IUPDRAW = cdContextIupDraw;

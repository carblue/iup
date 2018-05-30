/** \file
 * \brief IupDraw CD driver
 *
 * See Copyright Notice in iup.h
 */

module iup.iupdraw_cd;


extern(C) @nogc nothrow :

cdContext* cdContextIupDraw();
alias  CD_IUPDRAW = cdContextIupDraw;

/** \file
 * \brief WMF driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cdwmf;

version(CD) :

import cd.cd : cdContext;

extern(C) @nogc nothrow :

cdContext* cdContextWMF();
alias CD_WMF = cdContextWMF;

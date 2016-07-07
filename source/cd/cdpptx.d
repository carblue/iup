/** \file
 * \brief PPTX driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cdpptx;

version(CD) :

import cd.cd : cdContext;

extern(C) @nogc nothrow :

cdContext* cdContextPPTX();
alias CD_PPTX = cdContextPPTX;

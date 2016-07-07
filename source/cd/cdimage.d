/** \file
 * \brief Server Image driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cdimage;

version(CD) :

import cd.cd : cdContext;

extern(C) @nogc nothrow :

cdContext* cdContextImage();

alias CD_IMAGE = cdContextImage;

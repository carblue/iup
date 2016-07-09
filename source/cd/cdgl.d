/** \file
* \brief OpenGL driver
*
* See Copyright Notice in cd.h
*/
module cd.cdgl;

version(CD) :
version(DigitalMars) { pragma(lib, "cdgl"); }

import cd.cd : cdContext;

extern(C) @nogc nothrow :

cdContext* cdContextGL();

alias CD_GL = cdContextGL;

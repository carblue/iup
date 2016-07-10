/** \file
* \brief OpenGL driver
*
* See Copyright Notice in cd.h
*/
module cd.cdgl;

version(CD) :

import cd.cd : cdContext;

version(DigitalMars) version(Windows) { pragma(lib, "cdgl.lib"); }

extern(C) @nogc nothrow :

cdContext* cdContextGL();

alias CD_GL = cdContextGL;

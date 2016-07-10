/** \file
 * \brief GDI+ Control
 *
 * See Copyright Notice in cd.h
 */
module cd.cdgdiplus;

version(CD) :
version(WINDOWS) :

import cd.cd : CD_POLYCUSTOM;

version(DigitalMars) version(Windows) { pragma(lib, "cdcontextplus.lib"); }

extern(C) @nogc nothrow :

void cdInitGdiPlus();  /* old function, replaced by cdInitContextPlus */

/* Windows GDI+ Additional Polygons */
enum CD_SPLINE       = (CD_POLYCUSTOM+0);
enum CD_FILLSPLINE   = (CD_POLYCUSTOM+1);
enum CD_FILLGRADIENT = (CD_POLYCUSTOM+2);

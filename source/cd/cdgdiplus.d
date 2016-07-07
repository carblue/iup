/** \file
 * \brief GDI+ Control
 *
 * See Copyright Notice in cd.h
 */
module cd.cdgdiplus;

version(CD) :

import cd.cd : CD_POLYCUSTOM;

extern(C) @nogc nothrow :

version(WINDOWS) // #ifdef WIN32
	void cdInitGdiPlus();  /* old function, replaced by cdInitContextPlus */
else { /* #define cdInitGdiPlus() (0) */ }

/* Windows GDI+ Additional Polygons */
enum CD_SPLINE       = (CD_POLYCUSTOM+0);
enum CD_FILLSPLINE   = (CD_POLYCUSTOM+1);
enum CD_FILLGRADIENT = (CD_POLYCUSTOM+2);

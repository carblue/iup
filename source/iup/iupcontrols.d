/** \file
 * \brief initializes dial, gauge, colorbrowser, colorbar controls.
 *
 * See Copyright Notice in "iup.h"
 */

module iup.iupcontrols;

import iup.iup : Ihandle;

version(DigitalMars) version(Windows) { pragma(lib, "iupcontrols.lib"); } // libiupcontrols.so depends on libiup.so, libiupcd.so, libcd.so, ...

extern(C) @nogc nothrow :


int  IupControlsOpen(); /// See_Also: https://webserver2.tecgraf.puc-rio.br/iup/en/iupcontrols.html

Ihandle* IupCells(); /// See_Also: https://webserver2.tecgraf.puc-rio.br/iup/en/ctrl/iupcells.html
Ihandle* IupMatrix(const(char)* action); /// See_Also: https://webserver2.tecgraf.puc-rio.br/iup/en/ctrl/iupmatrix.html
Ihandle* IupMatrixList(); /// See_Also: https://webserver2.tecgraf.puc-rio.br/iup/en/ctrl/iupmatrixlist.html
Ihandle* IupMatrixEx(); /// See_Also: https://webserver2.tecgraf.puc-rio.br/iup/en/ctrl/iupmatrixex.html

/* available only when linking with "iupluamatrix" * /
void IupMatrixSetFormula(Ihandle* ih, int col, const(char)* formula, const(char)* init);
void IupMatrixSetDynamic(Ihandle* ih, const(char)* init);
*/

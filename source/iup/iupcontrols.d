/** \file
 * \brief initializes dial, gauge, colorbrowser, colorbar controls.
 *
 * See Copyright Notice in "iup.h"
 */

module iup.iupcontrols;

import iup.iup : Ihandle;

version(DigitalMars) version(Windows) { pragma(lib, "iupcontrols.lib"); } // libiupcontrols.so depends on libiup.so, libiupcd.so, libcd.so, ...

extern(C) @nogc nothrow :


int  IupControlsOpen();

Ihandle* IupCells();
Ihandle* IupMatrix(const(char)* action);
Ihandle* IupMatrixList();
Ihandle* IupMatrixEx();

/* available only when linking with "iupluamatrix" * /
void IupMatrixSetFormula(Ihandle* ih, int col, const(char)* formula, const(char)* init);
void IupMatrixSetDynamic(Ihandle* ih, const(char)* init);
*/

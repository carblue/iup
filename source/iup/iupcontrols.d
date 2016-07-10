/** \file
 * \brief initializes dial, gauge, colorbrowser, colorbar controls.
 *
 * See Copyright Notice in "iup.h"
 */

module iup.iupcontrols;

import iup.iup : Ihandle;

version(DigitalMars) version(Windows) { pragma(lib, "iupcontrols.lib"); }

extern(C) @nogc nothrow :


int  IupControlsOpen();

Ihandle* IupColorbar();
Ihandle* IupCells();
Ihandle* IupColorBrowser();
Ihandle* IupGauge();
Ihandle* IupDial(const(char)* type);
Ihandle* IupMatrix(const(char)* action);
Ihandle* IupMatrixList();

/* Used by IupColorbar */
enum {
	IUP_PRIMARY   = -1,
	IUP_SECONDARY = -2,
}

/* available only when linking with "iupluamatrix" * /
void IupMatrixSetFormula(Ihandle* ih, int col, const(char)* formula, const(char)* init);
void IupMatrixSetDynamic(Ihandle* ih, const(char)* init);
*/

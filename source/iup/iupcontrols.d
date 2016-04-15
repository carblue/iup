/** \file
 * \brief initializes dial, gauge, colorbrowser, colorbar controls.
 *
 * See Copyright Notice in "iup.h"
 */
 
module iup.iupcontrols;

import iup.iup : Ihandle;

version (DigitalMars)  pragma(lib, "iupcontrols"); // gdc error: pragma(lib) not implemented [-Werror]

extern (C) :


int  IupControlsOpen();
deprecated("for backward compatibility only, does nothing since IUP 3. It will be removed in a future version.")
	void IupControlsClose();

Ihandle* IupColorbar();
Ihandle* IupCells();
Ihandle* IupColorBrowser();
Ihandle* IupGauge();
Ihandle* IupDial(const(char)* type);
Ihandle* IupMatrix(const(char)* action);
Ihandle* IupMatrixList();

deprecated("IupMatrix utilities (use IupSetAttributeId2 functions). It will be removed in a future version.")
{
	void  IupMatSetAttribute  (Ihandle* ih, const(char)* name, int lin, int col, const(char)* value);
	void  IupMatStoreAttribute(Ihandle* ih, const(char)* name, int lin, int col, const(char)* value);
	char* IupMatGetAttribute  (Ihandle* ih, const(char)* name, int lin, int col);
	int   IupMatGetInt        (Ihandle* ih, const(char)* name, int lin, int col);
	float IupMatGetFloat      (Ihandle* ih, const(char)* name, int lin, int col);
	void  IupMatSetfAttribute (Ihandle* ih, const(char)* name, int lin, int col, const(char)* format, ...);
}

/* Used by IupColorbar */
enum {
	IUP_PRIMARY   = -1,
	IUP_SECONDARY = -2,
}

/* available only when linking with "iupluamatrix" * /
void IupMatrixSetFormula(Ihandle* ih, int col, const(char)* formula, const(char)* init);
void IupMatrixSetDynamic(Ihandle* ih, const(char)* init);
*/

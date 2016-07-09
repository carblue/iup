/** \file
 * \brief Plot component for Iup.
 *
 * See Copyright Notice in "iup.h"
 */
 
module iup.iup_mglplot;
version(DigitalMars) { pragma(lib, "iup_mglplot"); }

import iup.iup : Ihandle;

extern(C) @nogc nothrow :

/* Initialize IupMglPlot widget class */
void IupMglPlotOpen();

/* Create an IupMglPlot widget instance */
Ihandle* IupMglPlot();

/***********************************************/
/*           Additional API                    */

/* Linear Data Only */
void IupMglPlotBegin(Ihandle* ih, int dim);
void IupMglPlotAdd1D(Ihandle* ih, const(char)* name, double y);
void IupMglPlotAdd2D(Ihandle* ih, double x, double y);
void IupMglPlotAdd3D(Ihandle* ih, double x, double y, double z);
int  IupMglPlotEnd(Ihandle* ih);

/* Linear (dim=1,2,3), Planar (dim=1), Volumetric (dim=1) */
int IupMglPlotNewDataSet(Ihandle *ih, int dim);

/* Linear Data Only */
void IupMglPlotInsert1D(Ihandle* ih, int ds_index, int sample_index, const(char)** names, const(double)* y, int count);
void IupMglPlotInsert2D(Ihandle* ih, int ds_index, int sample_index, const(double)* x, const(double)* y, int count);
void IupMglPlotInsert3D(Ihandle* ih, int ds_index, int sample_index, const(double)* x, const(double)* y, const(double)* z, int count);

/* Linear Data Only */
void IupMglPlotSet1D(Ihandle* ih, int ds_index, const(char)** names, const(double)* y, int count);
void IupMglPlotSet2D(Ihandle* ih, int ds_index, const(double)* x, const(double)* y, int count);
void IupMglPlotSet3D(Ihandle* ih, int ds_index, const(double)* x, const(double)* y, const(double)* z, int count);
void IupMglPlotSetFormula(Ihandle* ih, int ds_index, const(char)* formulaX, const(char)* formulaY, const(char)* formulaZ, int count);

/* Linear (dim=1), Planar (dim=1), Volumetric (dim=1) */
void IupMglPlotSetData(Ihandle* ih, int ds_index, const(double)* data, int count_x, int count_y, int count_z);
void IupMglPlotLoadData(Ihandle* ih, int ds_index, const(char)* filename, int count_x, int count_y, int count_z);
void IupMglPlotSetFromFormula(Ihandle* ih, int ds_index, const(char)* formula, int count_x, int count_y, int count_z);

/* Only inside callbacks */
void IupMglPlotTransform(Ihandle* ih, double x, double y, double z, int* ix, int* iy);
void IupMglPlotTransformTo(Ihandle* ih, int ix, int iy, double* x, double* y, double* z);

/* Only inside callbacks */
void IupMglPlotDrawMark(Ihandle* ih, double x, double y, double z);
void IupMglPlotDrawLine(Ihandle* ih, double x1, double y1, double z1, double x2, double y2, double z2);
void IupMglPlotDrawText(Ihandle* ih, const(char)* text, double x, double y, double z);

void IupMglPlotPaintTo(Ihandle* ih, const(char)* format, int w, int h, double dpi, void* data);

/***********************************************/

/* Utility label for showing TeX labels */
Ihandle* IupMglLabel(const(char)* title);

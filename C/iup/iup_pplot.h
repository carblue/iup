/** \file
 * \brief PPlot component for Iup.
 *
 * See Copyright Notice in "iup.h"
 */
 
#ifndef __IUP_PPLOT_H 
#define __IUP_PPLOT_H

#ifdef __cplusplus
extern "C" {
#endif

/* Initialize IupPPlot widget class */
void IupPPlotOpen(void);

/* Create an IupPPlot widget instance */
Ihandle* IupPPlot(void);

/***********************************************/
/*           Additional API                    */
void IupPPlotBegin(Ihandle *ih, int strXdata);
void IupPPlotAdd(Ihandle *ih, float x, float y);
void IupPPlotAddStr(Ihandle *ih, const char* x, float y);
int  IupPPlotEnd(Ihandle *ih);

void IupPPlotInsertStr(Ihandle *ih, int index, int sample_index, const char* x, float y);
void IupPPlotInsert(Ihandle *ih, int index, int sample_index, float x, float y);

void IupPPlotInsertStrPoints(Ihandle* ih, int index, int sample_index, const char** x, float* y, int count);
void IupPPlotInsertPoints(Ihandle* ih, int index, int sample_index, float *x, float *y, int count);

void IupPPlotAddPoints(Ihandle* ih, int index, float *x, float *y, int count);
void IupPPlotAddStrPoints(Ihandle* ih, int index, const char** x, float* y, int count);

void IupPPlotGetSample(Ihandle* ih, int index, int sample_index, float *x, float *y);
void IupPPlotGetSampleStr(Ihandle* ih, int index, int sample_index, const char* *x, float *y);

void IupPPlotTransform(Ihandle* ih, float x, float y, int *ix, int *iy);
void IupPPlotTransformTo(Ihandle* ih, int x, int y, float *rx, float *ry);

void IupPPlotPaintTo(Ihandle *ih, void *cnv);
/***********************************************/


#ifdef __cplusplus
}
#endif

#endif

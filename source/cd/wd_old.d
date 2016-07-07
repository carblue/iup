/** \file
 * \brief Old WC API
 *
 * See Copyright Notice in cd.h
 */
module cd.wd_old;

version(CD) :

import core.stdc.config : c_long;
import cd.cd : cdContext, cdCanvas, cdImage, cdBitmap;

extern(C) @nogc nothrow :

/* coordinate transformation */
void wdWindow(double xmin, double xmax, double  ymin, double ymax);
void wdGetWindow(double* xmin, double* xmax,  double* ymin, double* ymax);
void wdViewport(int xmin, int xmax, int ymin, int ymax);
void wdGetViewport(int* xmin, int* xmax,  int* ymin, int* ymax);
void wdWorld2Canvas(double xw, double yw, int* xv, int* yv);
void wdWorld2CanvasSize(double hw, double vw, int* hv, int* vv);
void wdCanvas2World(int xv, int yv, double* xw, double* yw);

void wdClipArea(double xmin, double xmax, double  ymin, double ymax);
int  wdGetClipArea(double* xmin, double* xmax, double* ymin, double* ymax);
double* wdGetClipPoly(int* n);
int  wdPointInRegion(double x, double y);
void wdOffsetRegion(double x, double y);
void wdRegionBox(double* xmin, double* xmax, double* ymin, double* ymax);

void wdHardcopy(cdContext* ctx, void* data, cdCanvas* cnv, void function() draw_func);

/* primitives */
void wdPixel(double x, double y, c_long color);
void wdMark(double x, double y);
void wdLine(double x1, double y1, double x2, double y2);
void wdVertex(double x, double y);
void wdRect(double xmin, double xmax, double ymin, double ymax);
void wdBox(double xmin, double xmax, double ymin, double ymax);
void wdArc(double xc, double yc, double w, double h, double angle1, double angle2);
void wdSector(double xc, double yc, double w, double h, double angle1, double angle2);
void wdChord(double xc, double yc, double w, double h, double angle1, double angle2);
void wdText(double x, double y, const(char)* s);

void wdPutImageRect(cdImage* image, double x, double y, int xmin, int xmax, int ymin, int ymax);
void wdPutImageRectRGB(int iw, int ih, const(ubyte)* r, const(ubyte)* g, const(ubyte)* b, double x, double y, double w, double h, int xmin, int xmax, int ymin, int ymax);
void wdPutImageRectRGBA(int iw, int ih, const(ubyte)* r, const(ubyte)* g, const(ubyte)* b, const(ubyte)* a, double x, double y, double w, double h, int xmin, int xmax, int ymin, int ymax);
void wdPutImageRectMap(int iw, int ih, const(ubyte)* index, const(c_long)* colors, double x, double y, double w, double h, int xmin, int xmax, int ymin, int ymax);
void wdPutBitmap(cdBitmap* bitmap, double x, double y, double w, double h);

/* attributes */
double wdLineWidth(double width);
void wdFont(int type_face, int style, double size);
void wdGetFont(int* type_face, int* style, double* size);
double wdMarkSize(double size);
void wdFontDim(double* max_width, double* height, double* ascent, double* descent);
void wdTextSize(const(char)* s, double* width, double* height);
void wdTextBox(double x, double y, const(char)* s, double* xmin, double* xmax, double* ymin, double* ymax);
void wdTextBounds(double x, double y, const(char)* s, double* rect);
void wdStipple(int w, int h, const(ubyte)* stipple, double w_mm, double h_mm);
void wdPattern(int w, int h, const(c_long)* pattern, double w_mm, double h_mm);

/* vector text */
void wdVectorTextDirection(double x1, double y1, double x2, double y2);
void wdVectorTextSize(double size_x, double size_y, const(char)* s);
void wdGetVectorTextSize(const(char)* s, double* x, double* y);
double wdVectorCharSize(double size);
void wdVectorText(double x, double y, const(char)* s);
void wdMultiLineVectorText(double x, double y, const(char)* s);
void wdGetVectorTextBounds(const(char)* s, double x, double y, double* rect);

/* OLD definitions, defined for backward compatibility */
version(CD_NO_OLD_INTERFACE)
	 {}
else {
	public import cd.cd_old;

	alias wdVectorFont = cdVectorFont;
	alias wdVectorTextTransform =cdVectorTextTransform;
	alias wdActivate = cdActivate;
	alias wdClip = cdClip;
	alias wdBegin = cdBegin;
	alias wdEnd = cdEnd;
	alias wdMM2Pixel = cdMM2Pixel;
	alias wdPixel2MM = cdPixel2MM;
}

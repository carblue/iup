/** \file
 * \brief Old User API
 *
 * See Copyright Notice in cd.h
 */
module cd.cd_old;

version(CD) :
//version(DigitalMars) { pragma(lib, "cd"); } // required anyway

import core.stdc.config : c_long;
import cd.cd : cdCallback, cdContext, cdCanvas, cdState, cdImage, cdBitmap, CD_CLIPAREA, CD_BASE_CENTER, CD_BASE_LEFT, CD_BASE_RIGHT, CD_BOLD_ITALIC;

extern(C) @nogc nothrow :

/* canvas control */
int       cdActivate(cdCanvas* canvas);
cdCanvas* cdActiveCanvas();
int       cdSimulate(int mode);
void      cdFlush();
void      cdClear();
cdState*  cdSaveState();
void      cdRestoreState(cdState* state);
void      cdSetAttribute(const(char)* name, char* data);
void      cdSetfAttribute(const(char)* name, const(char)* format, ...);
char*     cdGetAttribute(const(char)* name);
cdContext*  cdGetContext(cdCanvas* canvas);

/* interpretation */
int cdRegisterCallback(cdContext* context, int cb, cdCallback func);
int cdPlay(cdContext* context, int xmin, int xmax, int ymin, int ymax, void* data);

/* coordinate transformation */
void cdGetCanvasSize(int* width, int* height, double* width_mm, double* height_mm);
int cdUpdateYAxis(int* y);
void cdMM2Pixel(double mm_dx, double mm_dy, int* dx, int* dy);
void cdPixel2MM(int dx, int dy, double* mm_dx, double* mm_dy);
void cdOrigin(int x, int y);

/* clipping */
int   cdClip(int mode);
int * cdGetClipPoly(int* n);
void  cdClipArea(int xmin, int xmax, int ymin, int ymax);
int   cdGetClipArea(int* xmin, int* xmax, int* ymin, int* ymax);

/* clipping region */
int  cdPointInRegion(int x, int y);
void cdOffsetRegion(int x, int y);
void cdRegionBox(int* xmin, int*xmax, int* ymin, int* ymax);
int  cdRegionCombineMode(int mode);

/* primitives */
void cdPixel(int x, int y, c_long color);
void cdMark(int x, int y);
void cdLine(int x1, int y1, int x2, int y2);
void cdBegin(int mode);
void cdVertex(int x, int y);
void cdEnd();
void cdRect(int xmin, int xmax, int ymin, int ymax);
void cdBox(int xmin, int xmax, int ymin, int ymax);
void cdArc(int xc, int yc, int w, int h, double angle1, double angle2);
void cdSector(int xc, int yc, int w, int h, double angle1, double angle2);
void cdChord(int xc, int yc, int w, int h, double angle1, double angle2);
void cdText(int x, int y, const(char)* s);

/* attributes */
c_long cdBackground(c_long color);
c_long cdForeground(c_long color);
int  cdBackOpacity(int opacity);
int  cdWriteMode(int mode);
int  cdLineStyle(int style);
void cdLineStyleDashes(const(int)* dashes, int count);
int  cdLineWidth(int width);
int  cdLineJoin(int join);
int  cdLineCap(int cap);
int  cdInteriorStyle(int style);
int  cdHatch(int style);
void cdStipple(int w, int h, const(ubyte)* stipple);
ubyte* cdGetStipple(int* n, int* m);
void   cdPattern(int w, int h, const(c_long)* pattern);
c_long*  cdGetPattern(int* n, int* m);
int    cdFillMode(int mode);
void   cdFont(int type_face, int style, int size);
void   cdGetFont(int* type_face, int* style, int* size);
char*  cdNativeFont(const(char)* font);
int    cdTextAlignment(int alignment);
double cdTextOrientation(double angle);
int    cdMarkType(int type);
int    cdMarkSize(int size);

/* vector text */
void cdVectorText(int x, int y, const(char)* s);
void cdMultiLineVectorText(int x, int y, const(char)* s);

/* vector text attributes */
char *cdVectorFont(const(char)* filename);
void cdVectorTextDirection(int x1, int y1, int x2, int y2);
double* cdVectorTextTransform(const(double)* matrix);
void cdVectorTextSize(int size_x, int size_y, const(char)* s);
int  cdVectorCharSize(int size);

/* vector text properties */
void cdGetVectorTextSize(const(char)* s, int* x, int* y);
void cdGetVectorTextBounds(const(char)* s, int x, int y, int* rect);

/* properties */
void cdFontDim(int* max_width, int* height, int* ascent, int* descent);
void cdTextSize(const(char)* s, int* width, int* height);
void cdTextBox(int x, int y, const(char)* s, int* xmin, int* xmax, int* ymin, int* ymax);
void cdTextBounds(int x, int y, const(char)* s, int* rect);
int  cdGetColorPlanes();

/* color */
void cdPalette(int n, const(c_long)* palette, int mode);

/* client images */
void cdGetImageRGB(ubyte* r, ubyte* g, ubyte* b, int x, int y, int w, int h);
void cdPutImageRectRGB(int iw, int ih, const(ubyte)* r, const(ubyte)* g, const(ubyte)* b, int x, int y, int w, int h, int xmin, int xmax, int ymin, int ymax);
void cdPutImageRectRGBA(int iw, int ih, const(ubyte)* r, const(ubyte)* g, const(ubyte)* b, const(ubyte)* a, int x, int y, int w, int h, int xmin, int xmax, int ymin, int ymax);
void cdPutImageRectMap(int iw, int ih, const(ubyte)* index, const(c_long)* colors, int x, int y, int w, int h, int xmin, int xmax, int ymin, int ymax);

/* defined for backward compatibility */
/*
//#define cdPutImageRGB(iw, ih, r, g, b, x, y, w, h) cdPutImageRectRGB((iw), (ih), (r), (g), (b), (x), (y), (w), (h), 0, 0, 0, 0)
void cdPutImageRGB(int iw, int ih, const(ubyte)* r, const(ubyte)* g, const(ubyte)* b, int x, int y, int w, int h) {
	return cdPutImageRectRGB(iw, ih, r, g, b, x, y, w, h, 0, 0, 0, 0);
}
//#define cdPutImageRGBA(iw, ih, r, g, b, a, x, y, w, h) cdPutImageRectRGBA((iw), (ih), (r), (g), (b), (a), (x), (y), (w), (h), 0, 0, 0, 0)
void cdPutImageRGBA(int iw, int ih, const(ubyte)* r, const(ubyte)* g, const(ubyte)* b, const(ubyte)* a, int x, int y, int w, int h) {
	return cdPutImageRecStRGBA(iw, ih, r, g, b, a, x, y, w, h, 0, 0, 0, 0);
}
//#define cdPutImageMap(iw, ih, index, colors, x, y, w, h) cdPutImageRectMap((iw), (ih), (index), (colors), (x), (y), (w), (h), 0, 0, 0, 0)
void cdPutImageMap(int iw, int ih, const(ubyte)* index, const(c_long)* colors, int x, int y, int w, int h) {
	return cdPutImageRectMap(iw, ih, index, colors, x, y, w, h, 0, 0, 0, 0);
}
//#define cdPutImage(image, x, y) cdPutImageRect((image), (x), (y), 0, 0, 0, 0)
void cdPutImage(cdImage* image, int x, int y) {
	return cdPutImageRect((image), (x), (y), 0, 0, 0, 0);
}
*/

/* server images */
cdImage* cdCreateImage(int w, int h);
void cdGetImage(cdImage* image, int x, int y);
void cdPutImageRect(cdImage* image, int x, int y, int xmin, int xmax, int ymin, int ymax);
void cdScrollArea(int xmin, int xmax, int ymin, int ymax, int dx, int dy);

/* bitmap */
void cdPutBitmap(cdBitmap* bitmap, int x, int y, int w, int h);
void cdGetBitmap(cdBitmap* bitmap, int x, int y);

enum {          /* OLD type face ->  new names */
 CD_SYSTEM,                     /* "System"    */
 CD_COURIER,                    /* "Courier"   */
 CD_TIMES_ROMAN,                /* "Times"     */
 CD_HELVETICA,                  /* "Helvetica" */
 CD_NATIVE
}

/* OLD definitions, defined for backward compatibility */
enum CD_CLIPON       = CD_CLIPAREA;   
enum CD_CENTER_BASE  = CD_BASE_CENTER;
enum CD_LEFT_BASE    = CD_BASE_LEFT;
enum CD_RIGHT_BASE   = CD_BASE_RIGHT;
enum CD_ITALIC_BOLD  = CD_BOLD_ITALIC;
alias cdScrollImage = cdScrollArea;
//#define cdCanvas2Raster(x, y) {(void)x; cdUpdateYAxis(y);}
//void cdCanvas2Raster(int* x, int* y) {/*(void)x;*/ cdUpdateYAxis(y);}

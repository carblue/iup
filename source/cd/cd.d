/** \file
 * \brief User API
 * CD - Canvas Draw
 * Tecgraf: Computer Graphics Technology Group, PUC-Rio, Brazil
 * http://www.tecgraf.puc-rio.br/cd
 * mailto:cd@tecgraf.puc-rio.br
 *
 * See Copyright Notice at the end of this file
 */
module cd.cd;

version(CD) :

import core.stdc.config : c_ulong, c_long;
//private import cd.cd_private : _cdContext, _cdCanvas, _cdImage;

version(DigitalMars) version(Windows) { pragma(lib, "cd.lib"); }

extern(C) :

alias cdCallback = int function(cdCanvas* canvas, ...) nothrow;
alias cdSizeCB = int function(cdCanvas* canvas, int w, int h, double w_mm, double h_mm) nothrow;

@nogc nothrow :

enum CD_NAME = "CD - A 2D Graphics Library";
enum CD_DESCRIPTION = "Vector Graphics Toolkit with Device Independent Output";
enum CD_COPYRIGHT = "Copyright (C) 1994-2017 Tecgraf/PUC-Rio";
enum CD_VERSION = "5.11";              /* bug fixes are reported only by cdVersion functions */
enum CD_VERSION_NUMBER = 511000;
enum CD_VERSION_DATE = "2016/09/30";  /* does not include bug fix releases */

struct _cdContext;
alias cdContext = _cdContext;

struct _cdCanvas;
alias cdCanvas = _cdCanvas;

alias cdState = _cdCanvas;

struct _cdImage;
alias cdImage = _cdImage;

/* client images using bitmap structure */
struct cdBitmap { // typedef struct _cdBitmap cdBitmap;
  int w;
  int h;
  int type;
  void *data;
}


/* library */
char*         cdVersion();
char*         cdVersionDate();
int           cdVersionNumber();

/* canvas init */
cdCanvas*   cdCreateCanvas(cdContext* context, void* data);
cdCanvas*   cdCreateCanvasf(cdContext* context, const(char)* format, ...);
void        cdKillCanvas(cdCanvas* canvas);

cdContext*  cdCanvasGetContext(cdCanvas* canvas);
int         cdCanvasActivate(cdCanvas* canvas);
void        cdCanvasDeactivate(cdCanvas* canvas);
int         cdUseContextPlus(int use);
void        cdInitContextPlus();   /* need an external library */
void        cdFinishContextPlus();   /* need an external library */

/* context */
//alias cdCallback = int function(cdCanvas* canvas, ...) nothrow;
int cdContextRegisterCallback(cdContext* context, int cb, cdCallback func);
c_ulong cdContextCaps(cdContext* context);
int cdContextIsPlus(cdContext* context);
int cdContextType(cdContext* context);

/* control */
int      cdCanvasSimulate(cdCanvas* canvas, int mode);
void     cdCanvasFlush(cdCanvas* canvas);
void     cdCanvasClear(cdCanvas* canvas);
cdState* cdCanvasSaveState(cdCanvas* canvas);
void     cdCanvasRestoreState(cdCanvas* canvas, cdState* state);
void     cdReleaseState(cdState* state);
void     cdCanvasSetAttribute(cdCanvas* canvas, const(char)* name, char* data);
void     cdCanvasSetfAttribute(cdCanvas* canvas, const(char)* name, const(char)* format, ...);
char*    cdCanvasGetAttribute(cdCanvas* canvas, const(char)* name);

/* interpretation */
int cdCanvasPlay(cdCanvas* canvas, cdContext* context, int xmin, int xmax, int ymin, int ymax, void* data);

/* coordinate transformation */
void cdCanvasGetSize(cdCanvas* canvas, int* width, int* height, double* width_mm, double* height_mm);
int cdCanvasUpdateYAxis(cdCanvas* canvas, int* y);
double cdfCanvasUpdateYAxis(cdCanvas* canvas, double* y);
int cdCanvasInvertYAxis(cdCanvas* canvas, int y);
double cdfCanvasInvertYAxis(cdCanvas* canvas, double y);
void cdCanvasMM2Pixel(cdCanvas* canvas, double mm_dx, double mm_dy, int* dx, int* dy);
void cdCanvasPixel2MM(cdCanvas* canvas, int dx, int dy, double* mm_dx, double* mm_dy);
void cdfCanvasMM2Pixel(cdCanvas* canvas, double mm_dx, double mm_dy, double* dx, double* dy);
void cdfCanvasPixel2MM(cdCanvas* canvas, double dx, double dy, double* mm_dx, double* mm_dy);
void cdCanvasOrigin(cdCanvas* canvas, int x, int y);
void cdfCanvasOrigin(cdCanvas* canvas, double x, double y);
void cdCanvasGetOrigin(cdCanvas* canvas, int* x, int* y);
void cdfCanvasGetOrigin(cdCanvas* canvas, double* x, double* y);
void cdCanvasTransform(cdCanvas* canvas, const(double)* matrix);
double* cdCanvasGetTransform(cdCanvas* canvas);
void cdCanvasTransformMultiply(cdCanvas* canvas, const(double)* matrix);
void cdCanvasTransformRotate(cdCanvas* canvas, double angle);
void cdCanvasTransformScale(cdCanvas* canvas, double sx, double sy);
void cdCanvasTransformTranslate(cdCanvas* canvas, double dx, double dy);
void cdCanvasTransformPoint(cdCanvas* canvas, int x, int y, int* tx, int* ty);
void cdfCanvasTransformPoint(cdCanvas* canvas, double x, double y, double* tx, double* ty);

/* clipping */
int  cdCanvasClip(cdCanvas* canvas, int mode);
void cdCanvasClipArea(cdCanvas* canvas, int xmin, int xmax, int ymin, int ymax);
int  cdCanvasGetClipArea(cdCanvas* canvas, int* xmin, int* xmax, int* ymin, int* ymax);
void cdfCanvasClipArea(cdCanvas* canvas, double xmin, double xmax, double ymin, double ymax);
int  cdfCanvasGetClipArea(cdCanvas* canvas, double* xmin, double* xmax, double* ymin, double* ymax);

/* clipping region */
int  cdCanvasIsPointInRegion(cdCanvas* canvas, int x, int y);
void cdCanvasOffsetRegion(cdCanvas* canvas, int x, int y);
void cdCanvasGetRegionBox(cdCanvas* canvas, int* xmin, int* xmax, int* ymin, int* ymax);
int  cdCanvasRegionCombineMode(cdCanvas* canvas, int mode);

/* primitives */
void cdCanvasPixel(cdCanvas* canvas, int x, int y, c_long color);
void cdCanvasMark(cdCanvas* canvas, int x, int y);
void cdfCanvasPixel(cdCanvas* canvas, double x, double y, c_long color);
void cdfCanvasMark(cdCanvas* canvas, double x, double y);

void cdCanvasBegin(cdCanvas* canvas, int mode);
void cdCanvasPathSet(cdCanvas* canvas, int action);
void cdCanvasEnd(cdCanvas* canvas);

void cdCanvasLine(cdCanvas* canvas, int x1, int y1, int x2, int y2);
void cdCanvasVertex(cdCanvas* canvas, int x, int y);
void cdCanvasRect(cdCanvas* canvas, int xmin, int xmax, int ymin, int ymax);
void cdCanvasBox(cdCanvas* canvas, int xmin, int xmax, int ymin, int ymax);
void cdCanvasArc(cdCanvas* canvas, int xc, int yc, int w, int h, double angle1, double angle2);
void cdCanvasSector(cdCanvas* canvas, int xc, int yc, int w, int h, double angle1, double angle2);
void cdCanvasChord(cdCanvas* canvas, int xc, int yc, int w, int h, double angle1, double angle2);
void cdCanvasText(cdCanvas* canvas, int x, int y, const(char)* s);

void cdfCanvasLine(cdCanvas* canvas, double x1, double y1, double x2, double y2);
void cdfCanvasVertex(cdCanvas* canvas, double x, double y);
void cdfCanvasRect(cdCanvas* canvas, double xmin, double xmax, double ymin, double ymax);
void cdfCanvasBox(cdCanvas* canvas, double xmin, double xmax, double ymin, double ymax);
void cdfCanvasArc(cdCanvas* canvas, double xc, double yc, double w, double h, double angle1, double angle2);
void cdfCanvasSector(cdCanvas* canvas, double xc, double yc, double w, double h, double angle1, double angle2);
void cdfCanvasChord(cdCanvas* canvas, double xc, double yc, double w, double h, double angle1, double angle2);
void cdfCanvasText(cdCanvas* canvas, double x, double y, const(char)* s);

/* attributes */
void cdCanvasSetBackground(cdCanvas* canvas, c_long color);
void cdCanvasSetForeground(cdCanvas* canvas, c_long color);
c_long cdCanvasBackground(cdCanvas* canvas, c_long color);
c_long cdCanvasForeground(cdCanvas* canvas, c_long color);
int  cdCanvasBackOpacity(cdCanvas* canvas, int opacity);
int  cdCanvasWriteMode(cdCanvas* canvas, int mode);
int  cdCanvasLineStyle(cdCanvas* canvas, int style);
void cdCanvasLineStyleDashes(cdCanvas* canvas, const(int)* dashes, int count);
int  cdCanvasLineWidth(cdCanvas* canvas, int width);
int  cdCanvasLineJoin(cdCanvas* canvas, int join);
int  cdCanvasLineCap(cdCanvas* canvas, int cap);
int  cdCanvasInteriorStyle(cdCanvas* canvas, int style);
int  cdCanvasHatch(cdCanvas* canvas, int style);
void cdCanvasStipple(cdCanvas* canvas, int w, int h, const(ubyte)* stipple);
ubyte* cdCanvasGetStipple(cdCanvas* canvas, int* n, int* m);
void   cdCanvasPattern(cdCanvas* canvas, int w, int h, const(c_long)* pattern);
c_long*  cdCanvasGetPattern(cdCanvas* canvas, int* n, int* m);
int    cdCanvasFillMode(cdCanvas* canvas, int mode);
int    cdCanvasFont(cdCanvas* canvas, const(char)* type_face, int style, int size);
void   cdCanvasGetFont(cdCanvas* canvas, char* type_face, int* style, int* size);
char*  cdCanvasNativeFont(cdCanvas* canvas, const(char)* font);
int    cdCanvasTextAlignment(cdCanvas* canvas, int alignment);
double cdCanvasTextOrientation(cdCanvas* canvas, double angle);
int    cdCanvasMarkType(cdCanvas* canvas, int type);
int    cdCanvasMarkSize(cdCanvas* canvas, int size);

/* vector text */
void cdCanvasVectorText(cdCanvas* canvas, int x, int y, const(char)* s);
void cdCanvasMultiLineVectorText(cdCanvas* canvas, int x, int y, const(char)* s);

/* vector text attributes */
char* cdCanvasVectorFont(cdCanvas* canvas, const(char)* filename);
void  cdCanvasVectorTextDirection(cdCanvas* canvas, int x1, int y1, int x2, int y2);
double* cdCanvasVectorTextTransform(cdCanvas* canvas, const(double)* matrix);
void  cdCanvasVectorTextSize(cdCanvas* canvas, int size_x, int size_y, const(char)* s);
int   cdCanvasVectorCharSize(cdCanvas* canvas, int size);
void  cdCanvasVectorFontSize(cdCanvas* canvas, double size_x, double size_y);
void  cdCanvasGetVectorFontSize(cdCanvas* canvas, double* size_x, double* size_y);

/* vector text properties */
void cdCanvasGetVectorTextSize(cdCanvas* canvas, const(char)* s, int* x, int* y);
void cdCanvasGetVectorTextBounds(cdCanvas* canvas, const(char)* s, int x, int y, int* rect);
void cdCanvasGetVectorTextBox(cdCanvas* canvas, int x, int y, const(char)* s, int* xmin, int* xmax, int* ymin, int* ymax);

void cdfCanvasVectorTextDirection(cdCanvas* canvas, double x1, double y1, double x2, double y2);
void cdfCanvasVectorTextSize(cdCanvas* canvas, double size_x, double size_y, const(char)* s);
void cdfCanvasGetVectorTextSize(cdCanvas* canvas, const(char)* s, double* x, double* y);
double cdfCanvasVectorCharSize(cdCanvas* canvas, double size);
void cdfCanvasVectorText(cdCanvas* canvas, double x, double y, const(char)* s);
void cdfCanvasMultiLineVectorText(cdCanvas* canvas, double x, double y, const(char)* s);
void cdfCanvasGetVectorTextBounds(cdCanvas* canvas, const(char)* s, double x, double y, double* rect);
void cdfCanvasGetVectorTextBox(cdCanvas* canvas, double x, double y, const(char)* s, double* xmin, double* xmax, double* ymin, double* ymax);

/* properties */
void cdCanvasGetFontDim(cdCanvas* canvas, int* max_width, int* height, int* ascent, int* descent);
void cdCanvasGetTextSize(cdCanvas* canvas, const(char)* s, int* width, int* height);
void cdCanvasGetTextBox(cdCanvas* canvas, int x, int y, const(char)* s, int* xmin, int* xmax, int* ymin, int* ymax);
void cdfCanvasGetTextBox(cdCanvas* canvas, double x, double y, const(char)* s, double* xmin, double* xmax, double* ymin, double* ymax);
void cdCanvasGetTextBounds(cdCanvas* canvas, int x, int y, const(char)* s, int* rect);
void cdfCanvasGetTextBounds(cdCanvas* canvas, double x, double y, const(char)* s, double* rect);
int  cdCanvasGetColorPlanes(cdCanvas* canvas);

/* color */
void cdCanvasPalette(cdCanvas* canvas, int n, const(c_long)* palette, int mode);

/* client images */
void cdCanvasGetImageRGB(cdCanvas* canvas, ubyte* r, ubyte* g, ubyte* b, int x, int y, int iw, int ih);

void cdCanvasPutImageRectRGB(cdCanvas* canvas, int iw, int ih, const(ubyte)* r, const(ubyte)* g, const(ubyte)* b, int x, int y, int w, int h, int xmin, int xmax, int ymin, int ymax);
void cdCanvasPutImageRectRGBA(cdCanvas* canvas, int iw, int ih, const(ubyte)* r, const(ubyte)* g, const(ubyte)* b, const(ubyte)* a, int x, int y, int w, int h, int xmin, int xmax, int ymin, int ymax);
void cdCanvasPutImageRectMap(cdCanvas* canvas, int iw, int ih, const(ubyte)* index, const(c_long)* colors, int x, int y, int w, int h, int xmin, int xmax, int ymin, int ymax);

void cdfCanvasPutImageRectRGB(cdCanvas* canvas, int iw, int ih, const(ubyte)* r, const(ubyte)* g, const(ubyte)* b, double x, double y, double w, double h, int xmin, int xmax, int ymin, int ymax);
void cdfCanvasPutImageRectRGBA(cdCanvas* canvas, int iw, int ih, const(ubyte)* r, const(ubyte)* g, const(ubyte)* b, const(ubyte)* a, double x, double y, double w, double h, int xmin, int xmax, int ymin, int ymax);
void cdfCanvasPutImageRectMap(cdCanvas* canvas, int iw, int ih, const(ubyte)* index, const c_long* colors, double x, double y, double w, double h, int xmin, int xmax, int ymin, int ymax);

/* server images - deprecated (use double buffer drivers) */
deprecated("use double buffer drivers") {
	cdImage* cdCanvasCreateImage(cdCanvas* canvas, int w, int h);
	void cdKillImage(cdImage* image);
	void cdCanvasGetImage(cdCanvas* canvas, cdImage* image, int x, int y);
	void cdCanvasPutImageRect(cdCanvas* canvas, cdImage* image, int x, int y, int xmin, int xmax, int ymin, int ymax);
	void cdCanvasScrollArea(cdCanvas* canvas, int xmin, int xmax, int ymin, int ymax, int dx, int dy);
}

/* bitmap - deprecated (use imImage) */
deprecated("use imImage") {
	cdBitmap* cdCreateBitmap(int w, int h, int type);
	cdBitmap* cdInitBitmap(int w, int h, int type, ...);
	void cdKillBitmap(cdBitmap* bitmap);
	ubyte* cdBitmapGetData(cdBitmap* bitmap, int dataptr);
	void cdBitmapSetRect(cdBitmap* bitmap, int xmin, int xmax, int ymin, int ymax);
	void cdCanvasPutBitmap(cdCanvas* canvas, cdBitmap* bitmap, int x, int y, int w, int h);
	void cdCanvasGetBitmap(cdCanvas* canvas, cdBitmap* bitmap, int x, int y);
	void cdBitmapRGB2Map(cdBitmap* bitmap_rgb, cdBitmap* bitmap_map);
}

/* color */
c_long cdEncodeColor(ubyte red, ubyte green, ubyte blue);
c_long cdEncodeColorAlpha(ubyte red, ubyte green, ubyte blue, ubyte alpha);
c_long cdEncodeAlpha(c_long color, ubyte alpha);
void cdDecodeColor(c_long color, ubyte* red, ubyte* green, ubyte* blue);
void cdDecodeColorAlpha(c_long color, ubyte* red, ubyte* green, ubyte* blue, ubyte* alpha);
ubyte cdDecodeAlpha(c_long color);

ubyte cdAlpha(uint _)    { return cast(ubyte) ~((_ >> 24) & 0xFF); }
ubyte cdReserved(uint _) { return cast(ubyte)  ((_ >> 24) & 0xFF); }
ubyte cdRed(uint _)      { return cast(ubyte)  ((_ >> 16) & 0xFF); }
ubyte cdGreen(uint _)    { return cast(ubyte)  ((_ >>  8) & 0xFF); }
ubyte cdBlue(uint _)     { return cast(ubyte)  ((_ >>  0) & 0xFF); }

/* client image color conversion */
void cdRGB2Map(int width, int height, const(ubyte)* red, const(ubyte)* green, const(ubyte)* blue, ubyte* index, int pal_size, c_long* color);


/* CD Values */

enum CD_QUERY = -1;             /* query value */

enum {                        /* bitmap type */
 CD_RGB,                      /* these definitions are compatible with the IM library */
 CD_MAP,
 CD_RGBA = 0x100
}

enum {                         /* bitmap data */
 CD_IRED,
 CD_IGREEN,
 CD_IBLUE,
 CD_IALPHA,
 CD_INDEX,
 CD_COLORS
}

enum {                          /* status report */
 CD_ERROR = -1,
 CD_OK    =  0
}

enum {                          /* clip mode */
 CD_CLIPOFF,
 CD_CLIPAREA,
 CD_CLIPPOLYGON,
 CD_CLIPREGION
}

enum {                          /* region combine mode */
 CD_UNION,
 CD_INTERSECT,
 CD_DIFFERENCE,
 CD_NOTINTERSECT
}

enum {                          /* polygon mode (begin...end) */
 CD_FILL,
 CD_OPEN_LINES,
 CD_CLOSED_LINES,
 CD_CLIP,
 CD_BEZIER,
 CD_REGION,
 CD_PATH
}

enum CD_POLYCUSTOM = 10;

enum {                          /* path actions */
 CD_PATH_NEW,
 CD_PATH_MOVETO,
 CD_PATH_LINETO,
 CD_PATH_ARC,
 CD_PATH_CURVETO,
 CD_PATH_CLOSE,
 CD_PATH_FILL,
 CD_PATH_STROKE,
 CD_PATH_FILLSTROKE,
 CD_PATH_CLIP
}

enum {                          /* fill mode */
 CD_EVENODD,
 CD_WINDING
}

enum {                          /* line join  */
 CD_MITER,
 CD_BEVEL,
 CD_ROUND
}

enum {                          /* line cap  */
 CD_CAPFLAT,
 CD_CAPSQUARE,
 CD_CAPROUND
}

enum {                          /* background opacity mode */
 CD_OPAQUE,
 CD_TRANSPARENT
}

enum {                          /* write mode */
 CD_REPLACE,
 CD_XOR,
 CD_NOT_XOR
}

enum {                          /* color allocation mode (palette) */
 CD_POLITE,
 CD_FORCE
}

enum {                          /* line style */
 CD_CONTINUOUS,
 CD_DASHED,
 CD_DOTTED,
 CD_DASH_DOT,
 CD_DASH_DOT_DOT,
 CD_CUSTOM
}

enum {                          /* marker type */
 CD_PLUS,
 CD_STAR,
 CD_CIRCLE,
 CD_X,
 CD_BOX,
 CD_DIAMOND,
 CD_HOLLOW_CIRCLE,
 CD_HOLLOW_BOX,
 CD_HOLLOW_DIAMOND
}

enum {                          /* hatch type */
 CD_HORIZONTAL,
 CD_VERTICAL,
 CD_FDIAGONAL,
 CD_BDIAGONAL,
 CD_CROSS,
 CD_DIAGCROSS
}

enum {                          /* interior style */
 CD_SOLID,
 CD_HATCH,
 CD_STIPPLE,
 CD_PATTERN,
 CD_HOLLOW
}

enum {                          /* text alignment */
 CD_NORTH,
 CD_SOUTH,
 CD_EAST,
 CD_WEST,
 CD_NORTH_EAST,
 CD_NORTH_WEST,
 CD_SOUTH_EAST,
 CD_SOUTH_WEST,
 CD_CENTER,
 CD_BASE_LEFT,
 CD_BASE_CENTER,
 CD_BASE_RIGHT
}

enum {                          /* style */
 CD_PLAIN  = 0,
 CD_BOLD   = 1,
 CD_ITALIC = 2,
 CD_UNDERLINE = 4,
 CD_STRIKEOUT = 8
}

enum CD_BOLD_ITALIC = (CD_BOLD|CD_ITALIC);  /* compatibility name */

enum {                          /* some font sizes */
 CD_SMALL    =  8,
 CD_STANDARD = 12,
 CD_LARGE    = 18
}

/* Context Capabilities */
enum CD_CAP_NONE             = 0x0000_0000;
enum CD_CAP_FLUSH            = 0x0000_0001;
enum CD_CAP_CLEAR            = 0x0000_0002;
enum CD_CAP_PLAY             = 0x0000_0004;
enum CD_CAP_YAXIS            = 0x0000_0008;
enum CD_CAP_CLIPAREA         = 0x0000_0010;
enum CD_CAP_CLIPPOLY         = 0x0000_0020;
enum CD_CAP_REGION           = 0x0000_0040;
enum CD_CAP_RECT             = 0x0000_0080;
enum CD_CAP_CHORD            = 0x0000_0100;
enum CD_CAP_IMAGERGB         = 0x0000_0200;
enum CD_CAP_IMAGERGBA        = 0x0000_0400;
enum CD_CAP_IMAGEMAP         = 0x0000_0800;
enum CD_CAP_GETIMAGERGB      = 0x0000_1000;
enum CD_CAP_IMAGESRV         = 0x0000_2000;
enum CD_CAP_BACKGROUND       = 0x0000_4000;
enum CD_CAP_BACKOPACITY      = 0x0000_8000;
enum CD_CAP_WRITEMODE        = 0x0001_0000;
enum CD_CAP_LINESTYLE        = 0x0002_0000;
enum CD_CAP_LINEWITH         = 0x0004_0000;
enum CD_CAP_FPRIMTIVES       = 0x0008_0000;
enum CD_CAP_HATCH            = 0x0010_0000;
enum CD_CAP_STIPPLE          = 0x0020_0000;
enum CD_CAP_PATTERN          = 0x0040_0000;
enum CD_CAP_FONT             = 0x0080_0000;
enum CD_CAP_FONTDIM          = 0x0100_0000;
enum CD_CAP_TEXTSIZE         = 0x0200_0000;
enum CD_CAP_TEXTORIENTATION  = 0x0400_0000;
enum CD_CAP_PALETTE          = 0x0800_0000;
enum CD_CAP_LINECAP          = 0x1000_0000;
enum CD_CAP_LINEJOIN         = 0x2000_0000;
enum CD_CAP_PATH             = 0x4000_0000;
enum CD_CAP_BEZIER           = 0x8000_0000;
enum CD_CAP_ALL              = 0xFFFF_FFFF;

/* Context Types */
enum {
  CD_CTX_WINDOW,
  CD_CTX_DEVICE,
  CD_CTX_IMAGE,
  CD_CTX_FILE
}

/* cdPlay definitions */
enum CD_SIZECB = 0;        /* size callback */
//alias cdSizeCB = int function(cdCanvas* canvas, int w, int h, double w_mm, double h_mm) nothrow;
enum CD_ABORT = 1;
enum CD_CONTINUE = 0;

/* simulation flags */
enum CD_SIM_NONE         = 0x0000;
enum CD_SIM_LINE         = 0x0001;
enum CD_SIM_RECT         = 0x0002;
enum CD_SIM_BOX          = 0x0004;
enum CD_SIM_ARC          = 0x0008;
enum CD_SIM_SECTOR       = 0x0010;
enum CD_SIM_CHORD        = 0x0020;
enum CD_SIM_POLYLINE     = 0x0040;
enum CD_SIM_POLYGON      = 0x0080;
enum CD_SIM_TEXT         = 0x0100;
enum CD_SIM_ALL          = 0xFFFF;

enum CD_SIM_LINES = (CD_SIM_LINE | CD_SIM_RECT | CD_SIM_ARC | CD_SIM_POLYLINE);
enum CD_SIM_FILLS = (CD_SIM_BOX | CD_SIM_SECTOR | CD_SIM_CHORD | CD_SIM_POLYGON);

/* some predefined colors for convenience */
enum  CD_RED           = 0xFF_00_00L;   /* 255,  0,  0 */
enum  CD_DARK_RED      = 0x80_00_00L;   /* 128,  0,  0 */
enum  CD_GREEN         = 0x00_FF_00L;   /*   0,255,  0 */
enum  CD_DARK_GREEN    = 0x00_80_00L;   /*   0,128,  0 */
enum  CD_BLUE          = 0x00_00_FFL;   /*   0,  0,255 */
enum  CD_DARK_BLUE     = 0x00_00_80L;   /*   0,  0,128 */

enum  CD_YELLOW        = 0xFF_FF_00L;   /* 255,255,  0 */
enum  CD_DARK_YELLOW   = 0x80_80_00L;   /* 128,128,  0 */
enum  CD_MAGENTA       = 0xFF_00_FFL;   /* 255,  0,255 */
enum  CD_DARK_MAGENTA  = 0x80_00_80L;   /* 128,  0,128 */
enum  CD_CYAN          = 0x00_FF_FFL;   /*   0,255,255 */
enum  CD_DARK_CYAN     = 0x00_80_80L;   /*   0,128,128 */

enum  CD_WHITE         = 0xFF_FF_FFL;   /* 255,255,255 */
enum  CD_BLACK         = 0x00_00_00L;   /*   0,  0,  0 */

enum  CD_DARK_GRAY     = 0x80_80_80L;   /* 128,128,128 */
enum  CD_GRAY          = 0xC0_C0_C0L;   /* 192,192,192 */

/* some usefull conversion factors */
enum CD_MM2PT     = 2.834645669;   /* milimeters to points (pt = CD_MM2PT * mm) */
enum CD_RAD2DEG  = 57.295779513;   /* radians to degrees (deg = CD_RAD2DEG * rad) */
enum CD_DEG2RAD  = 0.01745329252;  /* degrees to radians (rad = CD_DEG2RAD * deg) */

/* paper sizes */
enum {
  CD_A0,
  CD_A1,
  CD_A2,
  CD_A3,
  CD_A4,
  CD_A5,
  CD_LETTER,
  CD_LEGAL
}



/******************************************************************************
Copyright (C) 1994-2016 Tecgraf/PUC-Rio.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
******************************************************************************/

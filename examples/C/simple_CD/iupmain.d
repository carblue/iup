#!/usr/bin/rdmd @cmdfile
module iupmain;

import core.stdc.config : c_ulong, c_long;
import core.stdc.stdlib;
import core.stdc.stdio;
//#include <memory.h>
import core.stdc.string;

import std.string : toStringz;
import std.stdio; 

import iup.iup;

/*

Simple Draw Application

  Shows the same picture on several canvas. Used to quick test the CD library and
  to demonstrate the use of CD library functions.

  This module uses only the CD library, there is another module to initialize the Window and its menus.

*/

import cd.cd;
import cd.cdcgm;
import cd.cddgn;
import cd.cddxf;
import cd.cdclipbd;
import cd.cdemf;
import cd.cdimage;
import cd.cdirgb;
import cd.cdmf;
import cd.cdprint;
import cd.cdps;
import cd.cdpdf;
import cd.cdsvg;
import cd.cdwmf;
import cd.cdiup;
import cd.cddbuf;
import cd.cddebug;
import cd.wd;
import cd.cdgdiplus;

version(USE_OPENGL)
{
import cd.cdgl;
import iup.iupgl;

// For core API functions.
import derelict.opengl3.gl3;
import derelict.opengl3.gl;
}

/* Global variables */

cdCanvas *winCanvas = null;        /* The window drawing canvas */
char* winData = null;
cdCanvas *dbCanvas = null;        /* The double buffer canvas */
cdCanvas *curCanvas = null;        /* The current canvas */

int clipping = CD_CLIPOFF;                     /* Clipping flag, same as the CD */
int write_mode = CD_REPLACE;                   /* Write Mode flag, same as the CD */
int contextplus = 0;
int simple_draw = 0;
int use_transform = 0;
int simulate = 0;
int use_opengl = 0;

enum {DRAW_ALL, DRAW_TEXTFONTS, DRAW_TEXTALIGN, DRAW_TEST};

enum STYLE_SIZE = 10; /* A small pattern and stipple size */
c_long[STYLE_SIZE*STYLE_SIZE] pattern;          /* Pattern buffer */
ubyte[STYLE_SIZE*STYLE_SIZE] stipple; /* Stipple buffer */

enum IMAGE_SIZE = 100;
ubyte[IMAGE_SIZE*IMAGE_SIZE] red;       /* Red image buffer */
ubyte[IMAGE_SIZE*IMAGE_SIZE] green;     /* Green image buffer */
ubyte[IMAGE_SIZE*IMAGE_SIZE] blue;      /* Blue image buffer */
ubyte[IMAGE_SIZE*IMAGE_SIZE] alpha;     /* Alpha image buffer */


/* Prototype of the function that makes the drawing independent of canvas. */
void SimpleDraw(cdCanvas* canvas);

void SimpleInitAlpha(int width, int height, ubyte* _alpha)
{
  int c, l;
  /* initialize the alpha image buffer with a degrade from transparent to opaque */
  for (l = 0; l < height; l++)
    for (c = 0; c < width; c++)
      _alpha[l*width + c] = cast(ubyte)((c*255)/(width-1));
}

void SimpleCreateCanvasWindow()
{
  /* creates the canvas based in an existing window */
  if (contextplus) cdUseContextPlus(1);
  winCanvas = cdCreateCanvas(CD_IUP, winData);
  if (contextplus) cdUseContextPlus(0);
  curCanvas = winCanvas;
}

void SimpleCreateCanvas(char* data)
{
  int c, l;

  memset(pattern.ptr, 0xFF, STYLE_SIZE*STYLE_SIZE*4);

  pattern[11] = CD_RED;   /*------------*/
  pattern[21] = CD_RED;   /*  0123456789*/               
  pattern[31] = CD_RED;   /*            */               
  pattern[41] = CD_RED;   /*9 WWWWWWWWWW*/               
  pattern[51] = CD_RED;   /*8 WWWWGGGGGW*/               
  pattern[12] = CD_RED;   /*7 WWWGGGGGBW*/                                         
  pattern[22] = CD_RED;   /*6 WWGGGGGBBW*/                                         
  pattern[32] = CD_RED;   /*5 WrrrrrBBBW*/                                         
  pattern[42] = CD_RED;   /*4 WrrrrrBBBW*/                                         
  pattern[52] = CD_RED;   /*3 WrrrrrBBWW*/                                         
  pattern[13] = CD_RED;   /*2 WrrrrrBWWW*/                                         
  pattern[23] = CD_RED;   /*1 WrrrrrWWWW*/                                         
  pattern[33] = CD_RED;   /*0 WWWWWWWWWW*/                                         
  pattern[43] = CD_RED;   /*------------*/                                         
  pattern[53] = CD_RED;                                            
  pattern[14] = CD_RED;   pattern[15] = CD_RED;
  pattern[24] = CD_RED;   pattern[25] = CD_RED;
  pattern[34] = CD_RED;   pattern[35] = CD_RED;
  pattern[44] = CD_RED;   pattern[45] = CD_RED;
  pattern[54] = CD_RED;   pattern[55] = CD_RED;
  
  pattern[26] = CD_BLUE;  pattern[37] = CD_BLUE;
  pattern[36] = CD_BLUE;  pattern[47] = CD_BLUE;
  pattern[46] = CD_BLUE;  pattern[57] = CD_BLUE;
  pattern[56] = CD_BLUE;  pattern[67] = CD_BLUE;
  
  pattern[48] = CD_BLUE;  pattern[62] = CD_GREEN;
  pattern[58] = CD_BLUE;  pattern[63] = CD_GREEN;
  pattern[68] = CD_BLUE;  pattern[64] = CD_GREEN;
  pattern[78] = CD_BLUE;  pattern[65] = CD_GREEN;
                               pattern[66] = CD_GREEN;

  pattern[73] = CD_GREEN; pattern[84] = CD_GREEN;
  pattern[74] = CD_GREEN; pattern[85] = CD_GREEN;
  pattern[75] = CD_GREEN; pattern[86] = CD_GREEN;
  pattern[76] = CD_GREEN; pattern[87] = CD_GREEN;
  pattern[77] = CD_GREEN; pattern[88] = CD_GREEN;

  /* initialize the stipple buffer with cross pattern */
  for (l = 0; l < STYLE_SIZE; l++)
    for (c = 0; c < STYLE_SIZE; c++)
      stipple[l*STYLE_SIZE + c] = (c % 4) == 0? 1: 0;

  SimpleInitAlpha(IMAGE_SIZE, IMAGE_SIZE, alpha.ptr);

  winData = data;
  SimpleCreateCanvasWindow();
  SimpleDrawWindow();
}

int SimpleTransform()
{
  use_transform = !use_transform;
  SimpleDraw(curCanvas);
  return 0;
}

int SimpleContextPlus()
{
//#ifdef USE_CONTEXTPLUS
  contextplus = !contextplus;
  SimpleKillCanvas();
  SimpleCreateCanvasWindow();
  SimpleDraw(curCanvas);
//#endif
  return 0;
}

void PlayCanvasDriver(cdContext* ctx, char* StrData)
{
  int w, h;
  cdCanvasActivate(curCanvas);
  cdCanvasBackground(curCanvas, CD_WHITE);
  cdCanvasClear(curCanvas);
  cdCanvasGetSize(curCanvas, &w, &h, null, null);
  cdCanvasPlay(curCanvas, ctx, 100, w-100, 100, h-100, StrData);
//  cdCanvasPlay(curCanvas, ctx, 0, 0, 0, 0, StrData);
}

int SimplePlayClipboard()
{
  PlayCanvasDriver(CD_CLIPBOARD, null);
  return 0;
}

int SimplePlayCGMBin()
{
  PlayCanvasDriver(CD_CGM, "simple_b.cgm".dup.ptr);
  return 0;
}

int SimplePlayCGMText()
{
  PlayCanvasDriver(CD_CGM, "simple_t.cgm".dup.ptr);
  return 0;
}

int SimplePlayMetafile()
{
  PlayCanvasDriver(CD_METAFILE, "simple.mf".dup.ptr);
  return 0;
}

int SimplePlayWMF()
{
  PlayCanvasDriver(CD_WMF, "simple.wmf".dup.ptr);
  return 0;
}

int SimplePlayEMF()
{
  PlayCanvasDriver(CD_EMF, "simple.emf".dup.ptr);
  return 0;
}

int SimpleRepaint()
{
  SimpleDraw(curCanvas);
  return 0;
}

int SimpleDrawWindow()
{
  use_opengl = 0;
  curCanvas = winCanvas;
  SimpleDraw(curCanvas);
  return 0;
}

void DrawCanvasDriver(cdContext* ctx, char* StrData)
{
  cdCanvas* tmpCanvas = cdCreateCanvas(ctx, StrData);
  if (tmpCanvas == null) 
  {
    printf("CreateCanvas(%s) - Failed!\n", StrData);
    return;
  }
  printf("CreateCanvas(%s)\n", StrData);
  SimpleDraw(tmpCanvas);
  cdKillCanvas(tmpCanvas);
  printf("KillCanvas()\n");
}

void DrawCanvasDriverSize(cdContext* ctx, char* name, int pixels)
{
  char[100] StrData;
  int w, h;
  double w_mm, h_mm;
  cdCanvasGetSize(curCanvas, &w, &h, &w_mm, &h_mm);
  if (pixels == 1)
    sprintf(StrData.ptr, "%s %dx%d", name, w, h);
  else if (pixels == 2)
    sprintf(StrData.ptr, "%s -w%g -h%g -s%g", name, w_mm, h_mm, (cast(double)w/w_mm)*25.4);
  else
    sprintf(StrData.ptr, "%s %gx%g %g", name, w_mm, h_mm, cast(double)w/w_mm);
  DrawCanvasDriver(ctx, StrData.ptr);
}

void DrawCanvasDriverSizeParam(cdContext* ctx, char* param)
{
  char[100] StrData;
  int w, h;
  cdCanvasGetSize(curCanvas, &w, &h, null, null);
  sprintf(StrData.ptr, "%dx%d %s", w, h, param);
  DrawCanvasDriver(ctx, StrData.ptr);
}

int SimpleDrawDebug()
{
  DrawCanvasDriverSize(CD_DEBUG, "simple_debug.txt".dup.ptr, 0);
  return 0;
}

int SimpleDrawCGMText()
{
  DrawCanvasDriverSize(CD_CGM, "simple_t.cgm -t".dup.ptr, 0);
  return 0;
}

int SimpleDrawCGMBin()
{
  DrawCanvasDriverSize(CD_CGM, "simple_b.cgm".dup.ptr, 0);
  return 0;
}

int SimpleDrawDXF()
{
  DrawCanvasDriverSize(CD_DXF, "simple.dxf".dup.ptr, 0);
  return 0;
}

int SimpleDrawDGN()
{
  DrawCanvasDriverSize(CD_DGN, "simple.dgn".dup.ptr, 0);
  return 0;
}

int SimpleDrawEMF()
{
  if (contextplus) cdUseContextPlus(1);
  DrawCanvasDriverSize(CD_EMF, "simple.emf".dup.ptr, 1);
  if (contextplus) cdUseContextPlus(0);
  return 0;
}

int SimpleDrawMetafile()
{
  DrawCanvasDriverSize(CD_METAFILE, "simple.mf".dup.ptr, 0);
  return 0;
}

int SimpleDrawPS()
{
  DrawCanvasDriverSize(CD_PS, "simple.ps -l0 -r0 -t0 -b0".dup.ptr, 2);
  return 0;
}

int SimpleDrawSVG()
{
  DrawCanvasDriverSize(CD_SVG, "simple.svg".dup.ptr, 0);
  return 0;
}

int SimpleDrawPDF()
{
  DrawCanvasDriverSize(CD_PDF, "simple.pdf".dup.ptr, 2);
  return 0;
}

int SimpleDrawEPS()
{
  DrawCanvasDriverSize(CD_PS, "simple.eps -e".dup.ptr, 2);
  return 0;
}

int SimpleDrawWMF()
{
  DrawCanvasDriverSize(CD_WMF, "simple.wmf".dup.ptr, 1);
  return 0;
}

int SimpleDrawPrint()
{
  if (contextplus) cdUseContextPlus(1);
  DrawCanvasDriver(CD_PRINTER, "simple print".dup.ptr);
  if (contextplus) cdUseContextPlus(0);
  return 0;
}

int SimpleDrawPrintDialog()
{
  if (contextplus) cdUseContextPlus(1);
  DrawCanvasDriver(CD_PRINTER, "simple -d".dup.ptr);   /* show dialog */
  if (contextplus) cdUseContextPlus(0);
  return 0;
}

int SimpleDrawClipboardBitmap()
{
  if (contextplus) cdUseContextPlus(1);
  DrawCanvasDriverSizeParam(CD_CLIPBOARD, "-b".dup.ptr);
  if (contextplus) cdUseContextPlus(0);
  return 0;
}

int SimpleDrawClipboardMetafile()
{
  if (contextplus) cdUseContextPlus(1);
  DrawCanvasDriverSizeParam(CD_CLIPBOARD, "-m".dup.ptr);
  if (contextplus) cdUseContextPlus(0);
  return 0;
}

int SimpleDrawClipboardEMF()
{
  if (contextplus) cdUseContextPlus(1);
  DrawCanvasDriverSizeParam(CD_CLIPBOARD, "".dup.ptr);
  if (contextplus) cdUseContextPlus(0);
  return 0;
}

int SimpleReplace()
{
  write_mode = CD_REPLACE;
  SimpleDraw(curCanvas);
  return 0;
}

int SimpleXor()
{
  write_mode = CD_XOR;
  SimpleDraw(curCanvas);
  return 0;
}

int SimpleNotXor()
{
  write_mode = CD_NOT_XOR;
  SimpleDraw(curCanvas);
  return 0;
}

int SimpleClippingOff()
{
  clipping = CD_CLIPOFF;
  SimpleDraw(curCanvas);
  return 0;
}

int SimpleClippingArea()
{
  clipping = CD_CLIPAREA;
  SimpleDraw(curCanvas);
  return 0;
}

int SimpleClippingPolygon()
{
  clipping = CD_CLIPPOLYGON;
  SimpleDraw(curCanvas);
  return 0;
}

int SimpleClippingRegion()
{
  clipping = CD_CLIPREGION;
  SimpleDraw(curCanvas);
  return 0;
}

int SimpleAll()
{
  simple_draw = DRAW_ALL;
  SimpleDraw(curCanvas);
  return 0;
}

int SimpleTextAlign()
{
  simple_draw = DRAW_TEXTALIGN;
  SimpleDraw(curCanvas);
  return 0;
}

int SimpleTextFonts()
{
  simple_draw = DRAW_TEXTFONTS;
  SimpleDraw(curCanvas);
  return 0;
}

int SimpleTest()
{
  simple_draw = DRAW_TEST;
  SimpleDraw(curCanvas);
  return 0;
}

void* CreateImageRGBA(int w, int h)
{
  void* myImage;
  ubyte* _alpha = cast(ubyte*)malloc(w * h);
  SimpleInitAlpha(w, h, _alpha);
  cdCanvasSetAttribute(curCanvas, "IMAGEALPHA", cast(char*)_alpha);
  cdCanvasSetAttribute(curCanvas, "IMAGEFORMAT".toStringz, "32".dup.ptr);    // afetara� o proximo cdCreateImage
  myImage = cdCanvasCreateImage(curCanvas, w, h);
  cdCanvasSetAttribute(curCanvas, "IMAGEFORMAT", null);    // remove o atributo para nao afetar outros cdCreateImage
  return myImage;
}

int SimpleDrawImage()
{
  use_opengl = 0;
  if (dbCanvas) cdKillCanvas(dbCanvas);

  if (contextplus) cdUseContextPlus(1);
  dbCanvas = cdCreateCanvas(CD_DBUFFER, winCanvas);
  if (contextplus) cdUseContextPlus(0);

  curCanvas = dbCanvas;
  SimpleDraw(curCanvas);

  return 0;
}

int SimpleDrawImageRGB()
{
  use_opengl = 0;
  if (dbCanvas) cdKillCanvas(dbCanvas);

  if (contextplus) cdUseContextPlus(1);
  dbCanvas = cdCreateCanvas(CD_DBUFFERRGB, winCanvas);
  if (contextplus) cdUseContextPlus(0);

  curCanvas = dbCanvas;
  SimpleDraw(curCanvas);

  return 0;
}

version(USE_OPENGL) {
//#ifdef USE_OPENGL
int SimpleDrawGL()
{
  char[100] StrData;
  int w, h;
  double w_mm, h_mm;

  if (use_opengl)
    return 0;

  cdCanvasGetSize(curCanvas, &w, &h, &w_mm, &h_mm);

  sprintf(StrData.ptr, "%dx%d %g", w, h, (cast(double)w/w_mm));

  if (dbCanvas) cdKillCanvas(dbCanvas);

  dbCanvas = cdCreateCanvas(CD_GL, StrData.ptr);

  curCanvas = dbCanvas;
  use_opengl = 1;
  SimpleDraw(curCanvas);

  return 0;
}
//#endif
} // version(USE_OPENGL)

int SimpleDrawSimulate()
{
  simulate = !simulate;

  if (simulate)
    cdCanvasSimulate(curCanvas, CD_SIM_ALL);
  else
    cdCanvasSimulate(curCanvas, CD_SIM_NONE);

  SimpleDraw(curCanvas);

  return 0;
}

void SimpleKillCanvas()
{
  if (dbCanvas)
  {
    cdKillCanvas(dbCanvas);
    dbCanvas = null;
  }
  if (winCanvas)
  {
    cdKillCanvas(winCanvas);
    winCanvas = null;
  }
}

void SimpleDrawTextFonts(cdCanvas* canvas);
void SimpleDrawTextAlign(cdCanvas* canvas);
void SimpleDrawAll(cdCanvas* canvas);
void SimpleDrawTest(cdCanvas* canvas);

void SimpleDraw(cdCanvas* canvas)
{
version(USE_OPENGL)
{
//#ifdef USE_OPENGL
  if (use_opengl)
    SimpleUpdateSize(canvas);
//#endif
}
  if (simple_draw == DRAW_TEXTFONTS)
    SimpleDrawTextFonts(canvas);
  else if (simple_draw == DRAW_TEXTALIGN)
    SimpleDrawTextAlign(canvas);
  else if (simple_draw == DRAW_TEST)
    SimpleDrawTest(canvas);
  else
    SimpleDrawAll(canvas);

  cdCanvasFlush(canvas);

version(USE_OPENGL)
{
//#ifdef USE_OPENGL
  if (use_opengl)
    SimpleFlush();
//#endif
}
}

void SimpleDrawAll(cdCanvas* canvas)
{
  int w, h;
  cdCanvasGetSize(canvas, &w, &h, null, null);
  
  /* Clear the background to be white */
  cdCanvasBackground(canvas, CD_WHITE);
//  cdBackground(CD_GREEN);
  cdCanvasClear(canvas);

  /* Draw a reactangle and a polyline at the bottom-left area,
     using a thick line with transparency.
     Observe that transparency is only supported in a few drivers,
     and line join is not supported in the IMAGERGB driver. */
  cdCanvasLineWidth(canvas, 3);
  cdCanvasLineStyle(canvas, CD_CONTINUOUS);
  cdCanvasForeground(canvas, cdEncodeAlpha(CD_DARK_MAGENTA, 128));
  cdCanvasRect(canvas, 100, 200, 100, 200);

  cdCanvasBegin(canvas, CD_OPEN_LINES);
  cdCanvasVertex(canvas, 300, 250);
  cdCanvasVertex(canvas, 320, 270);
  cdCanvasVertex(canvas, 350, 260);
  cdCanvasVertex(canvas, 340, 200);
  cdCanvasVertex(canvas, 310, 210);
  cdCanvasEnd(canvas);
  
  /* Draw the red diagonal line with a custom line style. 
     Observe that line styles are not supported in the IMAGERGB driver. */
  cdCanvasForeground(canvas, CD_RED);
  cdCanvasLineWidth(canvas, 3);
  {
    int[4] dashes = [20, 15, 5, 5];
    cdCanvasLineStyleDashes(canvas, dashes.ptr, 4);
  }
  cdCanvasLineStyle(canvas, CD_CUSTOM);
  cdCanvasLine(canvas, 0, 0, w-1, h-1);

  /* Draw the blue diagonal line with a pre-defined line style.
     Observe that the pre-defined line style is dependent on the driver. */
  cdCanvasForeground(canvas, CD_BLUE);
  cdCanvasLineWidth(canvas, 10);
  cdCanvasLineStyle(canvas, CD_DOTTED);
  cdCanvasLine(canvas, 0, h-1, w-1, 0);

  switch(clipping)
  {
  case CD_CLIPOFF:
    cdCanvasClip(canvas, CD_CLIPOFF);
    break;
  case CD_CLIPAREA:
    /* Defines the clipping area equals the canvas area minus a 100 pixels margin. */
    cdCanvasClipArea(canvas, 100, w - 100, 100, h - 100);
    cdCanvasClip(canvas, CD_CLIPAREA);
    break;
  case CD_CLIPPOLYGON:
    cdCanvasBegin(canvas, CD_CLIP);
    cdCanvasVertex(canvas, 100, 100);
    cdCanvasVertex(canvas, w - 100, 100);
    cdCanvasVertex(canvas, w / 2, h - 100);
    cdCanvasEnd(canvas);
    cdCanvasClip(canvas, CD_CLIPPOLYGON);
    break;
  case CD_CLIPREGION:
    cdCanvasTextAlignment(canvas, CD_CENTER);
    cdCanvasFont(canvas, "Times", CD_BOLD, 50);

    cdCanvasBegin(canvas, CD_REGION);
    cdCanvasRegionCombineMode(canvas, CD_UNION);
    cdCanvasBox(canvas, 100, 200, 100, 200);
    cdCanvasSector(canvas, w/2-50, h/2+50, 150, 150, 0, 360);
    cdCanvasSector(canvas, w/2-50, h/2-50, 150, 150, 0, 360);
    cdCanvasSector(canvas, w/2+50, h/2+50, 150, 150, 0, 360);
    cdCanvasSector(canvas, w/2+50, h/2-50, 150, 150, 0, 360);
    cdCanvasRegionCombineMode(canvas, CD_DIFFERENCE); 
    cdCanvasText(canvas, w/2, h/2, "TEXT");
    cdCanvasEnd(canvas);
//    cdCanvasOffsetRegion(canvas, -50, 50);
    cdCanvasClip(canvas, CD_CLIPREGION);

    cdCanvasForeground(canvas, CD_DARK_RED);
    cdCanvasBox(canvas, 0,w,0,h);
    break;
  default: assert(0);
  }

  switch(write_mode)
  {
  case CD_REPLACE:
    cdCanvasWriteMode(canvas, CD_REPLACE);
    break;
  case CD_XOR:
    cdCanvasWriteMode(canvas, CD_XOR);
    break;
  case CD_NOT_XOR:
    cdCanvasWriteMode(canvas, CD_NOT_XOR);
    break;
  default: assert(0);
  }

  if (use_transform)
  {
    cdCanvasTransform(canvas, null);
    cdCanvasTransformTranslate(canvas, w/2, h/2);
    cdCanvasTransformRotate(canvas, 30);
    cdCanvasTransformScale(canvas, 0.5, 0.5);
    cdCanvasTransformTranslate(canvas, -w/2, -h/2);
  }

//  cdSetfAttribute("ROTATE", "15 %d %d", w/2, h/2);

  /* Reset line style and width */
  cdCanvasLineStyle(canvas, CD_CONTINUOUS);
  cdCanvasLineWidth(canvas, 1);
//  cdBackOpacity(CD_TRANSPARENT); 
                   
  /* Draw an arc at bottom-left, and a sector at bottom-right.
     Notice that counter-clockwise orientation of both. */
  cdCanvasInteriorStyle(canvas, CD_SOLID);
  cdCanvasForeground(canvas, CD_MAGENTA);
  cdCanvasSector(canvas, w-100, 100, 100, 100, 50, 180);
  cdCanvasForeground(canvas, CD_RED);
  cdCanvasArc(canvas, 100, 100, 100, 100, 50, 180);

  /* Draw a solid filled rectangle at center. */
  cdCanvasForeground(canvas, CD_YELLOW);
  cdCanvasBox(canvas, w/2 - 100, w/2 + 100, h/2 - 100, h/2 + 100); 

  /* Prepare font for text. */
  cdCanvasTextAlignment(canvas, CD_CENTER);
  cdCanvasTextOrientation(canvas, 70);
  cdCanvasFont(canvas, "Times", CD_BOLD, 24);

  /* Draw text at center, with orientation, 
     and draw its bounding box. 
     Notice that in some drivers the bounding box is not precise. */
  {
    int[8] rect;
    cdCanvasGetTextBounds(canvas, w/2, h/2, "cdMin Draw (���)", rect.ptr);
    cdCanvasForeground(canvas, CD_RED);
    cdCanvasBegin(canvas, CD_CLOSED_LINES);
    cdCanvasVertex(canvas, rect[0], rect[1]);
    cdCanvasVertex(canvas, rect[2], rect[3]);
    cdCanvasVertex(canvas, rect[4], rect[5]);
    cdCanvasVertex(canvas, rect[6], rect[7]);
    cdCanvasEnd(canvas);
  }
  cdCanvasForeground(canvas, CD_BLUE);
  cdCanvasText(canvas, w/2, h/2, "cdMin Draw (���)");
  cdCanvasTextOrientation(canvas, 0);

  /* Prepare World Coordinates */
  wdCanvasViewport(canvas, 0,w-1,0,h-1);
  if (w>h)
    wdCanvasWindow(canvas, 0,cast(double)w/cast(double)h,0,1);
  else
    wdCanvasWindow(canvas, 0,1,0,cast(double)h/cast(double)w);

  /* Draw a filled blue rectangle in WC */
  wdCanvasBox(canvas, 0.20, 0.30, 0.40, 0.50);
  cdCanvasForeground(canvas, CD_RED);
  /* Draw the diagonal of that rectangle in WC */
  wdCanvasLine(canvas, 0.20, 0.40, 0.30, 0.50);

//  wdVectorTextDirection(0, 0, 1, 1);
  /* Prepare Vector Text in WC. */
  wdCanvasVectorCharSize(canvas, 0.07);

//  wdVectorText(0.1, 0.4, "�� ����� ����� ����� �����");
//  wdVectorText(0.1, 0.2, "�� ����� ����� ����� �����");
  //{
  //  int i;
  //  char t[2];
  //  char s[10];
  //  int x = 20;
  //  int y = 0;
  //  t[1] = 0;
  //  for (i = 0; i < 256; i++)
  //  {
  //    int dx = 90;
  //    t[0] = (char)i;
  //    sprintf(s, "%d", i);
  //    cdText(x, y, s);
  //    cdText(x+dx, y, t);
  //    cdVectorText(x+2*dx, y, t);
  //    
  //    x += 3*dx + 2*dx/3;
  //    if ((i+1) % 7 == 0)
  //    {
  //      x = 20;
  //      y += 90;
  //    }

  //  }
  //}

  /* Draw vector text, and draw its bounding box. 
     We also use this text to show when we are using a contextplus driver. */
  {
    double[8] rect;
    cdCanvasForeground(canvas, CD_RED);
    if (contextplus)
      wdCanvasGetVectorTextBounds(canvas, "WDj-Plus", 0.25, 0.35, rect.ptr);
    else
      wdCanvasGetVectorTextBounds(canvas, "WDj", 0.25, 0.35, rect.ptr);
    cdCanvasBegin(canvas, CD_CLOSED_LINES);
    wdCanvasVertex(canvas, rect[0], rect[1]);
    wdCanvasVertex(canvas, rect[2], rect[3]);
    wdCanvasVertex(canvas, rect[4], rect[5]);
    wdCanvasVertex(canvas, rect[6], rect[7]);
    cdCanvasEnd(canvas);

    cdCanvasLineWidth(canvas, 2);
    cdCanvasLineStyle(canvas, CD_CONTINUOUS);
    if (contextplus)
      wdCanvasVectorText(canvas, 0.25, 0.35, "WDj-Plus");
    else
      wdCanvasVectorText(canvas, 0.25, 0.35, "WDj");
    cdCanvasLineWidth(canvas, 1);
  }

  /* Draw a filled path at center-right (looks like a weird fish). 
     Notice that in PDF the arc is necessarily a circle arc, and not an ellipse. */
  cdCanvasForeground(canvas, CD_GREEN);
  cdCanvasBegin(canvas, CD_PATH);
  cdCanvasPathSet(canvas, CD_PATH_MOVETO);
  cdCanvasVertex(canvas, w/2 + 200, h/2);
  cdCanvasPathSet(canvas, CD_PATH_LINETO);
  cdCanvasVertex(canvas, w/2 + 230, h/2 + 50);
  cdCanvasPathSet(canvas, CD_PATH_LINETO);
  cdCanvasVertex(canvas, w/2 + 250, h/2 + 50);
  cdCanvasPathSet(canvas, CD_PATH_CURVETO);
  cdCanvasVertex(canvas, w/2+150+150, h/2+200-50); /* control point for start */
  cdCanvasVertex(canvas, w/2+150+180, h/2+250-50); /* control point for end */
  cdCanvasVertex(canvas, w/2+150+180, h/2+200-50); /* end point */
  cdCanvasPathSet(canvas, CD_PATH_CURVETO);
  cdCanvasVertex(canvas, w/2+150+180, h/2+150-50); 
  cdCanvasVertex(canvas, w/2+150+150, h/2+100-50); 
  cdCanvasVertex(canvas, w/2+150+300, h/2+100-50); 
  cdCanvasPathSet(canvas, CD_PATH_LINETO);
  cdCanvasVertex(canvas, w/2+150+300, h/2-50);
  cdCanvasPathSet(canvas, CD_PATH_ARC);
  cdCanvasVertex(canvas, w/2+300, h/2);  /* center */
  cdCanvasVertex(canvas, 200, 100);  /* width, height */
  cdCanvasVertex(canvas, -30*1000, -170*1000);  /* start angle, end angle (degrees / 1000) */
//  cdCanvasPathSet(canvas, CD_PATH_CLOSE);
//  cdCanvasPathSet(canvas, CD_PATH_STROKE);
  cdCanvasPathSet(canvas, CD_PATH_FILL);
//  cdCanvasPathSet(canvas, CD_PATH_FILLSTROKE);
  cdCanvasEnd(canvas);

  /* Draw 3 pixels at center left. */
  cdCanvasPixel(canvas, 10, h/2+0, CD_RED);
  cdCanvasPixel(canvas, 11, h/2+1, CD_GREEN);
  cdCanvasPixel(canvas, 12, h/2+2, CD_BLUE);

  /* Draw 4 mark types, distributed near each corner.  */
  cdCanvasForeground(canvas, CD_RED);
  cdCanvasMarkSize(canvas, 30);
  cdCanvasMarkType(canvas, CD_PLUS);
  cdCanvasMark(canvas, 200, 200);
  cdCanvasMarkType(canvas, CD_CIRCLE);
  cdCanvasMark(canvas, w - 200, 200);
  cdCanvasMarkType(canvas, CD_HOLLOW_CIRCLE);
  cdCanvasMark(canvas, 200, h - 200);
  cdCanvasMarkType(canvas, CD_DIAMOND);
  cdCanvasMark(canvas, w - 200, h - 200);

  /* Draw all the line style possibilities at bottom. 
     Notice that they have some small differences between drivers. */
  cdCanvasLineWidth(canvas, 1);
  cdCanvasLineStyle(canvas, CD_CONTINUOUS);
  cdCanvasLine(canvas, 0, 10, w, 10);
  cdCanvasLineStyle(canvas, CD_DASHED);
  cdCanvasLine(canvas, 0, 20, w, 20);
  cdCanvasLineStyle(canvas, CD_DOTTED);
  cdCanvasLine(canvas, 0, 30, w, 30);
  cdCanvasLineStyle(canvas, CD_DASH_DOT);
  cdCanvasLine(canvas, 0, 40, w, 40);
  cdCanvasLineStyle(canvas, CD_DASH_DOT_DOT);
  cdCanvasLine(canvas, 0, 50, w, 50);

  /* Draw all the hatch style possibilities in the top-left corner.
     Notice that they have some small differences between drivers. */
  cdCanvasHatch(canvas, CD_VERTICAL); 
  cdCanvasBox(canvas, 0, 50, h - 60, h);
  cdCanvasHatch(canvas, CD_FDIAGONAL); 
  cdCanvasBox(canvas, 50, 100, h - 60, h);
  cdCanvasHatch(canvas, CD_BDIAGONAL); 
  cdCanvasBox(canvas, 100, 150, h - 60, h);
  cdCanvasHatch(canvas, CD_CROSS); 
  cdCanvasBox(canvas, 150, 200, h - 60, h);
  cdCanvasHatch(canvas, CD_HORIZONTAL); 
  cdCanvasBox(canvas, 200, 250, h - 60, h);
  cdCanvasHatch(canvas, CD_DIAGCROSS); 
  cdCanvasBox(canvas, 250, 300, h - 60, h);

  /* Draw 4 regions, in diamond shape,
     at top, bottom, left, right, 
     using different interior styles. */

  /* At top, not filled polygon, notice that the last line style is used. */
  cdCanvasBegin(canvas, CD_CLOSED_LINES);
  cdCanvasVertex(canvas, w/2, h - 100); 
  cdCanvasVertex(canvas, w/2 + 50, h - 150); 
  cdCanvasVertex(canvas, w/2, h - 200); 
  cdCanvasVertex(canvas, w/2 - 50, h - 150); 
  cdCanvasEnd(canvas);

  /* At left, hatch filled polygon */
  cdCanvasHatch(canvas, CD_DIAGCROSS); 
  cdCanvasBegin(canvas, CD_FILL);
  cdCanvasVertex(canvas, 100, h/2); 
  cdCanvasVertex(canvas, 150, h/2 + 50); 
  cdCanvasVertex(canvas, 200, h/2); 
  cdCanvasVertex(canvas, 150, h/2 - 50); 
  cdCanvasEnd(canvas);

  /* At right, pattern filled polygon */
  cdCanvasPattern(canvas, STYLE_SIZE, STYLE_SIZE, pattern.ptr);
  cdCanvasBegin(canvas, CD_FILL);
  cdCanvasVertex(canvas, w - 100, h/2); 
  cdCanvasVertex(canvas, w - 150, h/2 + 50); 
  cdCanvasVertex(canvas, w - 200, h/2); 
  cdCanvasVertex(canvas, w - 150, h/2 - 50); 
  cdCanvasEnd(canvas);
  
  /* At bottom, stipple filled polygon */
  cdCanvasStipple(canvas, STYLE_SIZE, STYLE_SIZE, stipple.ptr);
  cdCanvasBegin(canvas, CD_FILL);
  cdCanvasVertex(canvas, w/2, 100); 
  cdCanvasVertex(canvas, w/2 + 50, 150); 
  cdCanvasVertex(canvas, w/2, 200); 
  cdCanvasVertex(canvas, w/2 - 50, 150); 
  cdCanvasEnd(canvas);

  /* Draw two beziers at bottom-left */
  cdCanvasBegin(canvas, CD_BEZIER);
  cdCanvasVertex(canvas, 100, 100); 
  cdCanvasVertex(canvas, 150, 200); 
  cdCanvasVertex(canvas, 180, 250); 
  cdCanvasVertex(canvas, 180, 200); 
  cdCanvasVertex(canvas, 180, 150); 
  cdCanvasVertex(canvas, 150, 100); 
  cdCanvasVertex(canvas, 300, 100); 
  cdCanvasEnd(canvas);

  /* Initialize the image buffer contents */
//#define IMAGE_SIZE 16
  memset(red.ptr, 0xFF, IMAGE_SIZE*IMAGE_SIZE/2);
  memset(green.ptr, 0x5F, IMAGE_SIZE*IMAGE_SIZE/2);
  memset(blue.ptr, 0x5F, IMAGE_SIZE*IMAGE_SIZE/2);
  memset(red.ptr+IMAGE_SIZE*IMAGE_SIZE/2, 0x5F, IMAGE_SIZE*IMAGE_SIZE/2);
  memset(green.ptr+IMAGE_SIZE*IMAGE_SIZE/2, 0x8F, IMAGE_SIZE*IMAGE_SIZE/2);
  memset(blue.ptr+IMAGE_SIZE*IMAGE_SIZE/2, 0x5F, IMAGE_SIZE*IMAGE_SIZE/2);
  memset(red.ptr+IMAGE_SIZE*(IMAGE_SIZE-1), 0, IMAGE_SIZE);
  memset(green.ptr+IMAGE_SIZE*(IMAGE_SIZE-1), 0, IMAGE_SIZE);
  memset(blue.ptr+IMAGE_SIZE*(IMAGE_SIZE-1), 0, IMAGE_SIZE);
  memset(red.ptr, 0, IMAGE_SIZE);
  memset(green.ptr, 0, IMAGE_SIZE);
  memset(blue.ptr, 0, IMAGE_SIZE);
  {
    int i, offset;
    for (i = 0; i < IMAGE_SIZE; i++)
    {
      offset = i*IMAGE_SIZE;
      red[offset] = 0;
      green[offset] = 0;
      blue[offset] = 0;
      red[offset+IMAGE_SIZE-1] = 0;
      green[offset+IMAGE_SIZE-1] = 0;
      blue[offset+IMAGE_SIZE-1] = 0;
    }
  }

  //cdSetAttribute("ANTIALIAS", "0");
//  cdGetImageRGB(red, green, blue, w/2 - 50, h/2-50, 100, 100);
//  cdPutImageRectRGB(14, 13, red, green, blue, -20, -15, 649, 603, 0, 13, 0, 12);
//  cdPutImageRectRGB(16, 16, red, green, blue, 10, 10, 608, 608, 5, 10, 5, 10);
//  cdPutImageRectRGB(16, 16, red, green, blue, 10, 10, 64, 64, 5, 10, 5, 10);

//  cdPutImageRGB(IMAGE_SIZE, IMAGE_SIZE, red, green, blue, 100, h - 200, IMAGE_SIZE, IMAGE_SIZE);
//  cdPutImageRGBA(IMAGE_SIZE, IMAGE_SIZE, red, green, blue, alpha, 100, h - 200, IMAGE_SIZE, IMAGE_SIZE);
//  cdPutImageRGB(IMAGE_SIZE, IMAGE_SIZE, red, green, blue, w - 400, h - 310, 3*IMAGE_SIZE, 3*IMAGE_SIZE);
  /* Draw the image on the top-right corner but increasing its actual size, and uses its full area */
  cdCanvasPutImageRectRGBA(canvas, IMAGE_SIZE, IMAGE_SIZE, red.ptr, green.ptr, blue.ptr, alpha.ptr, w - 400, h - 310, 3*IMAGE_SIZE, 3*IMAGE_SIZE, 0, 0, 0, 0);

  cdCanvasSetAttribute(canvas, "ROTATE", null);
  if (use_transform)
    cdCanvasTransform(canvas, null);
  cdCanvasClip(canvas, CD_CLIPOFF);

  /* Adds a new page, or 
     flushes the file, or
     flushes the screen, or
     swap the double buffer. */
  cdCanvasFlush(canvas);
}

void DrawVectorTextBox(cdCanvas* canvas, int x, int y, char* text)
{
  int[8] rect;
  int draw_box;

  cdCanvasLineWidth(canvas, 1);
  cdCanvasLineStyle(canvas, CD_CONTINUOUS);

  draw_box = 0;
  if (draw_box)
  {
    int xmin, xmax, ymin, ymax;
    cdCanvasGetVectorTextBox(canvas, x, y, text, &xmin, &xmax, &ymin, &ymax);
    cdCanvasForeground(canvas, CD_GREEN);
    cdCanvasRect(canvas, xmin, xmax, ymin, ymax);

    if (cdCanvasTextOrientation(canvas, CD_QUERY) == 0)
    {
      cdCanvasForeground(canvas, CD_RED);
      cdCanvasLine(canvas, xmin, y, xmax, y);
    }
  }
  else
  {
    /* bounding box */
    cdCanvasGetVectorTextBounds(canvas, text, x, y, rect.ptr);
    cdCanvasForeground(canvas, CD_GREEN);
    cdCanvasBegin(canvas, CD_CLOSED_LINES);
    cdCanvasVertex(canvas, rect[0], rect[1]);
    cdCanvasVertex(canvas, rect[2], rect[3]);
    cdCanvasVertex(canvas, rect[4], rect[5]);
    cdCanvasVertex(canvas, rect[6], rect[7]);
    cdCanvasEnd(canvas);
  }

  /* reference point */
  cdCanvasForeground(canvas, CD_BLUE);
  cdCanvasMarkType(canvas, CD_PLUS);
  cdCanvasMarkSize(canvas, 30);
  cdCanvasMark(canvas, x, y);

  cdCanvasForeground(canvas, CD_BLACK);
  cdCanvasVectorText(canvas, x, y, text);
}

void DrawTextBox(cdCanvas* canvas, int x, int y, char* text)
{
  int[8] rect;
  int draw_box;

  cdCanvasLineWidth(canvas, 1);
  cdCanvasLineStyle(canvas, CD_CONTINUOUS);

  draw_box = 0;
  if (draw_box)
  {
    int xmin, xmax, ymin, ymax;
    cdCanvasGetTextBox(canvas, x, y, text, &xmin, &xmax, &ymin, &ymax);
    cdCanvasRect(canvas, xmin, xmax, ymin, ymax);

    if (cdCanvasTextOrientation(canvas, CD_QUERY) == 0)
    {
      cdCanvasForeground(canvas, CD_RED);
      cdCanvasLine(canvas, xmin, y, xmax, y);
    }
  }
  else
  {
    /* bounding box */
    cdCanvasGetTextBounds(canvas, x, y, text, rect.ptr);
    cdCanvasForeground(canvas, CD_GREEN);
    cdCanvasBegin(canvas, CD_CLOSED_LINES);
    cdCanvasVertex(canvas, rect[0], rect[1]);
    cdCanvasVertex(canvas, rect[2], rect[3]);
    cdCanvasVertex(canvas, rect[4], rect[5]);
    cdCanvasVertex(canvas, rect[6], rect[7]);
    cdCanvasEnd(canvas);
  }

  /* reference point */
  cdCanvasForeground(canvas, CD_BLUE);
  cdCanvasMarkType(canvas, CD_PLUS);
  cdCanvasMarkSize(canvas, 30);
  cdCanvasMark(canvas, x, y);

  cdCanvasForeground(canvas, CD_BLACK);
  cdCanvasText(canvas, x, y, text);
}

void SimpleDrawTextAlign(cdCanvas* canvas)
{
  int w, h, i, xoff, yoff, use_vector;

  int[12] text_aligment = [
    CD_NORTH,
    CD_SOUTH,
    CD_EAST,
    CD_WEST,
    CD_NORTH_EAST,
    CD_NORTH_WEST,
    CD_SOUTH_EAST,
    CD_SOUTH_WEST,
    CD_CENTER,
    CD_BASE_CENTER,
    CD_BASE_RIGHT,
    CD_BASE_LEFT
  ];

version(all) {
  char*[] text_aligment_str = [
  "North (�yj)\nSecond Line (�yj)".dup.ptr,
  "South (�yj)\nSecond Line (�yj)".dup.ptr,
  "East (�yj)\nSecond Line (�yj)".dup.ptr,
  "West (�yj)\nSecond Line (�yj)".dup.ptr,
  "North East (�yj)\nSecond Line (�yj)".dup.ptr,
  "North West (�yj)\nSecond Line (�yj)".dup.ptr,
  "South East (�yj)\nSecond Line (�yj)".dup.ptr,
  "South West (�yj)\nSecond Line (�yj)".dup.ptr,
  "Center (�yj)\nSecond Line (�yj)".dup.ptr,
  "Base Center (�yj)\nSecond Line (�yj)".dup.ptr,
  "Base Right (�yj)\nSecond Line (�yj)".dup.ptr,
  "Base Left (�yj)\nSecond Line (�yj)".dup.ptr
  ];
}
else {
  char*[] text_aligment_str = [
  "North (�yj)",
  "South (�yj)",
  "East (�yj)",
  "West (�yj)",
  "North East (�yj)",
  "North West (�yj)",
  "South East (�yj)",
  "South West (�yj)",
  "Center (�yj)",
  "Base Center (�yj)",
  "Base Right (�yj)",
  "Base Left (�yj)"
  ];
}

  cdCanvasGetSize(canvas, &w, &h, null, null);

  cdCanvasBackground(canvas, CD_WHITE);
  cdCanvasClear(canvas);

  use_vector = 0;

version(none) {
  if (use_vector)
    cdCanvasVectorTextDirection(canvas, 0, 0, 1, 1);
  else
    cdCanvasTextOrientation(canvas, 45);
}

  xoff = w/4;
  yoff = h/7;

  if (use_vector)
    cdCanvasVectorCharSize(canvas, 30);
  else
  {
    //cdCanvasFont(canvas, "Times", CD_PLAIN, 14);
    cdCanvasFont(canvas, "Helvetica", CD_PLAIN, 24);
  }

  for (i = 0; i < 12; i++)
  {
    cdCanvasTextAlignment(canvas, text_aligment[i]);
    if (i < 6)
    {
      if (use_vector)
        DrawVectorTextBox(canvas, xoff, yoff*(i+1), text_aligment_str[i]);
      else
        DrawTextBox(canvas, xoff, yoff*(i+1), text_aligment_str[i]);
    }
    else
    {
      if (use_vector)
        DrawVectorTextBox(canvas, 3*xoff, yoff*(i-5), text_aligment_str[i]);
      else
        DrawTextBox(canvas, 3*xoff, yoff*(i-5), text_aligment_str[i]);
    }
  }
}

void DrawTextFont(cdCanvas* canvas, const(char)* font, int size, int xoff, int yoff, char* text)
{
  cdCanvasFont(canvas, font, CD_PLAIN, size);
  DrawTextBox(canvas, xoff, yoff, text);

  cdCanvasFont(canvas, font, CD_BOLD, size);
  DrawTextBox(canvas, 2*xoff, yoff, text);

  cdCanvasFont(canvas, font, CD_ITALIC, size);
  DrawTextBox(canvas, 3*xoff, yoff, text);

  cdCanvasFont(canvas, font, CD_BOLD_ITALIC, size);
  DrawTextBox(canvas, 4*xoff, yoff, text);
}

void SimpleDrawTextFonts(cdCanvas* canvas)
{
  int xoff, yoff, size;

  cdCanvasBackground(canvas, CD_WHITE);
  cdCanvasClear(canvas);

  xoff = 470;
  yoff = 150;
  size = -30;

  cdCanvasTextAlignment(canvas, CD_CENTER);

  DrawTextFont(canvas, "Courier", size, xoff, yoff, "Courier".dup.ptr);
  DrawTextFont(canvas, "Times", size, xoff, 2*yoff, "Times Roman".dup.ptr);
  DrawTextFont(canvas, "Helvetica", size, xoff, 3*yoff, "Helvetica".dup.ptr);
  DrawTextFont(canvas, "System", size, xoff, 4*yoff, "System".dup.ptr);

  {
//    static char native[50] = "Tecmedia, -60";
//    static char native[50] = "-*-helvetica-medium-r-*-*-8-*";
//    static char native[50] = "Edwardian Script ITC, 24";
//    cdSetAttribute("ADDFONTMAP","Edwardian Script ITC=ITCEDSCR");

//    char native[50] = "Book Antiqua, 24";
//    cdSetAttribute("ADDFONTMAP", "Book Antiqua=BKANT");

//    cdNativeFont("-d");
//    cdNativeFont(native);
//    DrawTextBox(xoff, yoff, native);
//    DrawTextBox(xoff, yoff, "The quick brown fox.");
  }

  //cdNativeFont("Tecmedia, 36");

  //cdSetAttribute("ADDFONTMAP", "WingDings=WingDing");
  //cdNativeFont("WingDings, 36");

  //cdText(500, 50, "X");
  //cdText(500, 50, "abcdefghijklmnopqrstuvwxyz");
  //cdText(500, 150, "ABCDEFGHIJKLMNOPQRSTUVWXYZ");
  //cdText(500, 250, "1234567890");
  //cdText(500, 350, "'\"!@#$%�&*()_+-=[]^/;.,");

  //cdFont(CD_COURIER, 0, 22);
  //cdText(10, 60, "abcdefghijklmnopqrstuvwxyz");
  //cdText(10, 160, "ABCDEFGHIJKLMNOPQRSTUVWXYZ");
  //cdText(10, 260, "1234567890");
  //cdText(500, 360, "'\"!@#$%�&*()_+-=[]^/;.,");
}

void SimpleDrawTest(cdCanvas* canvas)
//void SimpleDrawMainTest(cdCanvas* canvas)
{
  c_long[16] pattern;  /* 4x4 pattern */
  int w, h;
  int xmin, xmax, ymin, ymax;

/* notice that if we are not using world coordinates 
   it is harder to position all the objetcs we want. */
  cdCanvasGetSize(canvas, &w, &h, null, null);

  cdCanvasBackground(canvas, CD_WHITE);
  cdCanvasClear(canvas);

/* pattern initialization */
  pattern[0]  = CD_RED;    pattern[1]  = CD_RED;    /* first line */
  pattern[2]  = CD_YELLOW; pattern[3]  = CD_YELLOW;
  pattern[4]  = CD_RED;    pattern[5]  = CD_RED;    /* second line */
  pattern[6]  = CD_YELLOW; pattern[7]  = CD_YELLOW;
  pattern[8]  = CD_YELLOW; pattern[9]  = CD_YELLOW; /* third line */
  pattern[10] = CD_YELLOW; pattern[11] = CD_YELLOW;
  pattern[12] = CD_YELLOW; pattern[13] = CD_YELLOW; /* fourth line */
  pattern[14] = CD_YELLOW; pattern[15] = CD_YELLOW;

/* set the line attributes */
  cdCanvasLineWidth(canvas, 4);
  cdCanvasLineStyle(canvas, CD_CONTINUOUS);

/* in the center draw a pattern pizza 
   with a slice mising */
  cdCanvasPattern(canvas, 4, 4, pattern.ptr);
  cdCanvasSector(canvas, w/2, h/2, w/2, h/2, 45, 0);
/* draws a dark red border */
  cdCanvasForeground(canvas, CD_DARK_RED);
  cdCanvasInteriorStyle(canvas, CD_HOLLOW);
  cdCanvasSector(canvas, w/2, h/2, w/2, h/2, 45, 0);

/* on the left a red hash diamond */
/* notice the the default back opacity is transparent
   and the pattern of the sector will still be visible
   inside the hatch where the two objects intersect */
  cdCanvasForeground(canvas, CD_RED);
  cdCanvasHatch(canvas, CD_DIAGCROSS); 
  cdCanvasBegin(canvas, CD_FILL);
  cdCanvasVertex(canvas, w/4, h/4); 
  cdCanvasVertex(canvas, w/2-w/8, h/2); 
  cdCanvasVertex(canvas, w/4, 3*h/4); 
  cdCanvasVertex(canvas, w/8, h/2); 
  cdCanvasEnd(canvas);

/* draws a blue roof.*/
  cdCanvasForeground(canvas, CD_BLUE);
  cdCanvasLine(canvas, w/8, h/2, w/4, 3*h/4);
  cdCanvasLine(canvas, w/4, 3*h/4, w/2-w/8, h/2);

/* draws a dashed ribbon on the right 
   with a custom color */
  cdCanvasForeground(canvas, cdEncodeColor(100, 25, 200));
  cdCanvasLineStyle(canvas, CD_DASH_DOT);
  cdCanvasBegin(canvas, CD_BEZIER);
  cdCanvasVertex(canvas, 3*w/4-20, h/2-50); 
  cdCanvasVertex(canvas, 3*w/4+150, 3*h/4-50); 
  cdCanvasVertex(canvas, 3*w/4-150, 3*h/4-50); 
  cdCanvasVertex(canvas, 3*w/4+20, h/2-50); 
  cdCanvasEnd(canvas);

  cdCanvasFont(canvas, "Helvetica", CD_BOLD, 40);
  cdCanvasTextAlignment(canvas, CD_CENTER);
  cdCanvasText(canvas, w/2, h/4-50, "Canvas Draw");
  cdCanvasGetTextBox(canvas, w/2, h/4-50, "Canvas Draw", &xmin, &xmax, &ymin, &ymax);
  cdCanvasRect(canvas, xmin, xmax, ymin, ymax);
}

version(none) {
//#
void draw_wd()
{
  char* text;
  double x, y;
  double[8] rect;

  cdBackground(CD_WHITE);
  cdClear();
  cdLineStyle(CD_CONTINUOUS);
  cdLineWidth(1);

//  wdVectorTextDirection(0, 0, 1, 1);
  cdTextAlignment(CD_NORTH_WEST);

//  text = "Vector Text";
  text = "Vector Text\nSecond Line\nThird Line";
  x = 0.25;
  y = 0.40;

  cdForeground(CD_BLACK);
  wdLine(0, 0, 1, 1);
  wdLine(0, 1, 1, 0);

  cdForeground(CD_GREEN);
  cdMarkType(CD_STAR);
  wdMark(x, y);

  cdForeground(CD_BLUE);
  wdVectorCharSize(0.1);
  wdVectorText(x, y, text);

  cdForeground(CD_RED);
  wdGetVectorTextBounds(text, x, y, rect);
  cdBegin(CD_CLOSED_LINES);
  wdVertex(rect[0], rect[1]);
  wdVertex(rect[2], rect[3]);
  wdVertex(rect[4], rect[5]);
  wdVertex(rect[6], rect[7]);
  cdEnd();
}

//void SimpleDrawTest(cdCanvas* canvas)
void SimpleDrawTestHardCopy(cdCanvas* canvas)
{
  int w, h;
  cdGetCanvasSize(&w, &h, 0, 0);
  
  wdViewport(0,w-1,0,h-1);
  if (w>h)
    wdWindow(0,cast(double)w/cast(double)h,0,1);
  else
    wdWindow(0,1,0,cast(double)h/cast(double)w);

  draw_wd();

  //wdHardcopy(CD_CLIPBOARD, "800x600", cdActiveCanvas(), draw_wd );
}

//void SimpleDrawTest(cdCanvas* canvas)
void SimpleDrawTestImageRGB(cdCanvas* canvas)
{
  int size = 2048*2048;
  ubyte* red, green, blue;
  cdCanvas* canvas = cdCreateCanvas(CD_IMAGERGB, "2048x2048");
  cdActivate(canvas);

  red = calloc(size, 1);
  green = calloc(size, 1);
  blue = calloc(size, 1);

  cdPutImageRectRGB(2048, 2048, red, green, blue, 0, 3, 2048, 2017, 0, 2047, 3, 2020);

  free(red);
  free(green);
  free(blue);

  cdKillCanvas(canvas);
}

//void SimpleDrawTest(cdCanvas* canvas)
void SimpleDrawVectorFont(cdCanvas* canvas)
{
  cdBackground(CD_WHITE);
  cdClear();
  cdLineStyle(CD_CONTINUOUS);
  cdLineWidth(1);

//  wdVectorText(0.1, 0.4, "���� ����� ����� ����� �����");
//  wdVectorText(0.1, 0.2, "���� ����� ����� ����� ����� ");
  cdVectorFont("../etc/vectorfont26.txt"); /* original Simplex II */
  {
    int i;
    char[2] t;
    char[10] s;
    int x = 10;
    int y = 600;
    t[1] = 0;
  cdFont(CD_COURIER, CD_BOLD, 14);
  cdVectorCharSize(25);
    for (i = 128; i < 256; i++)
    {
      int dx = 30;
      t[0] = cast(char)i;
      sprintf(s, "%3d", i);
      cdForeground(CD_DARK_RED);
      cdText(x, y, s);
//      cdText(x+dx, y, t);
      cdForeground(CD_BLACK);
      cdVectorText(x+2*dx-10, y, t);
      
      x += 3*dx;
      if ((i+1) % 8 == 0)
      {
        x = 10;
        y -= 30;
      }
    }
  //cdFont(CD_TIMES_ROMAN, CD_PLAIN, 24);
  //cdVectorCharSize(24);
  //  for (i = 192; i < 256; i++)
  //  {
  //    int dx = 92;
  //    t[0] = (char)i;
  //    sprintf(s, "%d", i);
  //    cdText(x, y, s);
  //    cdText(x+dx, y, t);
  //    cdVectorText(x+2*dx, y, t);
  //    
  //    x += 3*dx + 2*dx/3;
  //    if ((i+1) % 4 == 0)
  //    {
  //      x = 30;
  //      y += 52;
  //    }
  //  }
  }
}

//void SimpleDrawTest(cdCanvas* canvas)
void SimpleDrawPoly(cdCanvas* canvas)
{
  int w, h;
  cdGetCanvasSize(&w, &h, 0, 0);

  cdBackground(CD_WHITE);
  cdClear();

  //cdSetAttribute("ANTIALIAS", "0");
  cdForeground(cdEncodeAlpha(cdEncodeColor(255, 0, 0), 100));

  cdfCanvasArc(cdActiveCanvas(), 255, 255, 100, 100, 0, 360);

  cdLine(0, 0, 200, 200);

  cdBegin(CD_BEZIER);
  cdVertex(100, 100); 
  cdVertex(150, 200); 
  cdVertex(180, 250); 
  cdVertex(180, 200); 
  cdVertex(180, 150); 
  cdVertex(150, 100); 
  cdVertex(300, 100); 
  cdEnd();


  cdEnd();
}
}


version(none) {
//#ifdef USE_OPENGL
//#ifdef WIN32
//#include <windows.h>
//#endif

//#include <GL/gl.h>
//#include <GL/glu.h>
//#endif
}

int cmdExit() nothrow
{
  return IUP_CLOSE;
}

//void simple_loadled ();

version(USE_OPENGL)
{
//#ifdef USE_OPENGL
/* USE_OPENGL - add to linker:
cdgl
iupgl
ftgl
glu32
opengl32
*/

void SimpleUpdateSize(cdCanvas* cnv)
{
  Ihandle* canvas = IupGetHandle("SimpleCanvas");
  int w = IupGetInt(canvas, "RASTERSIZE");
  int h = IupGetInt2(canvas, "RASTERSIZE");
  IupGLMakeCurrent(canvas);

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
//  gluOrtho2D(0, w, 0, h);

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();

  if (cnv)
  {
    char[100] StrData;
    sprintf(StrData.ptr, "%dx%d", w, h);  /* no need to update resolution */
    cdCanvasSetAttribute(cnv, "SIZE", StrData.ptr);
  }
}

void SimpleFlush()
{
  IupGLSwapBuffers(IupGetHandle("SimpleCanvas"));
}
//#endif
} // version(USE_OPENGL)

int main(string[] args) { // C: int main(int argc, char** argv)
    // Load OpenGL versions 1.0 and 1.1.
//    DerelictGL3.load();
    
	int rv;
	{
		char*[] args_carray;
		foreach (s; args)
			args_carray ~= cast(char*) s.toStringz;

		debug  writeln("APP_NAME: ", args[0]);
		int argc = cast(int) args.length;
		char** argv = args_carray.ptr;
		char* error = null;

		/* Initialization of IUP */
		IupOpen(&argc, &argv);
	}

// Create an OpenGL context with another library (like SDL 2 or GLFW 3)
//#ifdef USE_CONTEXTPLUS
  cdInitContextPlus();
//#endif
version(USE_OPENGL) {
//#ifdef USE_OPENGL
  // Load versions 1.2+ and all supported ARB and EXT extensions.
  DerelictGL.reload();
  // Now OpenGL functions can be called.
  IupGLCanvasOpen();
//#endif
} // version(USE_OPENGL)

//  simple_loadled();

	char* error = null;
	if ((error = IupLoad("simple.led")) != null) {
		IupMessage("LED Fehler", error);
		exit(EXIT_FAILURE);
	}

version(USE_OPENGL)
{
//#ifdef USE_OPENGL
  {
    Ihandle* dialog = IupGetHandle("SimpleDialog");
    Ihandle* canvas = IupGetHandle("SimpleCanvas");
    IupDestroy(canvas);
    canvas = IupGLCanvas("SimpleRepaint");
//    DerelictGL.reload();
    IupSetHandle("SimpleCanvas", canvas);
    IupAppend(dialog, canvas);
  }
//#endif
} // version(USE_OPENGL)
  IupSetAttribute(IupGetHandle("SimpleDialog"), "PLACEMENT", "MAXIMIZED");
  IupShow(IupGetHandle("SimpleDialog"));

  SimpleCreateCanvas(cast(char*)IupGetHandle("SimpleCanvas"));

  IupSetFunction("cmdExit", cast(Icallback) &cmdExit);

  IupSetFunction("SimplePlayClipboard", cast(Icallback) &SimplePlayClipboard);
  IupSetFunction("SimplePlayCGMText", cast(Icallback) &SimplePlayCGMText);
  IupSetFunction("SimplePlayCGMBin", cast(Icallback) &SimplePlayCGMBin);
  IupSetFunction("SimplePlayMetafile", cast(Icallback) &SimplePlayMetafile);
  IupSetFunction("SimplePlayWMF", cast(Icallback) &SimplePlayWMF);
  IupSetFunction("SimplePlayEMF", cast(Icallback) &SimplePlayEMF);

  IupSetFunction("SimpleDrawDebug", cast(Icallback) &SimpleDrawDebug);
  IupSetFunction("SimpleDrawWindow", cast(Icallback) &SimpleDrawWindow);
  IupSetFunction("SimpleDrawCGMText", cast(Icallback) &SimpleDrawCGMText);
  IupSetFunction("SimpleDrawCGMBin", cast(Icallback) &SimpleDrawCGMBin);
  IupSetFunction("SimpleDrawDXF", cast(Icallback) &SimpleDrawDXF);
  IupSetFunction("SimpleDrawDGN", cast(Icallback) &SimpleDrawDGN);
  IupSetFunction("SimpleDrawEMF", cast(Icallback) &SimpleDrawEMF);
  IupSetFunction("SimpleDrawMetafile", cast(Icallback) &SimpleDrawMetafile);
  IupSetFunction("SimpleDrawPDF", cast(Icallback) &SimpleDrawPDF);
  IupSetFunction("SimpleDrawPS", cast(Icallback) &SimpleDrawPS);
  IupSetFunction("SimpleDrawEPS", cast(Icallback) &SimpleDrawEPS);
  IupSetFunction("SimpleDrawSVG", cast(Icallback) &SimpleDrawSVG);
  IupSetFunction("SimpleDrawWMF", cast(Icallback) &SimpleDrawWMF);
  IupSetFunction("SimpleDrawPrint", cast(Icallback) &SimpleDrawPrint);
  IupSetFunction("SimpleDrawPrintDialog", cast(Icallback) &SimpleDrawPrintDialog);
  IupSetFunction("SimpleDrawClipboardBitmap", cast(Icallback) &SimpleDrawClipboardBitmap);
  IupSetFunction("SimpleDrawClipboardMetafile", cast(Icallback) &SimpleDrawClipboardMetafile);
  IupSetFunction("SimpleDrawClipboardEMF", cast(Icallback) &SimpleDrawClipboardEMF);
  IupSetFunction("SimpleDrawImage", cast(Icallback) &SimpleDrawImage);
  IupSetFunction("SimpleDrawImageRGB", cast(Icallback) &SimpleDrawImageRGB);
  IupSetFunction("SimpleDrawSimulate", cast(Icallback) &SimpleDrawSimulate);

version(USE_OPENGL)
{
//#ifdef USE_OPENGL
  IupSetFunction("SimpleDrawGL", cast(Icallback) &SimpleDrawGL);
//#endif
}

  IupSetFunction("SimpleNotXor", cast(Icallback) &SimpleNotXor);
  IupSetFunction("SimpleXor", cast(Icallback) &SimpleXor);
  IupSetFunction("SimpleReplace", cast(Icallback) &SimpleReplace);
  IupSetFunction("SimpleClippingOff", cast(Icallback) &SimpleClippingOff);
  IupSetFunction("SimpleClippingArea", cast(Icallback) &SimpleClippingArea);
  IupSetFunction("SimpleClippingPolygon", cast(Icallback) &SimpleClippingPolygon);
  IupSetFunction("SimpleClippingRegion", cast(Icallback) &SimpleClippingRegion);
  IupSetFunction("SimpleContextPlus", cast(Icallback) &SimpleContextPlus);
  IupSetFunction("SimpleTransform", cast(Icallback) &SimpleTransform);

  IupSetFunction("SimpleAll", cast(Icallback) &SimpleAll);
  IupSetFunction("SimpleTextAlign", cast(Icallback) &SimpleTextAlign);
  IupSetFunction("SimpleTextFonts", cast(Icallback) &SimpleTextFonts);
  IupSetFunction("SimpleTest", cast(Icallback) &SimpleTest);

  IupSetFunction("SimpleRepaint", cast(Icallback) &SimpleRepaint);

  SimpleDrawWindow();

version(USE_OPENGL)
{
//#ifdef USE_OPENGL
  SimpleUpdateSize(null);
  IupUpdate(IupGetHandle("SimpleCanvas"));
//#endif
}

  IupMainLoop();

  SimpleKillCanvas();

  IupClose();

  return EXIT_SUCCESS;
}

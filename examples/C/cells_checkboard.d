#!/usr/bin/rdmd @cmdfile

//version = CD; required

//#include <stdio.h>
import core.stdc.stdlib;
import core.stdc.stdio;

import std.string : toStringz, fromStringz;

import iup.iup;
import cd.cd : cdCanvas, cdCanvasForeground, cdCanvasBox, CD_WHITE, CD_BLACK, CD_YELLOW, cdCanvasText;
import iup.iupcontrols;


extern(C) int nlines_cb(Ihandle* h) nothrow
{
   return 8;
}

extern(C) int ncols_cb(Ihandle* h) nothrow
{
   return 8;
}

extern(C) int height_cb(Ihandle* h, int i) nothrow
{
   return 100;
}

extern(C) int width_cb(Ihandle* h, int j) nothrow
{
   return 100;
}

extern(C) int draw_cb(Ihandle* h, int i, int j, int xmin, int xmax, int ymin, int ymax, cdCanvas* canvas) nothrow
{
  if (((i%2) && (j%2)) || (((i+1)%2) && ((j+1)%2))) 
    cdCanvasForeground(canvas, CD_WHITE);
  else 
    cdCanvasForeground(canvas, CD_YELLOW);
  cdCanvasBox(canvas, xmin, xmax, ymin, ymax);
  cdCanvasForeground(canvas, CD_BLACK);
  cdCanvasText(canvas, (xmin+xmax)/2, (ymin+ymax)/2, "A");


  return IUP_DEFAULT;
}

extern(C) int dragbegin_cb(Ihandle* self, int x, int y) nothrow
{
  printf("DRAGBEGIN_CB(ih=%s, x=%d, y=%d)\n", IupGetAttribute(self, "NAME"), x, y);
  return IUP_DEFAULT;
}

extern(C) int dragdatasize_cb(Ihandle* self, char* type) nothrow
{
  printf("DRAGDATASIZE_CB(ih=%s, type=%s)\n", IupGetAttribute(self, "NAME"), type);
  return 1;  // return the size of the data to be dragged
}

extern(C) int dragdata_cb(Ihandle *self, char* type, void *data, int len) nothrow
{
  printf("DRAGDATA_CB(ih=%s, type=%s, len=%d)\n", IupGetAttribute(self, "NAME"), type, len);
  // fill data with something
  sprintf(cast(char*)data, "X".toStringz);
  return IUP_DEFAULT;
}

extern(C) int dragend_cb(Ihandle *self, int del) nothrow
{
  printf("DRAGEND_CB(ih=%s, remove=%d)\n", IupGetAttribute(self, "NAME"), del);  // finishing...
  return IUP_DEFAULT;
}

//Register the required callback DROPDATA_CB for handling the data received.This callback and all the drop target attributes must be set too.
//DROPMOTION_CB is the only optional drop callback.

extern(C) int dropdata_cb(Ihandle *self, char* type, void* data, int len, int x, int y) nothrow
{
  // Data is a text for this sample, so we can print it
  printf("\nDROPDATA_CB(ih=%s, type=%s, data=%s, size=%d, x=%d, y=%d)\n\n", IupGetAttribute(self, "NAME"), type, cast(char*)data, len, x, y);
  return IUP_DEFAULT;
}

extern(C) int dropmotion_cb(Ihandle *self, int x, int y, char* status) nothrow
{
  printf("DROPMOTION_CB(ih=%s, X=%d, Y=%d, status=%s)\n", IupGetAttribute(self, "NAME"), x, y, status);
  return IUP_DEFAULT;
}

Ihandle* create() 
{
   Ihandle* cells  = IupCells();
   Ihandle* canvas = cast(Ihandle*) IupGetAttribute(cells, "CANVAS");
   IupSetAttribute(canvas, "DRAGSOURCE", "YES");
   IupSetAttribute(canvas, "DRAGTYPES", "TEXT,STRING");

   IupSetCallback (canvas, "DRAGBEGIN_CB",    cast(Icallback)&dragbegin_cb);
   IupSetCallback (canvas, "DRAGDATASIZE_CB", cast(Icallback)&dragdatasize_cb);
   IupSetCallback (canvas, "DRAGDATA_CB",     cast(Icallback)&dragdata_cb);
   IupSetCallback (canvas, "DRAGEND_CB",      cast(Icallback)&dragend_cb);

   IupSetAttribute(canvas, "DROPTARGET", "YES");
   IupSetAttribute(canvas, "DROPTYPES", "TEXT,STRING");
   IupSetCallback (canvas, "DROPDATA_CB",     cast(Icallback)&dropdata_cb);
//   IupSetCallback (canvas, "DROPMOTION_CB",   cast(Icallback)&dropmotion_cb);

   IupSetCallback(cells, "DRAW_CB", cast(Icallback)&draw_cb);
   IupSetCallback(cells, "WIDTH_CB", cast(Icallback)&width_cb);
   IupSetCallback(cells, "HEIGHT_CB", cast(Icallback)&height_cb);
   IupSetCallback(cells, "NLINES_CB", &nlines_cb);
   IupSetCallback(cells, "NCOLS_CB", &ncols_cb);

   return cells;
}

/* Main program */
int main(string[] args) { // C: int main(int argc, char **argv)
	char*[] args_carray;
	foreach (s; args)
		args_carray ~= cast(char*) s.toStringz; 
	
	int argc = cast(int) args.length;
	char** argv = args_carray.ptr;

   IupOpen(&argc, &argv);
   IupControlsOpen();

   Ihandle* cells = create();
   Ihandle* dlg   = IupDialog(cells);

   IupSetAttribute(dlg, "RASTERSIZE", "840x880");
   IupSetAttribute(dlg, "TITLE", "IupCells");

   IupShowXY(dlg, IUP_CENTER, IUP_CENTER);
   IupMainLoop();
   IupClose();
   return EXIT_SUCCESS;

}

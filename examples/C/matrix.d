#!/usr/bin/rdmd @cmdfile

import core.stdc.stdlib;
import std.stdio;
import std.string;

import iup.iup;
import iup.iupcontrols;
//#include <cd.h>

Ihandle* create_mat() {
  Ihandle *mat = IupMatrix(null); 
  
  IupSetAttribute(mat,"NUMCOL","5"); 
  IupSetAttribute(mat,"NUMLIN","10"); 
  
  IupSetAttribute(mat,"NUMCOL_VISIBLE","2");
  IupSetAttribute(mat,"NUMLIN_VISIBLE","3");
  
  IupSetAttribute(mat,"0:0","Inflation");
  IupSetAttribute(mat,"1:0","Medicine");
  IupSetAttribute(mat,"2:0","Food"); 
  IupSetAttribute(mat,"3:0","Energy"); 
  IupSetAttribute(mat,"0:1","January 2000"); 
  IupSetAttribute(mat,"0:2","February 2000"); 
  IupSetAttribute(mat,"1:1","5.6");
  IupSetAttribute(mat,"2:1","2.2");
  IupSetAttribute(mat,"3:1","7.2");
  IupSetAttribute(mat,"1:2","4.5");
  IupSetAttribute(mat,"2:2","8.1");
  IupSetAttribute(mat,"3:2","3.4");
//  IupSetAttribute(mat,"WIDTHDEF","34");
  IupSetAttribute(mat, "HEIGHT2", "30");
  IupSetAttribute(mat, "HEIGHT3", "50");

  IupSetAttribute(mat,"RESIZEMATRIX","YES");
//  IupSetAttribute(mat,"MARKMODE","CELL");
  IupSetAttribute(mat,"MARKMODE","LINCOL");
  IupSetAttribute(mat,"MULTIPLE","YES");
  IupSetAttribute(mat,"AREA","NOT_CONTINUOUS");

  return mat;
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

  Ihandle* matrix = create_mat();
  Ihandle* dlg    = IupDialog(matrix);
  IupSetAttribute(dlg, "TITLE", "IupMatrix");
  IupShowXY(dlg, IUP_CENTER, IUP_CENTER);
//  IupSetAttribute(matrix,"2:0","Drink");
//  IupUpdate(matrix);
  IupMainLoop();
  IupClose();  
  return EXIT_SUCCESS;

}

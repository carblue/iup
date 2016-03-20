#!/usr/bin/rdmd -I../../source/
/* IupTabs: Example in C 
   Creates a IupTabs control.
*/

import std.string;
//#include <stdlib.h>
import std.c.stdlib;
//#include <stdio.h>
//#include <iup.h>
import iup.iup;

/* Main program */
int main(string[] args) { // C: int main(int argc, char **argv)
	char*[] args_carray;
	foreach (s; args)
		args_carray ~= cast(char*) s.toStringz; 
	
	int argc = cast(int) args.length;
	char** argv = args_carray.ptr;

  Ihandle* dlg, vbox1, vbox2, tabs1, tabs2, box;
  Ihandle* Jahr_label, hbox1, vbox3, spin;

  IupOpen(&argc, &argv);

  spin = IupText(null);
  IupSetAttribute(spin, "SPIN", "YES");
  IupSetAttribute(spin, "SPINMIN", "2015");
  IupSetAttribute(spin, "SPINMAX", "2030");
  
  hbox1 = IupHbox(IupLabel("Jahr"), spin, null);
  vbox1 = IupVbox(IupLabel("Inside Tab A"), IupButton("Button A", ""), null);
  vbox2 = IupVbox(IupLabel("Inside Tab B"), IupButton("Button B", ""), null);

  IupSetAttribute(vbox1, "TABTITLE", "Tab A");
  IupSetAttribute(vbox2, "TABTITLE", "Tab B");

  tabs1 = IupTabs(vbox1, vbox2, null);

  vbox1 = IupVbox(IupLabel("Inside Tab C"), IupButton("Button C", ""), null);
  vbox2 = IupVbox(IupLabel("Inside Tab D"), IupButton("Button D", ""), null);

  IupSetAttribute(vbox1, "TABTITLE", "Tab C");
  IupSetAttribute(vbox2, "TABTITLE", "Tab D");

  tabs2 = IupTabs(vbox1, vbox2, null);
  IupSetAttribute(tabs2, "TABTYPE", "LEFT");

  box = IupHbox(tabs1, tabs2, null);
  IupSetAttribute(box, "MARGIN", "10x10");
  IupSetAttribute(box, "GAP", "10");

  vbox3 = IupVbox(hbox1, box, null);
  dlg = IupDialog(vbox3);
  IupSetAttribute(dlg, "TITLE", "IupTabs");
  IupSetAttribute(dlg, "SIZE", "200x80");

  IupShowXY (dlg, IUP_CENTER, IUP_CENTER);
  IupMainLoop ();
  IupClose ();

  return EXIT_SUCCESS;

}
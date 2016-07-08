#!/usr/bin/rdmd @cmdfile
import std.string : toStringz;
import core.stdc.stdlib : EXIT_SUCCESS;
import iup.iup;

int main(string[] args) { // C: int main(int argc, char **argv)
	char*[] args_carray;
	foreach (s; args)
		args_carray ~= cast(char*) s.toStringz; 
	
	int argc = cast(int) args.length;
	char** argv = args_carray.ptr;

  Ihandle *dlg;
  Ihandle *multitext;
  Ihandle *vbox;

  IupOpen(&argc, &argv);

  multitext = IupText(null);
  vbox = IupVbox(
    multitext,
    null);
  IupSetAttribute(multitext, "MULTILINE", "YES");
  IupSetAttribute(multitext, "EXPAND", "YES");

  dlg = IupDialog(vbox);
  IupSetAttribute(dlg, "TITLE", "Simple Notepad");
  IupSetAttribute(dlg, "SIZE", "QUARTERxQUARTER");

  IupShowXY(dlg, IUP_CENTER, IUP_CENTER);
  IupSetAttribute(dlg, "USERSIZE", null);

  IupMainLoop();

  IupClose();
  return EXIT_SUCCESS;
}

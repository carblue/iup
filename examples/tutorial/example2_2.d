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
  Ihandle *label;

  IupOpen(&argc, &argv);

  label =  IupLabel("Hello world from IUP.");
  dlg = IupDialog(IupVbox(label, null));
  IupSetAttribute(dlg, "TITLE", "Hello World 2");

  IupShowXY(dlg, IUP_CENTER, IUP_CENTER);

  IupMainLoop();

  IupClose();
  return EXIT_SUCCESS;
}

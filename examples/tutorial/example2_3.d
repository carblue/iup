#!/usr/bin/rdmd @cmdfile
import std.string : toStringz;
import core.stdc.stdlib : EXIT_SUCCESS;
import iup.iup;

extern (C) int btn_exit_cb( Ihandle *self ) nothrow
{
  IupMessage("Hello World Message", "Hello world from IUP.");
  /* Exits the main loop */
  return IUP_CLOSE;
}

int main(string[] args) { // C: int main(int argc, char **argv)
	char*[] args_carray;
	foreach (s; args)
		args_carray ~= cast(char*) s.toStringz; 
	
	int argc = cast(int) args.length;
	char** argv = args_carray.ptr;

  Ihandle *dlg;
  Ihandle *button;
  Ihandle *vbox;

  IupOpen(&argc, &argv);
  
  button = IupButton("OK", null);
  vbox = IupVbox(
    button,
    null);
  dlg = IupDialog(vbox);
  IupSetAttribute(dlg, "TITLE", "Hello World 3");

  /* Registers callbacks */
  IupSetCallback(button, "ACTION", &btn_exit_cb);

  IupShowXY(dlg, IUP_CENTER, IUP_CENTER);

  IupMainLoop();

  IupClose();
  return EXIT_SUCCESS;
}

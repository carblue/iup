#!/usr/bin/rdmd -I../../source/
import std.string : toStringz;
import core.stdc.stdlib : EXIT_SUCCESS;
import iup.iup;

extern (C) int btn_msg_cb( Ihandle *self )
{
  /* Returns to main loop */
  return IUP_DEFAULT;
}

extern (C) int btn_exit_cb( Ihandle *self )
{
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
  Ihandle *label;
  Ihandle *vbox;

  IupOpen(&argc, &argv);
  
  label =  IupLabel("Hello world from IUP.");
  button = IupButton("OK", null);
  vbox = IupVbox(
    label,
    button,
    null);
  dlg = IupDialog(vbox);
  IupSetAttribute(dlg, "TITLE", "Hello World 4");

  /* Registers callbacks */
  IupSetCallback(button, "ACTION", &btn_exit_cb);

  IupShowXY(dlg, IUP_CENTER, IUP_CENTER);

  IupMainLoop();

  IupClose();
  return EXIT_SUCCESS;
}

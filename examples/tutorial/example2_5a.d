#!/usr/bin/rdmd @cmdfile
import std.string : toStringz;
import core.stdc.stdlib : EXIT_SUCCESS;
import iup.iup;

extern (C) int btn_msg_cb( Ihandle *self )
{
  /* Returns to main loop */
  return IUP_DEFAULT;
}

extern (C) int btn_exit_cb( Ihandle *self ) nothrow
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
  IupSetAttribute(label, "PADDING", "10x20");
  button = IupButton("OK", null);
  IupSetAttribute(button, "PADDING", "30x2");
  
  vbox = IupVbox(
    label,
    button,
    null);
  IupSetAttribute(vbox, "ALIGNMENT", "ARIGHT");
  IupSetAttribute(vbox, "GAP", "10");
  IupSetAttribute(vbox, "MARGIN", "10x10");
  
  dlg = IupDialog(vbox);
  IupSetAttribute(dlg, "TITLE", "Hello World 5a");
  IupSetAttribute(dlg, "MAXBOX", "No");
  IupSetAttribute(dlg, "MINBOX", "No");

  /* Registers callbacks */
  IupSetCallback(button, "ACTION", &btn_exit_cb);

  IupShowXY(dlg, IUP_CENTER, IUP_CENTER);

  IupMainLoop();

  IupClose();
  return EXIT_SUCCESS;
}

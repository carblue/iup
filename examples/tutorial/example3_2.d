#!/usr/bin/rdmd @cmdfile
import std.string : toStringz;
import core.stdc.stdlib : EXIT_SUCCESS;
import iup.iup;

extern (C) int exit_cb() nothrow
{
  return IUP_CLOSE;
}

int main(string[] args) { // C: int main(int argc, char **argv)
	char*[] args_carray;
	foreach (s; args)
		args_carray ~= cast(char*) s.toStringz; 
	
	int argc = cast(int) args.length;
	char** argv = args_carray.ptr;

  Ihandle *dlg;
  Ihandle *multitext;
  Ihandle *vbox;
  
  Ihandle *file_menu;
  Ihandle *item_exit;
  Ihandle *item_open;
  Ihandle *item_saveas;

  Ihandle *sub1_menu;
  Ihandle *menu;

  IupOpen(&argc, &argv);

  multitext = IupText(null);
  IupSetAttribute(multitext, "MULTILINE", "YES");
  IupSetAttribute(multitext, "EXPAND", "YES");

  item_open = IupItem("Open", null);
  item_saveas = IupItem("Save As", null);
  item_exit = IupItem("Exit", null);
  IupSetCallback(item_exit, "ACTION", cast(Icallback) &exit_cb);

  file_menu = IupMenu(
    item_open,
    item_saveas,
    IupSeparator(),
    item_exit,
    null);

  sub1_menu = IupSubmenu("File", file_menu);

  menu = IupMenu(sub1_menu, null);

  vbox = IupVbox(
    multitext,
    null);

  dlg = IupDialog(vbox);
  IupSetAttributeHandle(dlg, "MENU", menu);
  IupSetAttribute(dlg, "TITLE", "Simple Notepad");
  IupSetAttribute(dlg, "SIZE", "QUARTERxQUARTER");

  IupShowXY(dlg, IUP_CENTER, IUP_CENTER);
  IupSetAttribute(dlg, "USERSIZE", null);

  IupMainLoop();

  IupClose();
  return EXIT_SUCCESS;
}

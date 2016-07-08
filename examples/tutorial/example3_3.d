#!/usr/bin/rdmd @cmdfile
import std.string : toStringz;
import core.stdc.stdio;
import core.stdc.stdlib;// : EXIT_SUCCESS;
import iup.iup;

/* global variable - to be used inside the menu callbacks */
Ihandle* multitext = null;

char* read_file(const(char)* filename) nothrow
{
  int size;
  char* str;
  FILE* file = fopen(filename, "rb");
  if (!file) 
  {
    IupMessagef("Error", "Can't open file: %s", filename);
    return null;
  }

  /* calculate file size */
  fseek(file, 0, SEEK_END);
  size = cast(int)ftell(file);
  fseek(file, 0, SEEK_SET);

  /* allocate memory for the file contents + nul terminator */
  str = cast(char*)malloc(size + 1);
  /* read all data at once */
  fread(str, size, 1, file);
  /* set the nul terminator */
  str[size] = 0;

  fclose(file);
  return str;
}

void write_file(const(char)* filename, const(char)* str, int count) nothrow
{
  FILE* file = fopen(filename, "w");
  if (!file) 
  {
    IupMessagef("Error", "Can't open file: %s", filename);
    return;
  }

  fwrite(str, 1, count, file);
  fclose(file);
}

extern (C) int open_cb() nothrow
{
  Ihandle *filedlg = IupFileDlg();
  IupSetAttribute(filedlg, "DIALOGTYPE", "OPEN");
  IupSetAttribute(filedlg, "FILTER", "*.txt");
  IupSetAttribute(filedlg, "FILTERINFO", "Text Files");

  IupPopup(filedlg, IUP_CENTER, IUP_CENTER);

  if (IupGetInt(filedlg, "STATUS") != -1)
  {
    char* filename = IupGetAttribute(filedlg, "VALUE");
    char* str = read_file(filename);
    if (str)
    {
      IupSetStrAttribute(multitext, "VALUE", str);
      free(str);
    }
  }

  IupDestroy(filedlg);
  return IUP_DEFAULT;
}

extern (C) int saveas_cb() nothrow
{
  Ihandle *filedlg = IupFileDlg();
  IupSetAttribute(filedlg, "DIALOGTYPE", "SAVE");
  IupSetAttribute(filedlg, "FILTER", "*.txt");
  IupSetAttribute(filedlg, "FILTERINFO", "Text Files");

  IupPopup(filedlg, IUP_CENTER, IUP_CENTER);

  if (IupGetInt(filedlg, "STATUS") != -1)
  {
    char* filename = IupGetAttribute(filedlg, "VALUE");
    char* str = IupGetAttribute(multitext, "VALUE");
    int count = IupGetInt(multitext, "COUNT");
    write_file(filename, str, count);
  }

  IupDestroy(filedlg);
  return IUP_DEFAULT;
}

extern (C) int font_cb() nothrow
{
  Ihandle* fontdlg = IupFontDlg();
  char* font1 = IupGetAttribute(multitext, "FONT");
  IupSetStrAttribute(fontdlg, "VALUE", font1);
  IupPopup(fontdlg, IUP_CENTER, IUP_CENTER);

  if (IupGetInt(fontdlg, "STATUS") == 1)
  {
    char* font2 = IupGetAttribute(fontdlg, "VALUE");
    IupSetStrAttribute(multitext, "FONT", font2);
  }

  IupDestroy(fontdlg);
  return IUP_DEFAULT;
}

extern (C) int about_cb() nothrow
{
  IupMessage("About", "   Simple Notepad\n\nAutors:\n   Gustavo Lyrio\n   Antonio Scuri");
  return IUP_DEFAULT;
}

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

  Ihandle* dlg, vbox;
  Ihandle* file_menu, item_exit, item_open, item_saveas;
  Ihandle* format_menu, item_font;
  Ihandle* help_menu, item_about;
  Ihandle* sub_menu_file, sub_menu_format, sub_menu_help, menu;

  IupOpen(&argc, &argv);

  multitext = IupText(null);
  IupSetAttribute(multitext, "MULTILINE", "YES");
  IupSetAttribute(multitext, "EXPAND", "YES");

  item_open = IupItem("Open...", null);
  item_saveas = IupItem("Save As...", null);
  item_exit = IupItem("Exit", null);
  item_font = IupItem("Font...", null);
  item_about = IupItem("About...", null);

  IupSetCallback(item_exit, "ACTION", cast(Icallback)&exit_cb);
  IupSetCallback(item_open, "ACTION", cast(Icallback)&open_cb);
  IupSetCallback(item_saveas, "ACTION", cast(Icallback)&saveas_cb);
  IupSetCallback(item_font, "ACTION", cast(Icallback)&font_cb);
  IupSetCallback(item_about, "ACTION", cast(Icallback)&about_cb);

  file_menu = IupMenu(
    item_open,
    item_saveas,
    IupSeparator(),
    item_exit,
    null);
  format_menu = IupMenu(
    item_font,
    null);
  help_menu = IupMenu(
    item_about,
    null);

  sub_menu_file = IupSubmenu("File", file_menu);
  sub_menu_format = IupSubmenu("Format", format_menu);
  sub_menu_help = IupSubmenu("Help", help_menu);

  menu = IupMenu(
    sub_menu_file, 
    sub_menu_format, 
    sub_menu_help, 
    null);

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

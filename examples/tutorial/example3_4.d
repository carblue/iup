#!/usr/bin/rdmd -I../../source/
import std.string : toStringz;
import core.stdc.stdio;
import core.stdc.stdlib : EXIT_SUCCESS, malloc, free;
import core.stdc.string;
import core.stdc.ctype;
import iup.iup;

/********************************** Utilities *****************************************/


int str_compare(const(char) *l, const(char) *r, int casesensitive)
{
  if (!l || !r)
    return 0;

  while (*l && *r)
  {
    int diff;
    char l_char = *l,
      r_char = *r;

    /* compute the difference of both characters */
    if (casesensitive)
      diff = l_char - r_char;
    else
      diff = tolower(cast(int)l_char) - tolower(cast(int)r_char);

    /* if they differ we have a result */
    if (diff != 0)
      return 0;

    /* otherwise process the next characters */
    ++l;
    ++r;
  }

  /* check also for terminator */
  if (*l == *r)
    return 1;

  if (*r == 0)
    return 1;  /* if second string is at terminator, then it is partially equal */

  return 0;
}

int str_find(const(char) *str, const(char) *str_to_find, int casesensitive)
{
  int i, str_len, str_to_find_len, count;

  if (!str || str[0] == 0 || !str_to_find || str_to_find[0] == 0)
    return -1;

  str_len = cast(int)strlen(str);
  str_to_find_len = cast(int)strlen(str_to_find);
  count = str_len - str_to_find_len;
  if (count < 0)
    return -1;

  count++;

  for (i = 0; i<count; i++)
  {
    if (str_compare(str, str_to_find, casesensitive))
      return i;

    str++;
  }

  return -1;
}

char* read_file(const(char)* filename)
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

void write_file(const(char)* filename, const(char)* str, int count)
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


/********************************** Callbacks *****************************************/


extern (C) int item_open_action_cb(Ihandle* item_open)
{
  Ihandle* multitext = IupGetDialogChild(item_open, "MULTITEXT");
  Ihandle *filedlg = IupFileDlg();
  IupSetAttribute(filedlg, "DIALOGTYPE", "OPEN");
  IupSetAttribute(filedlg, "FILTER", "*.txt");
  IupSetAttribute(filedlg, "FILTERINFO", "Text Files");
  IupSetAttributeHandle(filedlg, "PARENTDIALOG", IupGetDialog(item_open));

  IupPopup(filedlg, IUP_CENTERPARENT, IUP_CENTERPARENT);

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

extern (C) int item_saveas_action_cb(Ihandle* item_saveas)
{
  Ihandle* multitext = IupGetDialogChild(item_saveas, "MULTITEXT");
  Ihandle *filedlg = IupFileDlg();
  IupSetAttribute(filedlg, "DIALOGTYPE", "SAVE");
  IupSetAttribute(filedlg, "FILTER", "*.txt");
  IupSetAttribute(filedlg, "FILTERINFO", "Text Files");
  IupSetAttributeHandle(filedlg, "PARENTDIALOG", IupGetDialog(item_saveas));

  IupPopup(filedlg, IUP_CENTERPARENT, IUP_CENTERPARENT);

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

extern (C) int item_exit_action_cb()
{
  return IUP_CLOSE;
}

extern (C) int goto_ok_action_cb(Ihandle* bt_ok)
{
  int line_count = IupGetInt(bt_ok, "TEXT_LINECOUNT");
  Ihandle* txt = IupGetDialogChild(bt_ok, "LINE_TEXT");
  int line = IupGetInt(txt, "VALUE");
  if (line < 1 || line >= line_count)
  {
    IupMessage("Error", "Invalid line number.");
    return IUP_DEFAULT;
  }

  IupSetAttribute(IupGetDialog(bt_ok), "STATUS", "1");
  return IUP_CLOSE;
}

extern (C) int goto_cancel_action_cb(Ihandle* bt_ok)
{
  IupSetAttribute(IupGetDialog(bt_ok), "STATUS", "0");
  return IUP_CLOSE;
}

extern (C) int item_goto_action_cb(Ihandle* item_goto)
{
  Ihandle* multitext = IupGetDialogChild(item_goto, "MULTITEXT");
  Ihandle* dlg, box, bt_ok, bt_cancel, txt, lbl;

  int line_count = IupGetInt(multitext, "LINECOUNT");

  lbl = IupLabel(null);
  IupSetfAttribute(lbl, "TITLE", "Line Number [1-%d]:", line_count);
  txt = IupText(null);
  IupSetAttribute(txt, "MASK", IUP_MASK_UINT);  /* unsigned integer number */
  IupSetAttribute(txt, "NAME", "LINE_TEXT");
  IupSetAttribute(txt, "VISIBLECOLUMNS", "20");
  bt_ok = IupButton("OK", null);
  IupSetInt(bt_ok, "TEXT_LINECOUNT", line_count);
  IupSetAttribute(bt_ok, "PADDING", "10x2");
  IupSetCallback(bt_ok, "ACTION", &goto_ok_action_cb);
  bt_cancel = IupButton("Cancel", null);
  IupSetCallback(bt_cancel, "ACTION", &goto_cancel_action_cb);
  IupSetAttribute(bt_cancel, "PADDING", "10x2");

  box = IupVbox(
    lbl,
    txt,
    IupSetAttributes(IupHbox(
      IupFill(),
      bt_ok,
      bt_cancel,
      null), "NORMALIZESIZE=HORIZONTAL"),
    null);
  IupSetAttribute(box, "MARGIN", "10x10");
  IupSetAttribute(box, "GAP", "5");

  dlg = IupDialog(box);
  IupSetAttribute(dlg, "TITLE", "Go To Line");
  IupSetAttribute(dlg, "DIALOGFRAME", "Yes");
  IupSetAttributeHandle(dlg, "DEFAULTENTER", bt_ok);
  IupSetAttributeHandle(dlg, "DEFAULTESC", bt_cancel);
  IupSetAttributeHandle(dlg, "PARENTDIALOG", IupGetDialog(item_goto));

  IupPopup(dlg, IUP_CENTERPARENT, IUP_CENTERPARENT);

  if (IupGetInt(dlg, "STATUS") == 1)
  {
    int line = IupGetInt(txt, "VALUE");
    int pos;
    IupTextConvertLinColToPos(multitext, line, 0, &pos);
    IupSetInt(multitext, "CARETPOS", pos);
    IupSetInt(multitext, "SCROLLTOPOS", pos);
  }

  IupDestroy(dlg);

  return IUP_DEFAULT;
}

extern (C) int find_next_action_cb(Ihandle* bt_next)
{
  Ihandle* multitext = cast(Ihandle*)IupGetAttribute(bt_next, "MULTITEXT");
  char* str = IupGetAttribute(multitext, "VALUE");
  int find_pos = IupGetInt(multitext, "FIND_POS");

  Ihandle* txt = IupGetDialogChild(bt_next, "FIND_TEXT");
  char* str_to_find = IupGetAttribute(txt, "VALUE");

  Ihandle* tgl_case = IupGetDialogChild(bt_next, "FIND_CASE");
  int casesensitive = IupGetInt(tgl_case, "VALUE");

  int pos = str_find(str + find_pos, str_to_find, casesensitive);
  if (pos >= 0)
    pos += find_pos;
  else if (find_pos > 0)
    pos = str_find(str, str_to_find, casesensitive);  /* try again from the start */

  if (pos >= 0)
  {
    int lin, col, 
      end_pos = pos + cast(int)strlen(str_to_find);

    IupSetInt(multitext, "FIND_POS", end_pos);

    IupSetFocus(multitext);
    IupSetfAttribute(multitext, "SELECTIONPOS", "%d:%d", pos, end_pos);

    IupTextConvertPosToLinCol(multitext, pos, &lin, &col);
    IupTextConvertLinColToPos(multitext, lin, 0, &pos);  /* position at col=0, just scroll lines */
    IupSetInt(multitext, "SCROLLTOPOS", pos);
  }
  else
    IupMessage("Warning", "Text not found.");

  return IUP_DEFAULT;
}

extern (C) int find_close_action_cb(Ihandle* bt_close)
{
  IupHide(IupGetDialog(bt_close));
  return IUP_DEFAULT;
}

extern (C) int item_find_action_cb(Ihandle* item_find)
{
  Ihandle* dlg = cast(Ihandle*)IupGetAttribute(item_find, "FIND_DIALOG");
  if (!dlg)
  {
    Ihandle* multitext = IupGetDialogChild(item_find, "MULTITEXT");
    Ihandle* box, bt_next, bt_close, txt, tgl_case;

    txt = IupText(null);
    IupSetAttribute(txt, "NAME", "FIND_TEXT");
    IupSetAttribute(txt, "VISIBLECOLUMNS", "20");
    tgl_case = IupToggle("Case Sensitive", null);
    IupSetAttribute(tgl_case, "NAME", "FIND_CASE");
    bt_next = IupButton("Find Next", null);
    IupSetAttribute(bt_next, "PADDING", "10x2");
    IupSetCallback(bt_next, "ACTION", &find_next_action_cb);
    bt_close = IupButton("Close", null);
    IupSetCallback(bt_close, "ACTION", &find_close_action_cb);
    IupSetAttribute(bt_close, "PADDING", "10x2");

    box = IupVbox(
      IupLabel("Find What:"),
      txt,
      tgl_case,
      IupSetAttributes(IupHbox(
        IupFill(),
        bt_next,
        bt_close,
        null), "NORMALIZESIZE=HORIZONTAL"),
      null);
    IupSetAttribute(box, "MARGIN", "10x10");
    IupSetAttribute(box, "GAP", "5");

    dlg = IupDialog(box);
    IupSetAttribute(dlg, "TITLE", "Find");
    IupSetAttribute(dlg, "DIALOGFRAME", "Yes");
    IupSetAttributeHandle(dlg, "DEFAULTENTER", bt_next);
    IupSetAttributeHandle(dlg, "DEFAULTESC", bt_close);
    IupSetAttributeHandle(dlg, "PARENTDIALOG", IupGetDialog(item_find));

    /* Save the multiline to acess it from the callbacks */
    IupSetAttribute(dlg, "MULTITEXT", cast(char*)multitext);

    /* Save the dialog to reuse it */
    IupSetAttribute(item_find, "FIND_DIALOG", cast(char*)dlg);
  }

  /* centerparent first time, next time reuse the last position */
  IupShowXY(dlg, IUP_CURRENT, IUP_CURRENT);

  return IUP_DEFAULT;
}

extern (C) int item_font_action_cb(Ihandle* item_font)
{
  Ihandle* multitext = IupGetDialogChild(item_font, "MULTITEXT");
  Ihandle* fontdlg = IupFontDlg();
  char* font1 = IupGetAttribute(multitext, "FONT");
  IupSetStrAttribute(fontdlg, "VALUE", font1);
  IupSetAttributeHandle(fontdlg, "PARENTDIALOG", IupGetDialog(item_font));

  IupPopup(fontdlg, IUP_CENTERPARENT, IUP_CENTERPARENT);

  if (IupGetInt(fontdlg, "STATUS") == 1)
  {
    char* font2 = IupGetAttribute(fontdlg, "VALUE");
    IupSetStrAttribute(multitext, "FONT", font2);
  }

  IupDestroy(fontdlg);
  return IUP_DEFAULT;
}

extern (C) int item_about_action_cb()
{
  IupMessage("About", "   Simple Notepad\n\nAutors:\n   Gustavo Lyrio\n   Antonio Scuri");
  return IUP_DEFAULT;
}


/********************************** Main *****************************************/


int main(string[] args) { // C: int main(int argc, char **argv)
	char*[] args_carray;
	foreach (s; args)
		args_carray ~= cast(char*) s.toStringz; 
	
	int argc = cast(int) args.length;
	char** argv = args_carray.ptr;

  Ihandle* dlg, vbox, multitext, menu;
  Ihandle* sub_menu_file, file_menu, item_exit, item_open, item_saveas;
  Ihandle* sub_menu_edit, edit_menu, item_find, item_goto;
  Ihandle* sub_menu_format, format_menu, item_font;
  Ihandle* sub_menu_help, help_menu, item_about;

  IupOpen(&argc, &argv);

  multitext = IupText(null);
  IupSetAttribute(multitext, "MULTILINE", "YES");
  IupSetAttribute(multitext, "EXPAND", "YES");
  IupSetAttribute(multitext, "NAME", "MULTITEXT");

  item_open = IupItem("Open...", null);
  item_saveas = IupItem("Save As...", null);
  item_exit = IupItem("Exit", null);
  item_find = IupItem("Find..", null);
  item_goto = IupItem("Go To...", null);
  item_font = IupItem("Font...", null);
  item_about = IupItem("About...", null);

  IupSetCallback(item_open, "ACTION", &item_open_action_cb);
  IupSetCallback(item_saveas, "ACTION", &item_saveas_action_cb);
  IupSetCallback(item_exit, "ACTION", cast(Icallback)&item_exit_action_cb);
  IupSetCallback(item_find, "ACTION", &item_find_action_cb);
  IupSetCallback(item_goto, "ACTION", &item_goto_action_cb);
  IupSetCallback(item_font, "ACTION", &item_font_action_cb);
  IupSetCallback(item_about, "ACTION", cast(Icallback)&item_about_action_cb);

  file_menu = IupMenu(
    item_open,
    item_saveas,
    IupSeparator(),
    item_exit,
    null);
  edit_menu = IupMenu(
    item_find,
    item_goto,
    null);
  format_menu = IupMenu(
    item_font,
    null);
  help_menu = IupMenu(
    item_about,
    null);

  sub_menu_file = IupSubmenu("File", file_menu);
  sub_menu_edit = IupSubmenu("Edit", edit_menu);
  sub_menu_format = IupSubmenu("Format", format_menu);
  sub_menu_help = IupSubmenu("Help", help_menu);

  menu = IupMenu(
    sub_menu_file,
    sub_menu_edit,
    sub_menu_format,
    sub_menu_help,
    null);

  vbox = IupVbox(
    multitext,
    null);

  dlg = IupDialog(vbox);
  IupSetAttributeHandle(dlg, "MENU", menu);
  IupSetAttribute(dlg, "TITLE", "Simple Notepad");
  IupSetAttribute(dlg, "SIZE", "HALFxHALF");

  /* parent for pre-defined dialogs in closed functions (IupMessage) */
  IupSetAttributeHandle(null, "PARENTDIALOG", dlg);

  IupShowXY(dlg, IUP_CENTERPARENT, IUP_CENTERPARENT);
  IupSetAttribute(dlg, "USERSIZE", null);

  IupMainLoop();

  IupClose();
  return EXIT_SUCCESS;
}

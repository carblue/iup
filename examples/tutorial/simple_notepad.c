#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <iup.h>
#include <iup_config.h>


/********************************** Utilities *****************************************/


const char* str_filetitle(const char *file_name)
{
  /* Start at the last character */
  int len = (int)strlen(file_name);
  int offset = len - 1;
  while (offset != 0)
  {
    if (file_name[offset] == '\\' || file_name[offset] == '/')
    {
      offset++;
      break;
    }
    offset--;
  }
  return file_name + offset;
}

int str_compare(const char *l, const char *r, int casesensitive)
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
      diff = tolower((int)l_char) - tolower((int)r_char);

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

int str_find(const char *str, const char *str_to_find, int casesensitive)
{
  int i, str_len, str_to_find_len, count;

  if (!str || str[0] == 0 || !str_to_find || str_to_find[0] == 0)
    return -1;

  str_len = (int)strlen(str);
  str_to_find_len = (int)strlen(str_to_find);
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

char* read_file(const char* filename)
{
  int size;
  char* str;
  FILE* file = fopen(filename, "rb");
  if (!file)
  {
    IupMessagef("Error", "Can't open file: %s", filename);
    return NULL;
  }

  /* calculate file size */
  fseek(file, 0, SEEK_END);
  size = ftell(file);
  fseek(file, 0, SEEK_SET);

  /* allocate memory for the file contents + nul terminator */
  str = malloc(size + 1);
  /* read all data at once */
  fread(str, size, 1, file);
  /* set the nul terminator */
  str[size] = 0;

  fclose(file);
  return str;
}

void write_file(const char* filename, const char* str, int count)
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

void new_file(Ihandle* ih)
{
  Ihandle* dlg = IupGetDialog(ih);
  Ihandle* multitext = IupGetDialogChild(dlg, "MULTITEXT");

  IupSetAttribute(dlg, "TITLE", "Untitled - Simple Notepad");
  IupSetAttribute(multitext, "FILENAME", NULL);
  IupSetAttribute(multitext, "DIRTY", "NO");
  IupSetAttribute(multitext, "VALUE", "");
}

void open_file(Ihandle* ih, const char* filename)
{
  char* str = read_file(filename);
  if (str)
  {
    Ihandle* dlg = IupGetDialog(ih);
    Ihandle* multitext = IupGetDialogChild(dlg, "MULTITEXT");
    Ihandle* config = (Ihandle*)IupGetAttribute(multitext, "CONFIG");

    IupSetfAttribute(dlg, "TITLE", "%s - Simple Notepad", str_filetitle(filename));
    IupSetStrAttribute(multitext, "FILENAME", filename);
    IupSetAttribute(multitext, "DIRTY", "NO");
    IupSetStrAttribute(multitext, "VALUE", str);
    IupConfigRecentUpdate(config, filename);

    free(str);
  }
}

int item_save_action_cb(Ihandle* ih);

int save_check(Ihandle* ih)
{
  Ihandle* multitext = IupGetDialogChild(ih, "MULTITEXT");
  if (IupGetInt(multitext, "DIRTY"))
  {
    switch (IupAlarm("Warning", "File not saved! Save it now?", "Yes", "No", "Cancel"))
    {
    case 1:  /* save the changes and continue */
      item_save_action_cb(ih);
      break;
    case 2:  /* ignore the changes and continue */
      break;
    case 3:  /* cancel */
      return 0;  
    }
  }
  return 1;
}


/********************************** Callbacks *****************************************/


int dropfiles_cb(Ihandle* ih, const char* filename)
{
  if (!save_check(ih))
    return IUP_DEFAULT;

  open_file(ih, filename);
  return IUP_DEFAULT;
}

int multitext_valuechanged_cb(Ihandle* multitext)
{
  IupSetAttribute(multitext, "DIRTY", "YES");
  return IUP_DEFAULT;
}

int file_menu_open_cb(Ihandle* ih)
{
  Ihandle* item_revert = IupGetDialogChild(ih, "ITEM_REVERT");
  Ihandle* item_save = IupGetDialogChild(ih, "ITEM_SAVE");
  Ihandle* multitext = IupGetDialogChild(ih, "MULTITEXT");
  char* filename = IupGetAttribute(multitext, "FILENAME");
  int dirty = IupGetInt(multitext, "DIRTY");

  if (dirty)
    IupSetAttribute(item_save, "ACTIVE", "YES");
  else
    IupSetAttribute(item_save, "ACTIVE", "NO");

  if (dirty && filename)
    IupSetAttribute(item_revert, "ACTIVE", "YES");
  else
    IupSetAttribute(item_revert, "ACTIVE", "NO");
  return IUP_DEFAULT;
}

int edit_menu_open_cb(Ihandle* ih)
{
  Ihandle *clipboard = IupClipboard(); 
  Ihandle* find_dlg = (Ihandle*)IupGetAttribute(ih, "FIND_DIALOG");

  Ihandle *item_paste = IupGetDialogChild(ih, "ITEM_PASTE");
  Ihandle *item_cut = IupGetDialogChild(ih, "ITEM_CUT");
  Ihandle *item_delete = IupGetDialogChild(ih, "ITEM_DELETE");
  Ihandle *item_copy = IupGetDialogChild(ih, "ITEM_COPY");
  Ihandle *item_find_next = IupGetDialogChild(ih, "ITEM_FINDNEXT");
  Ihandle* multitext = IupGetDialogChild(ih, "MULTITEXT");

  if (!IupGetInt(clipboard, "TEXTAVAILABLE"))
    IupSetAttribute(item_paste, "ACTIVE", "NO");
  else
    IupSetAttribute(item_paste, "ACTIVE", "YES");

  if (!IupGetAttribute(multitext, "SELECTEDTEXT")) 
  {
    IupSetAttribute(item_cut, "ACTIVE", "NO");
    IupSetAttribute(item_delete, "ACTIVE", "NO");
    IupSetAttribute(item_copy, "ACTIVE", "NO");
  }
  else 
  {
    IupSetAttribute(item_cut, "ACTIVE", "YES");
    IupSetAttribute(item_delete, "ACTIVE", "YES");
    IupSetAttribute(item_copy, "ACTIVE", "YES");
  }

  if (find_dlg)
  {
    Ihandle* txt = IupGetDialogChild(find_dlg, "FIND_TEXT");
    char* str_to_find = IupGetAttribute(txt, "VALUE");

    if (!str_to_find || str_to_find[0] == 0)
      IupSetAttribute(item_find_next, "ACTIVE", "NO");
    else
      IupSetAttribute(item_find_next, "ACTIVE", "Yes");
  }
  else
    IupSetAttribute(item_find_next, "ACTIVE", "NO");

  IupDestroy(clipboard);
  return IUP_DEFAULT;
}

int item_recent_cb(Ihandle* item_recent)
{
  char* filename;

  if (!save_check(item_recent)) 
    return IUP_DEFAULT;

  filename = IupGetAttribute(item_recent, "TITLE");
  open_file(item_recent, filename);
  return IUP_DEFAULT;
}

int multitext_caret_cb(Ihandle *ih, int lin, int col)
{
  Ihandle *lbl_statusbar = IupGetDialogChild(ih, "STATUSBAR");
  IupSetfAttribute(lbl_statusbar, "TITLE", "Lin %d, Col %d", lin, col);
  return IUP_DEFAULT;
}

int item_new_action_cb(Ihandle* item_new)
{
  if (!save_check(item_new))
    return IUP_DEFAULT;

  new_file(item_new);
  return IUP_DEFAULT;
}

int item_open_action_cb(Ihandle* item_open)
{
  Ihandle *filedlg;

  if (!save_check(item_open))
    return IUP_DEFAULT;

  filedlg = IupFileDlg();
  IupSetAttribute(filedlg, "DIALOGTYPE", "OPEN");
  IupSetAttribute(filedlg, "FILTER", "*.txt");
  IupSetAttribute(filedlg, "FILTERINFO", "Text Files");
  IupSetAttributeHandle(filedlg, "PARENTDIALOG", IupGetDialog(item_open));

  IupPopup(filedlg, IUP_CENTERPARENT, IUP_CENTERPARENT);
  if (IupGetInt(filedlg, "STATUS") != -1)
  {
    char* filename = IupGetAttribute(filedlg, "VALUE");
    open_file(item_open, filename);
  }

  IupDestroy(filedlg);
  return IUP_DEFAULT;
}

int item_saveas_action_cb(Ihandle* item_saveas)
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
    Ihandle* config = (Ihandle*)IupGetAttribute(multitext, "CONFIG");
    char* filename = IupGetAttribute(filedlg, "VALUE");
    char* str = IupGetAttribute(multitext, "VALUE");
    int count = IupGetInt(multitext, "COUNT");
    write_file(filename, str, count);

    IupConfigRecentUpdate(config, filename);
  }

  IupDestroy(filedlg);
  return IUP_DEFAULT;
}

int item_save_action_cb(Ihandle* item_save)
{
  Ihandle* multitext = IupGetDialogChild(item_save, "MULTITEXT");
  char* filename = IupGetAttribute(multitext, "FILENAME");
  if (!filename)
    item_saveas_action_cb(item_save);
  else   
  {
    /* test again because in can be called using the hot key */
    int dirty = IupGetInt(multitext, "DIRTY");
    if (dirty)
    {
      char* str = IupGetAttribute(multitext, "VALUE");
      int count = IupGetInt(multitext, "COUNT");
      write_file(filename, str, count);
    }
  }
  return IUP_DEFAULT;
}

int item_revert_action_cb(Ihandle* item_revert)
{
  Ihandle* multitext = IupGetDialogChild(item_revert, "MULTITEXT");
  char* filename = IupGetAttribute(multitext, "FILENAME");
  open_file(item_revert, filename);
  return IUP_DEFAULT;
}

int item_exit_action_cb(Ihandle* item_exit)
{
  Ihandle* dlg = IupGetDialog(item_exit);
  Ihandle* config = (Ihandle*)IupGetAttribute(dlg, "CONFIG");

  if (!save_check(item_exit))
    return IUP_IGNORE;  /* to abort the CLOSE_CB callback */

  IupConfigDialogClosed(config, dlg, "MainWindow");
  IupConfigSave(config);
  IupDestroy(config);
  return IUP_CLOSE;
}

int goto_ok_action_cb(Ihandle* bt_ok)
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

int goto_cancel_action_cb(Ihandle* bt_ok)
{
  IupSetAttribute(IupGetDialog(bt_ok), "STATUS", "0");
  return IUP_CLOSE;
}

int item_goto_action_cb(Ihandle* item_goto)
{
  Ihandle* multitext = IupGetDialogChild(item_goto, "MULTITEXT");
  Ihandle *dlg, *box, *bt_ok, *bt_cancel, *txt, *lbl;
  int line_count = IupGetInt(multitext, "LINECOUNT");

  lbl = IupLabel(NULL);
  IupSetfAttribute(lbl, "TITLE", "Line Number [1-%d]:", line_count);
  txt = IupText(NULL);
  IupSetAttribute(txt, "MASK", IUP_MASK_UINT);  /* unsigned integer number */
  IupSetAttribute(txt, "NAME", "LINE_TEXT");
  IupSetAttribute(txt, "VISIBLECOLUMNS", "20");
  bt_ok = IupButton("OK", NULL);
  IupSetInt(bt_ok, "TEXT_LINECOUNT", line_count);
  IupSetAttribute(bt_ok, "PADDING", "10x2");
  IupSetCallback(bt_ok, "ACTION", (Icallback)goto_ok_action_cb);
  bt_cancel = IupButton("Cancel", NULL);
  IupSetCallback(bt_cancel, "ACTION", (Icallback)goto_cancel_action_cb);
  IupSetAttribute(bt_cancel, "PADDING", "10x2");

  box = IupVbox(
    lbl,
    txt,
    IupSetAttributes(IupHbox(
      IupFill(),
      bt_ok,
      bt_cancel,
      NULL), "NORMALIZESIZE=HORIZONTAL"),
    NULL);
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

int find_next_action_cb(Ihandle* ih)
{
  /* this callback can be called from the main dialog also */
  Ihandle* find_dlg = (Ihandle*)IupGetAttribute(ih, "FIND_DIALOG");
  if (find_dlg)
  {
    char* str;
    int pos;
    Ihandle* multitext = (Ihandle*)IupGetAttribute(find_dlg, "MULTITEXT");
    int find_pos = IupGetInt(multitext, "FIND_POS");

    Ihandle* txt = IupGetDialogChild(find_dlg, "FIND_TEXT");
    char* str_to_find = IupGetAttribute(txt, "VALUE");

    Ihandle* tgl_case = IupGetDialogChild(find_dlg, "FIND_CASE");
    int casesensitive = IupGetInt(tgl_case, "VALUE");

    /* test again, because it can be called from the hot key */
    if (!str_to_find || str_to_find[0] == 0)
      return IUP_DEFAULT;

    if (find_pos == -1)
      find_pos = 0;

    str = IupGetAttribute(multitext, "VALUE");

    pos = str_find(str + find_pos, str_to_find, casesensitive);
    if (pos >= 0)
      pos += find_pos;
    else if (find_pos > 0)
      pos = str_find(str, str_to_find, casesensitive);  /* try again from the start */

    if (pos >= 0)
    {
      int lin, col,
        end_pos = pos + (int)strlen(str_to_find);

      IupSetInt(multitext, "FIND_POS", end_pos);

      IupSetFocus(multitext);
      IupSetfAttribute(multitext, "SELECTIONPOS", "%d:%d", pos, end_pos);
      IupSetfAttribute(multitext, "FIND_SELECTION", "%d:%d", pos, end_pos);

      IupTextConvertPosToLinCol(multitext, pos, &lin, &col);
      IupTextConvertLinColToPos(multitext, lin, 0, &pos);  /* position at col=0, just scroll lines */
      IupSetInt(multitext, "SCROLLTOPOS", pos);
    }
    else
    {
      IupSetInt(multitext, "FIND_POS", -1);
      IupMessage("Warning", "Text not found.");
    }
  }

  return IUP_DEFAULT;
}

int find_replace_action_cb(Ihandle* bt_replace)
{
  Ihandle* find_dlg = (Ihandle*)IupGetAttribute(bt_replace, "FIND_DIALOG");
  Ihandle* multitext = (Ihandle*)IupGetAttribute(find_dlg, "MULTITEXT");
  int find_pos = IupGetInt(multitext, "FIND_POS");
  char* selectionpos = IupGetAttribute(multitext, "SELECTIONPOS");
  char* find_selection = IupGetAttribute(multitext, "FIND_SELECTION");

  if (find_pos == -1 || !selectionpos || !find_selection || strcmp(selectionpos, find_selection) != 0)
    find_next_action_cb(bt_replace);
  else
  {
    Ihandle* replace_txt = IupGetDialogChild(find_dlg, "REPLACE_TEXT");
    char* str_to_replace = IupGetAttribute(replace_txt, "VALUE");
    IupSetAttribute(multitext, "SELECTEDTEXT", str_to_replace);

    /* then find next */
    find_next_action_cb(bt_replace);
  }

  return IUP_DEFAULT;
}

int find_close_action_cb(Ihandle* bt_close)
{
  IupHide(IupGetDialog(bt_close));  /* do not destroy, just hide */
  return IUP_DEFAULT;
}

void set_find_replace_visibility(Ihandle* find_dlg, int show_replace)
{
  Ihandle* replace_txt = IupGetDialogChild(find_dlg, "REPLACE_TEXT");
  Ihandle* replace_lbl = IupGetDialogChild(find_dlg, "REPLACE_LABEL");
  Ihandle* replace_bt = IupGetDialogChild(find_dlg, "REPLACE_BUTTON");

  if (show_replace)
  {
    IupSetAttribute(replace_txt, "VISIBLE", "Yes");
    IupSetAttribute(replace_lbl, "VISIBLE", "Yes");
    IupSetAttribute(replace_bt, "VISIBLE", "Yes");
    IupSetAttribute(replace_txt, "FLOATING", "No");
    IupSetAttribute(replace_lbl, "FLOATING", "No");
    IupSetAttribute(replace_bt, "FLOATING", "No");
  }
  else
  {
    IupSetAttribute(replace_txt, "FLOATING", "Yes");
    IupSetAttribute(replace_lbl, "FLOATING", "Yes");
    IupSetAttribute(replace_bt, "FLOATING", "Yes");
    IupSetAttribute(replace_txt, "VISIBLE", "No");
    IupSetAttribute(replace_lbl, "VISIBLE", "No");
    IupSetAttribute(replace_bt, "VISIBLE", "No");
  }

  IupSetAttribute(IupGetDialog(replace_txt), "SIZE", NULL);  /* force a dialog resize on the IupRefresh */
  IupRefresh(replace_txt);
}

Ihandle* create_find_dialog(Ihandle *multitext)
{
  Ihandle *box, *bt_next, *bt_close, *txt, *tgl_case, *find_dlg;
  Ihandle* txt_replace, *bt_replace;

  txt = IupText(NULL);
  IupSetAttribute(txt, "NAME", "FIND_TEXT");
  IupSetAttribute(txt, "VISIBLECOLUMNS", "20");
  txt_replace = IupText(NULL);
  IupSetAttribute(txt_replace, "NAME", "REPLACE_TEXT");
  IupSetAttribute(txt_replace, "VISIBLECOLUMNS", "20");
  tgl_case = IupToggle("Case Sensitive", NULL);
  IupSetAttribute(tgl_case, "NAME", "FIND_CASE");
  bt_next = IupButton("Find Next", NULL);
  IupSetAttribute(bt_next, "PADDING", "10x2");
  IupSetCallback(bt_next, "ACTION", (Icallback)find_next_action_cb);
  bt_replace = IupButton("Replace", NULL);
  IupSetAttribute(bt_replace, "PADDING", "10x2");
  IupSetCallback(bt_replace, "ACTION", (Icallback)find_replace_action_cb);
  IupSetAttribute(bt_replace, "NAME", "REPLACE_BUTTON");
  bt_close = IupButton("Close", NULL);
  IupSetCallback(bt_close, "ACTION", (Icallback)find_close_action_cb);
  IupSetAttribute(bt_close, "PADDING", "10x2");

  box = IupVbox(
    IupLabel("Find What:"),
    txt,
    IupSetAttributes(IupLabel("Replace with:"), "NAME=REPLACE_LABEL"),
    txt_replace,
    tgl_case,
    IupSetAttributes(IupHbox(
      IupFill(),
      bt_next,
      bt_replace,
      bt_close,
      NULL), "NORMALIZESIZE=HORIZONTAL"),
    NULL);
  IupSetAttribute(box, "MARGIN", "10x10");
  IupSetAttribute(box, "GAP", "5");

  find_dlg = IupDialog(box);
  IupSetAttribute(find_dlg, "TITLE", "Find");
  IupSetAttribute(find_dlg, "DIALOGFRAME", "Yes");
  IupSetAttributeHandle(find_dlg, "DEFAULTENTER", bt_next);
  IupSetAttributeHandle(find_dlg, "DEFAULTESC", bt_close);
  IupSetAttributeHandle(find_dlg, "PARENTDIALOG", IupGetDialog(multitext));

  /* Save the multiline to access it from the callbacks */
  IupSetAttribute(find_dlg, "MULTITEXT", (char*)multitext);

  /* Save the dialog to reuse it */
  IupSetAttribute(find_dlg, "FIND_DIALOG", (char*)find_dlg);  /* from itself */
  IupSetAttribute(IupGetDialog(multitext), "FIND_DIALOG", (char*)find_dlg); /* from the main dialog */

  return find_dlg;
}

int item_find_action_cb(Ihandle* item_find)
{
  Ihandle* find_dlg = (Ihandle*)IupGetAttribute(item_find, "FIND_DIALOG");
  Ihandle* multitext = IupGetDialogChild(item_find, "MULTITEXT");
  char* str;

  if (!find_dlg)
    find_dlg = create_find_dialog(multitext);

  set_find_replace_visibility(find_dlg, 0);

  /* centerparent first time, next time reuse the last position */
  IupShowXY(find_dlg, IUP_CURRENT, IUP_CURRENT);

  str = IupGetAttribute(multitext, "SELECTEDTEXT");
  if (str && str[0] != 0)
  {
    Ihandle* txt = IupGetDialogChild(find_dlg, "FIND_TEXT");
    IupSetStrAttribute(txt, "VALUE", str);
  }

  return IUP_DEFAULT;
}

int item_replace_action_cb(Ihandle* item_replace)
{
  Ihandle* find_dlg = (Ihandle*)IupGetAttribute(item_replace, "FIND_DIALOG");
  Ihandle* multitext = IupGetDialogChild(item_replace, "MULTITEXT");
  char* str;

  if (!find_dlg)
    find_dlg = create_find_dialog(multitext);

  set_find_replace_visibility(find_dlg, 1);

  /* centerparent first time, next time reuse the last position */
  IupShowXY(find_dlg, IUP_CURRENT, IUP_CURRENT);

  str = IupGetAttribute(multitext, "SELECTEDTEXT");
  if (str && str[0] != 0)
  {
    Ihandle* txt = IupGetDialogChild(find_dlg, "FIND_TEXT");
    IupSetStrAttribute(txt, "VALUE", str);
  }

  return IUP_DEFAULT;
}

int selection_find_next_action_cb(Ihandle* ih)
{
  Ihandle* multitext = IupGetDialogChild(ih, "MULTITEXT");

  char* str = IupGetAttribute(multitext, "SELECTEDTEXT");
  if (str && str[0] != 0)
  {
    Ihandle* txt;
    Ihandle* find_dlg = (Ihandle*)IupGetAttribute(ih, "FIND_DIALOG");

    if (!find_dlg)
      find_dlg = create_find_dialog(multitext);

    txt = IupGetDialogChild(find_dlg, "FIND_TEXT");
    IupSetStrAttribute(txt, "VALUE", str);

    find_next_action_cb(ih);
  }

  return IUP_DEFAULT;
}

void toggle_visibility(Ihandle* item, Ihandle* ih)
{
  if (IupGetInt(item, "VALUE"))
  {
    IupSetAttribute(ih, "FLOATING", "YES");
    IupSetAttribute(ih, "VISIBLE", "NO");
    IupSetAttribute(item, "VALUE", "OFF");
  }
  else
  {
    IupSetAttribute(ih, "FLOATING", "NO");
    IupSetAttribute(ih, "VISIBLE", "YES");
    IupSetAttribute(item, "VALUE", "ON");
  }

  IupRefresh(ih);  /* refresh the dialog layout */
}

int item_toolbar_action_cb(Ihandle* item_toolbar)
{
  Ihandle* multitext = IupGetDialogChild(item_toolbar, "MULTITEXT");
  Ihandle* toolbar = IupGetChild(IupGetParent(multitext), 0);
  Ihandle* config = (Ihandle*)IupGetAttribute(multitext, "CONFIG");

  toggle_visibility(item_toolbar, toolbar);

  IupConfigSetVariableStr(config, "MainWindow", "Toolbar", IupGetAttribute(item_toolbar, "VALUE"));
  return IUP_DEFAULT;
}

int item_statusbar_action_cb(Ihandle* item_statusbar)
{
  Ihandle* multitext = IupGetDialogChild(item_statusbar, "MULTITEXT");
  Ihandle* statusbar = IupGetBrother(multitext);
  Ihandle* config = (Ihandle*)IupGetAttribute(multitext, "CONFIG");

  toggle_visibility(item_statusbar, statusbar);

  IupConfigSetVariableStr(config, "MainWindow", "Statusbar", IupGetAttribute(item_statusbar, "VALUE"));
  return IUP_DEFAULT;
}

int item_font_action_cb(Ihandle* item_font)
{
  Ihandle* multitext = IupGetDialogChild(item_font, "MULTITEXT");
  Ihandle* fontdlg = IupFontDlg();
  char* font = IupGetAttribute(multitext, "FONT");
  IupSetStrAttribute(fontdlg, "VALUE", font);
  IupSetAttributeHandle(fontdlg, "PARENTDIALOG", IupGetDialog(item_font));

  IupPopup(fontdlg, IUP_CENTERPARENT, IUP_CENTERPARENT);

  if (IupGetInt(fontdlg, "STATUS") == 1)
  {
    Ihandle* config = (Ihandle*)IupGetAttribute(multitext, "CONFIG");
    char* font = IupGetAttribute(fontdlg, "VALUE");
    IupSetStrAttribute(multitext, "FONT", font);

    IupConfigSetVariableStr(config, "MainWindow", "Font", font);
  }

  IupDestroy(fontdlg);
  return IUP_DEFAULT;
}

int item_copy_action_cb(Ihandle* item_copy) 
{
  Ihandle* multitext = IupGetDialogChild(item_copy, "MULTITEXT");
  Ihandle *clipboard = IupClipboard();
  IupSetAttribute(clipboard, "TEXT", IupGetAttribute(multitext, "SELECTEDTEXT"));
  IupDestroy(clipboard);
  return IUP_DEFAULT;
}

int item_paste_action_cb(Ihandle* item_paste) 
{
  Ihandle* multitext = IupGetDialogChild(item_paste, "MULTITEXT");
  Ihandle *clipboard = IupClipboard();
  IupSetAttribute(multitext, "INSERT", IupGetAttribute(clipboard, "TEXT"));
  IupDestroy(clipboard);
  return IUP_IGNORE;  /* avoid system processing for hot keys, to correctly parse line feed */
}

int item_cut_action_cb(Ihandle* item_cut) 
{
  Ihandle* multitext = IupGetDialogChild(item_cut, "MULTITEXT");
  Ihandle *clipboard = IupClipboard();
  IupSetAttribute(clipboard, "TEXT", IupGetAttribute(multitext, "SELECTEDTEXT"));
  IupSetAttribute(multitext, "SELECTEDTEXT", "");
  IupDestroy(clipboard);
  return IUP_DEFAULT;
}

int item_delete_action_cb(Ihandle* item_delete) 
{
  Ihandle* multitext = IupGetDialogChild(item_delete, "MULTITEXT");
  IupSetAttribute(multitext, "SELECTEDTEXT", "");
  return IUP_DEFAULT;
}

int item_select_all_action_cb(Ihandle* item_select_all) 
{
  Ihandle* multitext = IupGetDialogChild(item_select_all, "MULTITEXT");
  IupSetFocus(multitext);
  IupSetAttribute(multitext, "SELECTION", "ALL");
  return IUP_DEFAULT;
}

int item_help_action_cb(void)
{
  IupHelp("http://www.tecgraf.puc-rio.br/iup");
  return IUP_DEFAULT;
}

int item_about_action_cb(void)
{
  IupMessage("About", "   Simple Notepad\n\nAutors:\n   Gustavo Lyrio\n   Antonio Scuri");
  return IUP_DEFAULT;
}


/********************************** Main *****************************************/


Ihandle* create_main_dialog(Ihandle *config)
{
  Ihandle *dlg, *vbox, *multitext, *menu;
  Ihandle *sub_menu_file, *file_menu, *item_exit, *item_new, *item_open, *item_save, *item_saveas, *item_revert;
  Ihandle *sub_menu_edit, *edit_menu, *item_find, *item_find_next, *item_goto, *item_copy, *item_paste, *item_cut, *item_delete, *item_select_all;
  Ihandle *btn_cut, *btn_copy, *btn_paste, *btn_find, *btn_new, *btn_open, *btn_save;
  Ihandle *sub_menu_format, *format_menu, *item_font, *item_replace;
  Ihandle *sub_menu_help, *help_menu, *item_help, *item_about;
  Ihandle *sub_menu_view, *view_menu, *item_toolbar, *item_statusbar;
  Ihandle *lbl_statusbar, *toolbar_hb, *recent_menu;
  const char* font;

  multitext = IupText(NULL);
  IupSetAttribute(multitext, "MULTILINE", "YES");
  IupSetAttribute(multitext, "EXPAND", "YES");
  IupSetAttribute(multitext, "NAME", "MULTITEXT");
  IupSetAttribute(multitext, "DIRTY", "NO");
  IupSetCallback(multitext, "CARET_CB", (Icallback)multitext_caret_cb);
  IupSetCallback(multitext, "VALUECHANGED_CB", (Icallback)multitext_valuechanged_cb);
  IupSetCallback(multitext, "DROPFILES_CB", (Icallback)dropfiles_cb);

  font = IupConfigGetVariableStr(config, "MainWindow", "Font");
  if (font)
    IupSetStrAttribute(multitext, "FONT", font);

  lbl_statusbar = IupLabel("Lin 1, Col 1");
  IupSetAttribute(lbl_statusbar, "NAME", "STATUSBAR");
  IupSetAttribute(lbl_statusbar, "EXPAND", "HORIZONTAL");
  IupSetAttribute(lbl_statusbar, "PADDING", "10x5");

  item_new = IupItem("New\tCtrl+N", NULL);
  IupSetAttribute(item_new, "IMAGE", "IUP_FileNew");
  IupSetCallback(item_new, "ACTION", (Icallback)item_new_action_cb);
  btn_new = IupButton(NULL, NULL);
  IupSetAttribute(btn_new, "IMAGE", "IUP_FileNew");
  IupSetAttribute(btn_new, "FLAT", "Yes");
  IupSetCallback(btn_new, "ACTION", (Icallback)item_new_action_cb);

  item_open = IupItem("&Open...\tCtrl+O", NULL);
  IupSetAttribute(item_open, "IMAGE", "IUP_FileOpen");
  IupSetCallback(item_open, "ACTION", (Icallback)item_open_action_cb);
  btn_open = IupButton(NULL, NULL);
  IupSetAttribute(btn_open, "IMAGE", "IUP_FileOpen");
  IupSetAttribute(btn_open, "FLAT", "Yes");
  IupSetCallback(btn_open, "ACTION", (Icallback)item_open_action_cb);

  item_save = IupItem("Save\tCtrl+S", NULL);
  IupSetAttribute(item_save, "NAME", "ITEM_SAVE");
  IupSetAttribute(item_save, "IMAGE", "IUP_FileSave");
  IupSetCallback(item_save, "ACTION", (Icallback)item_save_action_cb);
  btn_save = IupButton(NULL, NULL);
  IupSetAttribute(btn_save, "IMAGE", "IUP_FileSave");
  IupSetAttribute(btn_save, "FLAT", "Yes");
  IupSetCallback(btn_save, "ACTION", (Icallback)item_save_action_cb);

  item_saveas = IupItem("Save &As...", NULL);
  IupSetAttribute(item_saveas, "NAME", "ITEM_SAVEAS");
  IupSetCallback(item_saveas, "ACTION", (Icallback)item_saveas_action_cb);

  item_revert = IupItem("Revert", NULL);
  IupSetAttribute(item_revert, "NAME", "ITEM_REVERT");
  IupSetCallback(item_revert, "ACTION", (Icallback)item_revert_action_cb);

  item_exit = IupItem("E&xit", NULL);
  IupSetCallback(item_exit, "ACTION", (Icallback)item_exit_action_cb);

  item_find = IupItem("&Find...\tCtrl+F", NULL);
  IupSetAttribute(item_find, "IMAGE", "IUP_EditFind");
  IupSetCallback(item_find, "ACTION", (Icallback)item_find_action_cb);
  item_find_next = IupItem("Find &Next\tF3", NULL);
  IupSetAttribute(item_find_next, "NAME", "ITEM_FINDNEXT");
  IupSetCallback(item_find_next, "ACTION", (Icallback)find_next_action_cb);
  item_replace = IupItem("&Replace...\tCtrl+H", NULL);
  IupSetCallback(item_replace, "ACTION", (Icallback)item_replace_action_cb);
  btn_find = IupButton(NULL, NULL);
  IupSetAttribute(btn_find, "IMAGE", "IUP_EditFind");
  IupSetAttribute(btn_find, "FLAT", "Yes");
  IupSetCallback(btn_find, "ACTION", (Icallback)item_find_action_cb);

  item_cut = IupItem("Cut\tCtrl+X", NULL);
  IupSetAttribute(item_cut, "NAME", "ITEM_CUT");
  IupSetAttribute(item_cut, "IMAGE", "IUP_EditCut");
  IupSetCallback(item_cut, "ACTION", (Icallback)item_cut_action_cb);
  item_copy = IupItem("Copy\tCtrl+C", NULL);
  IupSetAttribute(item_copy, "NAME", "ITEM_COPY");
  IupSetAttribute(item_copy, "IMAGE", "IUP_EditCopy");
  IupSetCallback(item_copy, "ACTION", (Icallback)item_copy_action_cb);
  item_paste = IupItem("Paste\tCtrl+V", NULL);
  IupSetAttribute(item_paste, "NAME", "ITEM_PASTE");
  IupSetAttribute(item_paste, "IMAGE", "IUP_EditPaste");
  IupSetCallback(item_paste, "ACTION", (Icallback)item_paste_action_cb);
  item_delete = IupItem("Delete\tDel", NULL);
  IupSetAttribute(item_delete, "IMAGE", "IUP_EditErase");
  IupSetAttribute(item_delete, "NAME", "ITEM_DELETE");
  IupSetCallback(item_delete, "ACTION", (Icallback)item_delete_action_cb);
  item_select_all = IupItem("Select All\tCtrl+A", NULL);
  IupSetCallback(item_select_all, "ACTION", (Icallback)item_select_all_action_cb);

  btn_cut = IupButton(NULL, NULL);
  IupSetAttribute(btn_cut, "IMAGE", "IUP_EditCut");
  IupSetAttribute(btn_cut, "FLAT", "Yes");
  IupSetCallback(btn_cut, "ACTION", (Icallback)item_cut_action_cb);
  btn_copy = IupButton(NULL, NULL);
  IupSetAttribute(btn_copy, "IMAGE", "IUP_EditCopy");
  IupSetAttribute(btn_copy, "FLAT", "Yes");
  IupSetCallback(btn_copy, "ACTION", (Icallback)item_copy_action_cb);
  btn_paste = IupButton(NULL, NULL);
  IupSetAttribute(btn_paste, "IMAGE", "IUP_EditPaste");
  IupSetAttribute(btn_paste, "FLAT", "Yes");
  IupSetCallback(btn_paste, "ACTION", (Icallback)item_paste_action_cb);

  toolbar_hb = IupHbox(
    btn_new,
    btn_open,
    btn_save,
    IupSetAttributes(IupLabel(NULL), "SEPARATOR=VERTICAL"),
    btn_cut,
    btn_copy,
    btn_paste,
    IupSetAttributes(IupLabel(NULL), "SEPARATOR=VERTICAL"),
    btn_find,
    NULL);
  IupSetAttribute(toolbar_hb, "MARGIN", "5x5");
  IupSetAttribute(toolbar_hb, "GAP", "2");

  item_toolbar = IupItem("&Toobar...", NULL);
  IupSetCallback(item_toolbar, "ACTION", (Icallback)item_toolbar_action_cb);
  IupSetAttribute(item_toolbar, "VALUE", "ON");
  item_statusbar = IupItem("&Statusbar...", NULL);
  IupSetCallback(item_statusbar, "ACTION", (Icallback)item_statusbar_action_cb);
  IupSetAttribute(item_statusbar, "VALUE", "ON");

  if (!IupConfigGetVariableIntDef(config, "MainWindow", "Toolbar", 1))
  {
    IupSetAttribute(item_toolbar, "VALUE", "OFF");

    IupSetAttribute(toolbar_hb, "FLOATING", "YES");
    IupSetAttribute(toolbar_hb, "VISIBLE", "NO");
  }

  if (!IupConfigGetVariableIntDef(config, "MainWindow", "Statusbar", 1))
  {
    IupSetAttribute(item_statusbar, "VALUE", "OFF");

    IupSetAttribute(lbl_statusbar, "FLOATING", "YES");
    IupSetAttribute(lbl_statusbar, "VISIBLE", "NO");
  }

  item_goto = IupItem("&Go To...\tCtrl+G", NULL);
  IupSetCallback(item_goto, "ACTION", (Icallback)item_goto_action_cb);

  item_font = IupItem("&Font...", NULL);
  IupSetCallback(item_font, "ACTION", (Icallback)item_font_action_cb);

  if (IupConfigGetVariableInt(config, "MainWindow", "Wordwrap"))
  {
    IupSetAttribute(item_statusbar, "VALUE", "ON");
    IupSetAttribute(multitext, "WORDWRAP", "Yes");
  }

  item_help = IupItem("&Help...", NULL);
  IupSetCallback(item_help, "ACTION", (Icallback)item_help_action_cb);
  item_about = IupItem("&About...", NULL);
  IupSetCallback(item_about, "ACTION", (Icallback)item_about_action_cb);

  recent_menu = IupMenu(NULL);

  file_menu = IupMenu(
    item_new,
    item_open,
    item_save,
    item_saveas,
    item_revert,
    IupSeparator(),
    IupSubmenu("Recent &Files", recent_menu),
    item_exit,
    NULL);
  edit_menu = IupMenu(
    item_cut,
    item_copy,
    item_paste,
    item_delete,
    IupSeparator(),
    item_find,
    item_find_next,
    item_replace,
    item_goto,
    IupSeparator(),
    item_select_all,
    NULL);
  format_menu = IupMenu(
    item_font,
    NULL);
  view_menu = IupMenu(
    item_toolbar,
    item_statusbar,
    NULL);
  help_menu = IupMenu(
    item_help,
    item_about,
    NULL);

  IupSetCallback(file_menu, "OPEN_CB", (Icallback)file_menu_open_cb);
  IupSetCallback(edit_menu, "OPEN_CB", (Icallback)edit_menu_open_cb);

  sub_menu_file = IupSubmenu("&File", file_menu);
  sub_menu_edit = IupSubmenu("&Edit", edit_menu);
  sub_menu_format = IupSubmenu("F&ormat", format_menu);
  sub_menu_view = IupSubmenu("&View", view_menu);
  sub_menu_help = IupSubmenu("&Help", help_menu);

  menu = IupMenu(
    sub_menu_file,
    sub_menu_edit,
    sub_menu_format,
    sub_menu_view,
    sub_menu_help,
    NULL);

  vbox = IupVbox(
    toolbar_hb,
    multitext,
    lbl_statusbar,
    NULL);

  dlg = IupDialog(vbox);
  IupSetAttributeHandle(dlg, "MENU", menu);
  IupSetAttribute(dlg, "SIZE", "HALFxHALF");
  IupSetCallback(dlg, "CLOSE_CB", (Icallback)item_exit_action_cb);
  IupSetCallback(dlg, "DROPFILES_CB", (Icallback)dropfiles_cb);

  IupSetAttribute(dlg, "CONFIG", (char*)config);

  /* parent for pre-defined dialogs in closed functions (IupMessage and IupAlarm) */
  IupSetAttributeHandle(NULL, "PARENTDIALOG", dlg);

  IupSetCallback(dlg, "K_cN", (Icallback)item_new_action_cb);
  IupSetCallback(dlg, "K_cO", (Icallback)item_open_action_cb);
  IupSetCallback(dlg, "K_cS", (Icallback)item_save_action_cb);
  IupSetCallback(dlg, "K_cF", (Icallback)item_find_action_cb);
  IupSetCallback(dlg, "K_cG", (Icallback)item_goto_action_cb);
  IupSetCallback(dlg, "K_F3", (Icallback)find_next_action_cb);
  IupSetCallback(dlg, "K_cF3", (Icallback)selection_find_next_action_cb);
  IupSetCallback(dlg, "K_cV", (Icallback)item_paste_action_cb);  /* replace system processing */
  
  IupConfigRecentInit(config, recent_menu, item_recent_cb, 10);

  return dlg;
}

int main(int argc, char **argv)
{
  Ihandle *dlg;
  Ihandle *config;

  IupOpen(&argc, &argv);
  IupImageLibOpen();

  config = IupConfig();
  IupSetAttribute(config, "APP_NAME", "simple_notepad");
  IupConfigLoad(config);

  dlg = create_main_dialog(config);

  IupShowXY(dlg, IUP_CENTERPARENT, IUP_CENTERPARENT);
  IupSetAttribute(dlg, "USERSIZE", NULL);  /* remove minimum size restriction */

  /* initialize the current file */
  new_file(dlg);

  /* open a file from the command line (allow file association in Windows) */
  if (argc > 1 && argv[1])
  {
    const char* filename = argv[1];
    open_file(dlg, filename);
  }

  IupMainLoop();

  IupClose();
  return EXIT_SUCCESS;
}

/* If instead of using IupText we use IupScintilla, then we can add:
   - more find/replace options
   - zoom
   - show white spaces
   - margins
   - word wrap
   - tab size
   - auto replace tabs by spaces
   - undo & redo
   - markers
   - line numbers
   and much more.
   Hot keys for:
   - match braces
   - to lower case
   - to upper case
 */

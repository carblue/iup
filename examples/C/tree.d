#!/usr/bin/rdmd @cmdfile_plusD
/* IupTree: Example in C
   Creates a tree with some branches and leaves.
   Two callbacks are registered: one deletes marked nodes when the Del key is pressed,
   and the other, called when the right mouse button is pressed, opens a menu with options.
*/

import core.stdc.stdio : printf, sprintf;
//import std.stdio : write, writeln, writefln, stdout, stdout;
//import core.stdc.stdlib : EXIT_SUCCESS, EXIT_FAILURE, exit, getenv; //, div_t, div, malloc, free;
import core.stdc.string;
import std.string;

import iup.iup_plusD;

/* Callback called when a leaf is added by the menu. */
extern(C) int addleaf() nothrow
{
  /*static*/ char[10] attr;
  Ihandle* tree = IupGetHandle("tree");
  int id = IupGetInt(tree,"VALUE");
  sprintf(attr.ptr,"ADDLEAF%d",id);
  IupSetAttribute(tree,attr.ptr,"");
  return IUP_DEFAULT;
}

/* Callback called when a branch is added by the menu. */
extern(C) int addbranch() nothrow
{
  /*static*/ char[10] attr;
  Ihandle* tree = IupGetHandle("tree");
  int id = IupGetInt(tree,"VALUE");
  sprintf(attr.ptr,"ADDBRANCH%d",id);
  IupSetAttribute(tree,attr.ptr,"");
  return IUP_DEFAULT;
}

/* Callback called when a node is removed by the menu. */
extern(C) int removenode() nothrow
{
  Ihandle* tree = IupGetHandle("tree");
  IupSetAttribute(tree,"DELNODE","MARKED");
  return IUP_DEFAULT;
}

/* from the menu */
extern(C) int renamenode() nothrow
{
  return IUP_DEFAULT;
}

extern(C) int executeleaf_cb(Ihandle* h, int id) nothrow
{
  printf("executeleaf_cb (%d)\n", id);
  return IUP_DEFAULT;
}

extern(C) int rename_cb(Ihandle* h, int id, char* name) nothrow
{
  printf("rename_cb (%d=%s)\n", id, name);
  if (strcmp(name, "fool") == 0)
    return IUP_IGNORE;
  return IUP_DEFAULT;
}

extern(C) int branchopen_cb(Ihandle* h, int id) nothrow
{
  printf("branchopen_cb (%d)\n", id);
  return IUP_DEFAULT;
}

extern(C) int branchclose_cb(Ihandle* h, int id) nothrow
{
  printf("branchclose_cb (%d)\n", id);
  return IUP_DEFAULT;
}

extern(C) int dragdrop_cb(Ihandle* h, int drag_id, int drop_id, int isshift, int iscontrol) nothrow
{
  printf("dragdrop_cb (%d)->(%d)\n", drag_id, drop_id);
  return IUP_DEFAULT;
}

/* Callback called when a key is hit */
extern(C) int k_any_cb(Ihandle* h, int c) nothrow
{
  if (c == K_DEL)
  {
    IupSetAttribute(h,"DELNODE","MARKED");
  }

  return IUP_DEFAULT;
}

extern(C) int selectnode(Ihandle* h) nothrow
{
  Ihandle* tree = IupGetHandle("tree");
  IupSetAttribute(tree,"VALUE",IupGetAttribute(h, "TITLE"));
  return IUP_DEFAULT;
}

/* Callback called when the right mouse button is pressed */
extern(C) int rightclick_cb(Ihandle* h, int id) nothrow
{
  Ihandle *popup_menu;

  static char[10] id_string;

  popup_menu = IupMenu(
    IupItem ("Add Leaf","addleaf"),
    IupItem ("Add Branch","addbranch"),
    IupItem ("Rename Node","renamenode"),
    IupItem ("Remove Node","removenode"),
    IupSubmenu("Selection", IupMenu(
      IupItem ("ROOT", "selectnode"),
      IupItem ("LAST", "selectnode"),
      IupItem ("PGUP", "selectnode"),
      IupItem ("PGDN", "selectnode"),
      IupItem ("NEXT", "selectnode"),
      IupItem ("PREVIOUS", "selectnode"),
      IupSeparator(),
      IupItem ("INVERT", "selectnode"),
      IupItem ("BLOCK", "selectnode"),
      IupItem ("CLEARALL", "selectnode"),
      IupItem ("MARKALL", "selectnode"),
      IupItem ("INVERTALL", "selectnode"),
      null)),
    null);

  IupSetFunction("selectnode", &selectnode);

  IupSetFunction("addleaf", cast(Icallback)&addleaf);
  IupSetFunction("addbranch", cast(Icallback)&addbranch);
  IupSetFunction("removenode", cast(Icallback)&removenode);
  IupSetFunction("renamenode", cast(Icallback)&renamenode);

  sprintf(id_string.ptr,"%d",id);
  IupSetAttribute(h, "VALUE", id_string.ptr);
  IupPopup(popup_menu,IUP_MOUSEPOS,IUP_MOUSEPOS);

  IupDestroy(popup_menu);

  return IUP_DEFAULT;
}

/* Initializes IupTree and registers callbacks */
void init_tree()
{
//  Ihandle* tree = IupTree();
  auto tree = new Tree("tree");
  with (tree) {
    SetCallback("EXECUTELEAF_CB", cast(Icallback) &executeleaf_cb);
//    SetCallback("RENAME_CB", cast(Icallback) &rename_cb);
    SetCallback("BRANCHCLOSE_CB", cast(Icallback) &branchclose_cb);
    SetCallback("BRANCHOPEN_CB", cast(Icallback) &branchopen_cb);
//    SetCallback("DRAGDROP_CB", cast(Icallback) &dragdrop_cb);
//    SetCallback("RIGHTCLICK_CB", cast(Icallback) &rightclick_cb);
    SetCallback("K_ANY", cast(Icallback) &k_any_cb);

//  SetAttribute("FONT","COURIER_NORMAL");
  //SetAttribute("CTRL","YES");
  //SetAttribute("SHIFT","YES");
  //SetAttribute("ADDEXPANDED", "NO");
  //SetAttribute("SHOWDRAGDROP", "YES");
    SetAttribute("SHOWRENAME", "YES");

//  IupSetHandle("tree",tree);
  }
}

/* Initializes the dialog */
void init_dlg()
{
//  Ihandle* tree = IupGetHandle("tree");
  auto box = new Vbox(new Hbox(cast(Control)AA["tree"], new Button("test")));
  auto dlg = new Dialog("dlg", true, box);
  dlg.SetAttribute("TITLE", "IupTree");
  box.SetAttribute("MARGIN", "20x20");
//  IupSetHandle("dlg",dlg);
}

/* Initializes the IupTree's attributes */
void init_tree_atributes()
{
  Ihandle* tree = IupGetHandle("tree");

  IupSetAttribute(tree, "TITLE","Figures"); //
  IupSetAttribute(tree, "ADDBRANCH","3D");  // 0
  IupSetAttribute(tree, "ADDBRANCH","2D");  // 1
  IupSetAttribute(tree, "ADDLEAF","test");  // 2

  IupSetAttributeId(tree, "ADDBRANCH", 1, "parallelogram"); //IupSetAttribute(tree, "ADDBRANCH1","parallelogram"); (( 6
  IupSetAttributeId(tree, "ADDLEAF", 2, "diamond");         //IupSetAttribute(tree, "ADDLEAF2","diamond");
  IupSetAttributeId(tree, "ADDLEAF", 2, "square");          //IupSetAttribute(tree, "ADDLEAF2","square");
  IupSetAttributeId(tree, "ADDBRANCH", 1, "triangle");      //IupSetAttribute(tree, "ADDBRANCH1","triangle");
  IupSetAttributeId(tree, "ADDLEAF", 2, "scalenus");        //IupSetAttribute(tree, "ADDLEAF2","scalenus");
  IupSetAttributeId(tree, "ADDLEAF", 2, "isoceles");        //IupSetAttribute(tree, "ADDLEAF2","isoceles");
  IupSetAttributeId(tree, "ADDLEAF", 2, "equilateral");     //IupSetAttribute(tree, "ADDLEAF2","equilateral");
  IupSetAttribute(tree, "VALUE","1");
}

/* Main program */
void main() {
  Ihandle* dlg;

//  IupOpen(&argc, &argv);
  IupOpenD();                       /* IUP initialization */
  scope(exit)  IupClose();          /* Ends IUP */

  init_tree();                          /* Initializes IupTree */
  init_dlg();                           /* Initializes the dialog */
  dlg = IupGetHandle("dlg");            /* Retrieves the dialog handle */
  IupShowXY(dlg,IUP_CENTER,IUP_CENTER); /* Displays the dialog */
  init_tree_atributes();                /* Initializes attributes, can be done here or anywhere */

  IupMainLoop();                         /* Main loop */
//  IupClose();                            /* Ends IUP */

//  return EXIT_SUCCESS;
}

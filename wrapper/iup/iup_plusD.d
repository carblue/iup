/** \file
 * \brief Name space for C++ high level API
 *
 * See Copyright Notice in iup.h
 */
module iup.iup_plusD;

//#define __IUP_PLUS_H

import std.string : toStringz, fromStringz, empty;

public import iup.iup;
public import iup.iupcontrols;
public import iup.iup_config;

//public import iup.iupkey;
public import iup.iupdraw;

/+

TODO check what's required for myproject:

Timer (Handle) /* OK */
Config (Handle) /* OK, no CN */

Fill (Control) /* OK, no CN */
Label (Control) /* OK */
List (Control)  /* OK */
Calendar (Control) /* OK */
Text (Control)  /* OK */
Button (Control)  /* OK */
Toggle (Control)  /* OK */
Matrix (Control)  /* OK */
MatrixList (Control)  /* OK */

Vbox (Container)
Hbox (Container)
Expander (Container)
Tabs (Container)
Dialog (Container)

+/


Handle[string] AA;


/+
#if 0 //TODO

#ifdef _STRING_
std::string
#endif
void cdCanvasSetfAttribute(cdCanvas* canvas, const(char)* name, const(char)* format, ...);
void IupSetStrf(Ihandle* ih, const(char)* name, const(char)* format, ...);
void IupSetStrfId(Ihandle *ih, const(char)* name, int id, const(char)* format, ...);
void IupSetStrfId2(Ihandle* ih, const(char)* name, int lin, int col, const(char)* format, ...);
void IupMessagef(const(char)* title, const(char)* format, ...);

int IupScanf(const(char)* format, ...);
int IupGetParam(const(char)* title, Iparamcb action, void* user_data, const(char)* format, ...);
int IupGetParamv(const(char)* title, Iparamcb action, void* user_data, const(char)* format, int param_count, int param_extra, void** param_data);

Icallback IupGetCallback(Ihandle* ih, const(char)* name);
Icallback IupSetCallback(Ihandle* ih, const(char)* name, Icallback func);

void IupTreeSetAttributeHandle(Ihandle* ih, const(char)* name, int id, Ihandle* ih_named);

#endif
+/

/** \brief Name space for C++ high level API
 *
 * \par
 * Defines wrapper classes for all C structures.
 *
 * See \ref iup_plus.h
 */
//namespace iup {
////  char* Version() { return IupVersion(); }
////  char* VersionDate() { return IupVersionDate(); }
////  int VersionNumber() { return IupVersionNumber(); }

////  int Open(ref int argc, ref char** argv) { return IupOpen(&argc, &argv); }
int IupOpenD()
{
    import core.runtime : Runtime;
    return  IupOpen(&Runtime.cArgs.argc, &Runtime.cArgs.argv);
}
deprecated int IupOpenD(in string[] args) // ... main(string[] args) // C: int main(int argc, char **argv)
{
//  TODO check if there is a smarter (library supported?) solution to get from string[] to char*[]
//  passing local adresses/pointers seemed to work as well, but better not to; inform the GC not to collect
	import core.memory : GC;
	int*    argc_ptr = new int;
	char*** argv_ptr = new char**;
	GC.addRoot(/*cast(void*)*/argc_ptr);
	GC.setAttr(/*cast(void*)*/argc_ptr, GC.BlkAttr.NO_MOVE);
	GC.addRoot(/*cast(void*)*/argv_ptr);
	GC.setAttr(/*cast(void*)*/argv_ptr, GC.BlkAttr.NO_MOVE);

	*argc_ptr = cast(int) args.length;
	char*[] args_carray;
	foreach (s; args)
		args_carray ~= cast(char*) s.toStringz;
	*argv_ptr = args_carray.ptr;

	return IupOpen(argc_ptr, argv_ptr);
}

// Avoid functions, that do nothing else than simply introducing new names/aliasing
////  void Close() { IupClose(); }  or  alias Close = IupClose;
////  void ImageLibOpen() { IupImageLibOpen(); }

////  int MainLoop() { return IupMainLoop(); }
////  int LoopStep() { return IupLoopStep(); }
////  int LoopStepWait() { return IupLoopStepWait(); }
////  int MainLoopLevel() { return IupMainLoopLevel(); }
////  void Flush() { IupFlush(); }
////  void ExitLoop() { IupExitLoop(); }

////  int RecordInput(const(char)* filename, int mode) { return IupRecordInput(filename, mode); }
////  int  PlayInput(const(char)* filename) { return IupPlayInput(filename); }

////  int Help(const(char)* url) { return IupHelp(url); }
////  void Log(const(char)* type, const(char)* str) { IupLog(type, "%s", str); }
////  const(char)* Load(const(char)* filename) { return IupLoad(filename); }
////  const(char)* LoadBuffer(const(char)* buffer) { return IupLoadBuffer(buffer); }

////  void SetLanguage(const(char)* lng) { IupSetLanguage(lng); }
////  const(char)* GetLanguage() { return IupGetLanguage(); }
////  void SetLanguageString(const(char)* name, const(char)* str) { IupSetLanguageString(name, str); }
////  void StoreLanguageString(const(char)* name, const(char)* str) { IupStoreLanguageString(name, str); }
////  const(char)* GetLanguageString(const(char)* name) { return IupGetLanguageString(name); }

////  int GetAllClasses(char** names, int n) { return IupGetAllClasses(names, n); }
////  int GetClassAttributes(const(char)* classname, char** names, int n) { return IupGetClassAttributes(classname, names, n); }
////  int GetClassCallbacks(const(char)* classname, char** names, int n) { return IupGetClassCallbacks(classname, names, n); }
////  void SetClassDefaultAttribute(const(char)* classname, const(char)* name, const(char)* value) { IupSetClassDefaultAttribute(classname, name, value); }

////  void SetGlobal(const(char)* name, const(char)* value) { IupSetGlobal(name, value); }
////  void SetStringGlobal(const(char)* name, const(char)* value) { IupSetStrGlobal(name, value); }
////  char* GetGlobal(const(char)* name) { return IupGetGlobal(name); }

////  int GetFile(char *arq) { return IupGetFile(arq); }
////  void Message(const(char)* title, const(char)* msg) { IupMessage(title, msg); }
////  int Alarm(const(char)* title, const(char)* msg, const(char)* b1, const(char)* b2, const(char)* b3) { return IupAlarm(title, msg, b1, b2, b3); }
////  int ListDialog(int type, const(char)* title, int size, const(char)** list, int op, int max_col, int max_lin, int* marks) { return IupListDialog(type, title, size, list, op, max_col, max_lin, marks); }
////  int GetText(const(char)* title, char* text, int maxsize = 10240) { return IupGetText(title, text, maxsize); }
////  int GetColor(int x, int y, ubyte &r, ubyte &g, ubyte &b) { return IupGetColor(x, y, &r, &g, &b); }

////  int GetAllNames(char** names, int n) { return IupGetAllNames(names, n); }
////  int GetAllDialogs(char** names, int n) { return IupGetAllDialogs(names, n); }

enum FILL_TYPE {
	FILL_NONE,
	FILL_FRONT,
	FILL_BACK,
	FILL_BETWEEN,
	FILL_FRONT_AND_BACK,
	FILL_FRONT_AND_BETWEEN,
	FILL_BACK_AND_BETWEEN,
	FILL_FRONT_AND_BACK_AND_BETWEEN
}

class /*Element*/ Handle // used as base class
{
  private Ihandle* _ih;

  nothrow:

  /* forbidden */
  private this() { this(cast(Ihandle*)null); }
  /*private*/ this(Ihandle* ref_ih)  { _ih = ref_ih; }
  this(/*Element*/Handle elem) { this(elem._ih); }
//  alias _ih this; // will only be usable within the class hierarchy, not from "outside"
  // There is no destructor because all iup::Handle are just a reference to the Ihandle*,
  // since several IUP elements are automatically destroyed when the dialog is destroyed
  // So, to force an element to be destructed call the Destroy method
//  invariant() { assert(_ih != null); }

  @property Ihandle* GetHandle() @nogc { return _ih; }

  @property bool Failed() {
    return _ih == null;
  }
//alias  _     = GetHandle;
/*
Naming:
When (after Set/Get) Attribute/User comes first, parameter types are the same as Iup...-function, thus SetAttribute and IupSetAttribute have the same signature (except Ihandle* _ih)
When (after Set/Get) String/Integer/Double/RGB  signature has D types only
"mixed" SetStrAttr
*/
//final void   SetUserData (const(char)* name,         void* data) @nogc  { IupSetAttribute(       _ih, name, cast(char*)data); } // hides the cast; explicitely cast and use SetAttribute instead
  final void   SetAttribute(const(char)* name, const(char)* value) @nogc  { IupSetAttribute(       _ih, name,    value); }
  final void   SetAttributeVALUE(              const(char)* value) @nogc  { IupSetAttribute(       _ih, "VALUE", value); }
//final void*  GetUserData (const(char)* name)                     @nogc  { return cast(void*)IupGetAttribute(_ih, name); }
  final char*  GetAttribute(const(char)* name)                     @nogc  { return IupGetAttribute(_ih, name); }
  final char*  GetAttributeVALUE()                                 @nogc  { return IupGetAttribute(_ih, "VALUE"); }

// mixed C/D types to help with defining user attributes:
  final void   SetAttributeStr(   string name, const(char)* value)        { IupSetAttribute(       _ih, name.toStringz, value); }
  final char*  GetAttributeStr(   string name)                            { return IupGetAttribute(_ih, name.toStringz); }
//
  final void   SetString(         string name,       string value)        { IupSetStrAttribute(    _ih, name.toStringz, value.toStringz); }
  final void   SetStringVALUE(                       string value)        { IupSetStrAttribute(    _ih, "VALUE",        value.toStringz); }
  final string GetString(         string name)                            { return IupGetAttribute(_ih, name.toStringz).fromStringz.idup; } // decoupled from C's string
  final string GetStringVALUE()                                           { return IupGetAttribute(_ih, "VALUE"       ).fromStringz.idup; } // decoupled from C's string

  final void   SetInteger(        string name,          int value)        { IupSetInt(_ih, name.toStringz, value); }
  final void   SetIntegerVALUE(                         int value)        { IupSetInt(_ih, "VALUE",        value); }
  final int    GetInteger(        string name)                            { return IupGetInt(_ih, name.toStringz); }
  final int    GetIntegerVALUE()                                          { return IupGetInt(_ih, "VALUE"); }

  final void   GetIntegerInteger( string name, out int i1, out int i2)    { IupGetIntInt(_ih, name.toStringz, &i1, &i2); }

  final void   SetDouble(         string name,       double value)        { IupSetDouble(_ih, name.toStringz, value); }
  final void   SetDoubleVALUE(                       double value)        { IupSetDouble(_ih, "VALUE",        value); }
  final double GetDouble(         string name)                            { return IupGetDouble(_ih, name.toStringz); }
  final double GetDoubleVALUE()                                           { return IupGetDouble(_ih, "VALUE"); }
  final void   SetRGB(            string name, ubyte r, ubyte g, ubyte b) { IupSetRGB(_ih, name.toStringz, r, g, b); }
  final void   GetRGB(            string name, out ubyte r, out ubyte g, out ubyte b)  { IupGetRGB(_ih, name.toStringz, &r, &g, &b); }
////
//final void   SetUserDataId (const(char)* name, int id, void* data) @nogc         {         IupSetAttributeId(_ih, name, id, cast(char*)data); }
  final void   SetAttributeId(const(char)* name, int id, const(char)* value) @nogc {         IupSetAttributeId(_ih, name, id, value); }
//final void*  GetUserDataId (const(char)* name, int id) @nogc            { return cast(void*)IupGetAttributeId(_ih, name, id); }
  final char*  GetAttributeId(const(char)* name, int id)            @nogc { return  IupGetAttributeId(_ih, name, id); }

  final void   SetStringId (    string name, int id, string value)        { IupSetStrAttributeId(_ih, name.toStringz, id, value.toStringz); }
  final string GetStringId (    string name, int id)                      { return IupGetAttributeId(_ih, name.toStringz, id).fromStringz.idup; } // decoupled from C's string
  final void   SetIntegerId(    string name, int id,    int value)        { IupSetIntId(_ih, name.toStringz, id, value); }
  final int    GetIntegerId(    string name, int id)                      { return IupGetIntId(_ih, name.toStringz, id); }
  final void   SetDoubleId (    string name, int id, double value)        { IupSetDoubleId(_ih, name.toStringz, id, value); }
  final double GetDoubleId (    string name, int id)                      { return IupGetDoubleId(_ih, name.toStringz, id); }
  final void   SetRGBId(        string name, int id, ubyte r, ubyte g, ubyte b)             { IupSetRGBId(_ih, name.toStringz, id, r, g, b); }
  final void   GetRGBId(        string name, int id, out ubyte r, out ubyte g, out ubyte b) { IupGetRGBId(_ih, name.toStringz, id, &r, &g, &b); }
////
  final void   SetAttributeId2(const(char)* name, int lin, int col, const(char)* value) @nogc {        IupSetAttributeId2(_ih, name, lin, col, value); }
  final char*  GetAttributeId2(const(char)* name, int lin, int col)                     @nogc { return IupGetAttributeId2(_ih, name, lin, col); }
//final void   SetUserDataId2 (const(char)* name, int lin, int col, void* data) @nogc { IupSetAttributeId2(_ih, name, lin, col, cast(char*)data); }
//final void*  GetUserDataId2 (const(char)* name, int lin, int col) @nogc             { return cast(void*)IupGetAttributeId2(_ih, name, lin, col); }

  final void   SetStringId2 (     string name, int lin, int col, string value) { IupSetStrAttributeId2(_ih, name.toStringz, lin, col, value.toStringz); }
  final string GetStringId2 (     string name, int lin, int col)               { return IupGetAttributeId2(_ih, name.toStringz, lin, col).fromStringz.idup; } // decoupled from C's string
  final void   SetIntegerId2(     string name, int lin, int col, int value)    { IupSetIntId2(_ih, name.toStringz, lin, col, value); }
  final int    GetIntegerId2(     string name, int lin, int col)               { return IupGetIntId2(_ih, name.toStringz, lin, col); }
  final void   SetDoubleId2 (     string name, int lin, int col, double value) { IupSetDoubleId2(_ih, name.toStringz, lin, col, value); }
  final double GetDoubleId2 (     string name, int lin, int col)               { return IupGetDoubleId2(_ih, name.toStringz, lin, col); }
  final void   SetRGBId2    (     string name, int lin, int col, ubyte r, ubyte g, ubyte b) { IupSetRGBId2(_ih, name.toStringz, lin, col, r, g, b); }
  final void   GetRGBId2    (     string name, int lin, int col, out ubyte r, out ubyte g, out ubyte b) { IupGetRGBId2(_ih, name.toStringz, lin, col, &r, &g, &b); }

  /*Element*/Handle SetAttributes(const(char)* str) { return new /*Element*/Handle(IupSetAttributes(_ih, str)); }
  final void   ResetAttribute(    string name)                                 { IupResetAttribute(_ih, name.toStringz); }
  final int GetAllAttributes(ref string[] names/*, int n*/) {
  	int n_max = IupGetAllAttributes(_ih, null, 0);
    if (names is null /* || n==0*/)
      return n_max;
    else {
      names.length = n_max;
      char*[] arr = new char*[](n_max);
      int res = IupGetAllAttributes(_ih, arr.ptr, n_max);
      foreach(i, c; arr)
        names[i] = c.fromStringz.idup;
      return res;
    }
  }
  final void SetAttributeHandle(string name, /*Element*/Handle elem) { IupSetAttributeHandle(_ih, name.toStringz, elem.GetHandle); }
//final /*Element*/Handle GetAttributeHandle(string name) { return new /*Element*/Handle(IupGetAttributeHandle(_ih, name.toStringz)); }
  /*Element*/Handle GetAttributeHandle(const(char)* name) { return new /*Element*/Handle(IupGetAttributeHandle(_ih, name)); }
  void SetAttributeHandleId(const(char)* name, int id, /*Element*/Handle elem) { IupSetAttributeHandleId(_ih, name, id, elem.GetHandle); }
  /*Element*/Handle GetAttributeHandleId(const(char)* name, int id) { return new /*Element*/Handle(IupGetAttributeHandleId(_ih, name, id)); }
  void SetAttributeHandleId2(const(char)* name, int lin, int col, /*Element*/Handle elem) { IupSetAttributeHandleId2(_ih, name, lin, col, elem.GetHandle); }
  /*Element*/Handle GetAttributeHandleId2(const(char)* name, int lin, int col) { return new /*Element*/Handle(IupGetAttributeHandleId2(_ih, name, lin, col)); }

  Icallback GetCallback(const(char)* name) { return IupGetCallback(_ih, name); }
//  Icallback SetCallback(const(char)* name, Icallback func) { return IupSetCallback(_ih, name, func); }

  final void Destroy() @nogc { IupDestroy(_ih); }

  final int Map() @nogc { return IupMap(_ih); }
  final void Unmap() @nogc { IupUnmap(_ih); }

  final string GetName() { return IupGetName(_ih).fromStringz.idup; } // decoupled from C's string

  final string GetClassName() { return IupGetClassName(_ih).fromStringz.idup; } // decoupled from C's string
  final string GetClassType() { return IupGetClassType(_ih).fromStringz.idup; } // decoupled from C's string
  final void SaveClassAttributes() @nogc { IupSaveClassAttributes(_ih); }
  final void CopyClassAttributesTo(Handle dst) @nogc { IupCopyClassAttributes(_ih, dst._ih); }
  final int ClassMatch(const(char)* classname) @nogc { return IupClassMatch(_ih, classname); }

  final Icallback SetCallback (const(char)* name, Icallback func) @nogc { return IupSetCallback(_ih, name, func); }

  final Handle SetHandle(const(char)* name) { return new Handle(IupSetHandle(name, _ih)); } // returned Handle's member _ih may be null
  final Handle SetHandle(string       name) { return new Handle(IupSetHandle(name.toStringz, _ih)); } // returned Handle's member _ih may be null

  // Timer
  void start() @nogc {}
  void stop()  @nogc {}
// Dialog/Menu
  int Popup(int x, int y) { return 0; }
// Dialog/Control
  int Show() { return 0; }
  int Hide() { return 0; }

// Control
  void Update() {}
  void Redraw() {}
  void Refresh() {}
// Container
  void UpdateChildren() {}
  void RedrawChildren() {}
  void RefreshChildren() {}


} // class Handle

Handle createHandle(Ihandle* ih)       nothrow { return new Handle(ih); } // createHandle was named GetHandle before
Handle createHandle(const(char)* name) nothrow { return new Handle(IupGetHandle(name)); }
Handle createHandle(string       name) nothrow { return new Handle(IupGetHandle(name.toStringz)); }

//Handle SetHandle(const(char)* name, Handle handle) nothrow { return new Handle(IupSetHandle(name, handle.GetHandle())); } // returned Handle's member _ih may be null
//Handle SetHandle(string       name, Handle handle) nothrow { return new Handle(IupSetHandle(name.toStringz, handle.GetHandle())); } // returned Handle's member _ih may be null
void SetLanguagePack(Handle handle) @nogc nothrow { IupSetLanguagePack(handle.GetHandle()); }


class Control : Handle
{
  nothrow:
  private this(Ihandle* ih) { super(ih); }
//  alias _ih this;

  override void Update() { IupUpdate(_ih); }
  override void Redraw() { IupRedraw(_ih, 1); }
  override void Refresh() { IupRefresh(_ih); }

  final void Detach(Control child) { IupDetach(child._ih); }

  final Control GetBrother() {
    return new Control(IupGetBrother(_ih));
  }
  final Container GetParent() {
    if (_ih==null)
      return new Container(null);
    else {
      Ihandle* ih_parent = IupGetParent(_ih);
      try {
        foreach (k, ref v; AA) {
          Ihandle* ih_v = v.GetHandle;
          if (ih_v!=null && ih_v==ih_parent)
            return cast(Container)v;
        }
      }
      catch (Exception e) { /* todo: handle exception */ }
    }
    return new Container(null);
  }

  final Dialog  GetDialog() { return new Dialog(IupGetDialog(_ih)); }
  final Control GetDialogChild(const(char)* name) { return new Control(IupGetDialogChild(_ih, name)); }
  final int Reparent(Container new_parent, Control ref_child) { return IupReparent(_ih, new_parent.GetHandle(), ref_child.GetHandle()); }


  final Control SetFocus() { return new Control(IupSetFocus(_ih)); }
  final Control PreviousField() { return new Control(IupPreviousField(_ih)); }
  final Control NextField() { return new Control(IupNextField(_ih)); }

/* IupText and IupScintilla utilities */
  final void ConvertLinColToPos(int lin, int col, out int pos) { IupTextConvertLinColToPos(_ih, lin, col, &pos); }
  final void ConvertPosToLinCol(int pos, out int lin, out int col) { IupTextConvertPosToLinCol(_ih, pos, &lin, &col); }

/* IupText, IupList, IupTree, IupMatrix and IupScintilla utility */
  final int ConvertXYToPos(int x, int y) { return IupConvertXYToPos(_ih, x, y); }

  override int Show() { return IupShow(_ih); }
  override int Hide() { return IupHide(_ih); }
}

ptrdiff_t index_first_null(ref Control[] child_array) nothrow {
    import std.algorithm.searching : countUntil;
    ptrdiff_t  result;
    result = child_array.countUntil!"a is null";
    if (result == -1) {
        result = child_array.length;
        child_array ~= new Control(null); // used as Terminator
    }
    return result;
}

Control GetFocus() nothrow {
  Ihandle* ih_focus = IupGetFocus();
  if (ih_focus==null)
    return new Control(null);
  else {
    try {
      foreach (k, ref v; AA) {
      	Ihandle* ih_v = v.GetHandle;
        if (ih_v!=null && ih_v==ih_focus)
          return cast(Control)v;
      }
    }
    catch (Exception e) { /* todo: handle exception */ }
    return new Control(null);
  }
}

class Container : Control
{
  nothrow:
//  @disable this();
  this(Ihandle* ih) { super(ih); }
  this(Ihandle* ih, Control[] child_array, FILL_TYPE fill=FILL_TYPE.FILL_NONE) {
    super(ih);
//    child_array ~= new Control(null);
    int cnt = 0;
	with (FILL_TYPE) {
      if (fill==FILL_FRONT || fill==FILL_FRONT_AND_BACK)
        IupAppend(_ih, IupFill());
      foreach (c; child_array) {
        if ((fill==FILL_BETWEEN && cnt)|| fill==FILL_FRONT_AND_BETWEEN || (fill==FILL_BACK_AND_BETWEEN && cnt) || fill==FILL_FRONT_AND_BACK_AND_BETWEEN)
          IupAppend(_ih, IupFill());
        IupAppend(_ih, c.GetHandle());
        ++cnt;
      }
      if (fill==FILL_BACK || fill==FILL_FRONT_AND_BACK || fill==FILL_BACK_AND_BETWEEN || fill==FILL_FRONT_AND_BACK_AND_BETWEEN)
        IupAppend(_ih, IupFill());
	}
  }

  this(Ihandle* ih, Control child0, Control child1 = null, Control child2 = null, Control child3 = null, Control child4 = null,
  	Control child5 = null, Control child6 = null, Control child7 = null, Control child8 = null, Control child9 = null)
  {
    super(ih);
    if (child0 !is null) IupAppend(_ih, child0.GetHandle());
    if (child1 !is null) IupAppend(_ih, child1.GetHandle());
    if (child2 !is null) IupAppend(_ih, child2.GetHandle());
    if (child3 !is null) IupAppend(_ih, child3.GetHandle());
    if (child4 !is null) IupAppend(_ih, child4.GetHandle());
    if (child5 !is null) IupAppend(_ih, child5.GetHandle());
    if (child6 !is null) IupAppend(_ih, child6.GetHandle());
    if (child7 !is null) IupAppend(_ih, child7.GetHandle());
    if (child8 !is null) IupAppend(_ih, child8.GetHandle());
    if (child9 !is null) IupAppend(_ih, child9.GetHandle());
  }
//  alias _ih this;

  Control Append(Control child) {
    Ihandle* ih_child = child.GetHandle();
    if (_ih==null || ih_child==null) // this has a null Ihandle*, etc.
      return new Control(null);
    Ihandle* ih_parent = IupAppend(_ih, ih_child);
    if (ih_parent==null || _ih != ih_parent)
      return new Control(null);
    else {
      try {
        foreach (k, ref v; AA) {
          if (v.GetHandle!=null && v.GetHandle==ih_parent)
            return cast(Control)v;
        }
      }
      catch (Exception e) { /* todo: handle exception */ }
      return new Control(null);
    }
  }

  Control Insert(Control ref_child, Control child) {
    if (_ih==null || ref_child.GetHandle()==null || child.GetHandle()==null) // this has a null Ihandle*, etc.
      return new Control(null);
    Ihandle* ih_parent = IupInsert(_ih, ref_child.GetHandle(), child.GetHandle());
    if (ih_parent==null || _ih != ih_parent)
      return new Control(null);
    else { //lookup in AA
      try {
        foreach (k, ref v; AA) {
          if (v.GetHandle!=null && v.GetHandle==ih_parent)
            return cast(Control)v;
        }
      }
      catch (Exception e) { /* todo: handle exception */ }
      return new Control(null);
    }
  }
  Control GetChild(int pos) { return new Control(IupGetChild(_ih, pos)); }
  int GetChildPos(Control child) { return IupGetChildPos(_ih, child.GetHandle()); }
  int GetChildCount() { return IupGetChildCount(_ih); }

  Control GetFirstChild() { return new Control(IupGetNextChild(_ih, null)); }
  Control GetNextChild(Control ref_child) { return new Control(IupGetNextChild(_ih, ref_child.GetHandle())); }

  override void UpdateChildren() { IupUpdateChildren(_ih); }
  override void RedrawChildren() { IupRedraw(_ih, 1); }
  override void RefreshChildren() { IupRefreshChildren(_ih); }
}

class Dialog : Container
{
  private bool _autoDestroy;
  nothrow:
//    Dialog(const Control& child) : Container(IupDialog(child.GetHandle())) { }
//  @disable this();
  this(                             Ihandle* ih)   { this(false, ih); }
  this(           bool autoDestroy, Ihandle* ih)   { super(ih); _autoDestroy = autoDestroy; }
  this(           bool autoDestroy, Control child) { super(IupDialog(child.GetHandle())); _autoDestroy = autoDestroy; }
  this(string CN, bool autoDestroy, Control child) { this(autoDestroy, child); if (!CN.empty) { AA[CN] = this; IupSetHandle(CN.toStringz, _ih); } }
  ~this() { if (_autoDestroy) { Destroy(); /* TODO manage deleting from AA */ } }
//  alias _ih this;

  override int Popup(int x, int y) { return IupPopup(_ih, x, y); }
  override int Show() { return IupShow(_ih); }
  int ShowXY(int x, int y) { return IupShowXY(_ih, x, y); }
}

Dialog LayoutDialog(Dialog dialog) nothrow { return new Dialog(IupLayoutDialog(dialog.GetHandle())); }
Dialog ElementPropertiesDialog(Control control) nothrow { return new Dialog(IupElementPropertiesDialog(control.GetHandle())); }

void MessageError(Dialog parent, const(char)* message)
    { IupMessageError(parent.GetHandle(), message); }
int MessageAlarm(Dialog parent, const(char)* title, const(char)* message, const(char)* buttons)
    { return IupMessageAlarm(parent.GetHandle(), title, message, buttons); }


class Menu : Container
{
  nothrow:
  this() { super(IupMenu(null)); }
  this(Control child) { super(IupMenu(child.GetHandle(), null)); }
  this(Control child0, Control child1 = null, Control child2 = null, Control child3 = null, Control child4 = null,
    Control child5 = null, Control child6 = null, Control child7 = null, Control child8 = null, Control child9 = null)
      { super(IupMenu(null), child0, child1, child2, child3, child4, child5, child6, child7, child8, child9); }
////  this(Control[] child_array) { super(IupMenu(null), child_array); }

  override int Popup(int x, int y) { return IupPopup(_ih, x, y); }
}

version(IM) //#ifdef __IM_PLUS_H   // im.im_plusD is not ready to be published
{
public import iup.iupim : IupLoadImage, IupSaveImage, IupImageFromImImage, IupGetNativeHandleImage, IupGetImageNativeHandle;
public import im.im_plusD;

class Image : Handle
{
  nothrow:
  this(const(char)* filename) { super(IupLoadImage(filename)); }
  this(ref im.im_plusD.Image image) { super(IupImageFromImImage(image.GetHandle())); }

  int Save(const(char)* filename, const(char)* im_format) { return IupSaveImage(_ih, filename, im_format); }
  int SaveAsText(const(char)* filename, const(char)* iup_format, const(char)* name) { return IupSaveImageAsText(_ih, filename, iup_format, name); }
}

class Clipboard : Handle
{
  nothrow:
  this() { super(IupClipboard()); }

  void SetImage(ref im.im_plusD.Image image) { SetAttribute("NATIVEIMAGE", cast(const(char)*)IupGetImageNativeHandle(image.GetHandle())); }// SetUserData("NATIVEIMAGE", cast(const(char)*)IupGetImageNativeHandle(image.GetHandle()));

  im.im_plusD.Image GetImage() { return new im.im_plusD.Image(IupGetNativeHandleImage(GetAttribute("NATIVEIMAGE"))); }
}
//TODO imImage* IupImageToImImage(Ihandle* iup_image)
} // version(IM)


class User : Handle
{
  nothrow:
  this() { super(IupUser); }
}

class Param : Handle
{
  nothrow:
  this(const(char)* format) { super(IupParam(format)); }
}

class Timer : Handle
{
  nothrow:
  this()          { super(IupTimer); }
  this(string CN) { this(); if (!CN.empty) { AA[CN] = this; IupSetHandle(CN.toStringz, _ih); } }

  override void start() @nogc { SetAttribute(IUP_RUN, IUP_YES); }
  override void stop()  @nogc { SetAttribute(IUP_RUN, IUP_NO);  }
}

class MenuSeparator : Control
{
  nothrow:
  this() { super(IupSeparator()); }
}

class MenuItem : Control
{
  nothrow:
  this(const(char)* title = null) { super(IupItem(title, null)); }
}

class Canvas : Control
{
  nothrow:
  this() { super(IupCanvas(null)); }

  void DrawBegin() { IupDrawBegin(_ih); }
  void DrawEnd() { IupDrawEnd(_ih); }
  void DrawSetClipRect(int x1, int y1, int x2, int y2) { IupDrawSetClipRect(_ih, x1, y1, x2, y2); }
  void DrawGetClipRect(ref int x1, ref int y1, ref int x2, ref int y2) { IupDrawGetClipRect(_ih, &x1, &y1, &x2, &y2); }
  void DrawResetClip() { IupDrawResetClip(_ih); }
  void DrawParentBackground() { IupDrawParentBackground(_ih); }
  void DrawLine(int x1, int y1, int x2, int y2) { IupDrawLine(_ih, x1, y1, x2, y2); }
  void DrawRectangle(int x1, int y1, int x2, int y2) { IupDrawRectangle(_ih, x1, y1, x2, y2); }
  void DrawArc(int x1, int y1, int x2, int y2, double a1, double a2) { IupDrawArc(_ih, x1, y1, x2, y2, a1, a2); }
  void DrawPolygon(ref int points, int count) { IupDrawPolygon(_ih, &points, count); }
  void DrawText(const(char)* text, int len, int x, int y, int w, int h) { IupDrawText(_ih, text, len, x, y, w, h); } // signature changed from 3.24 to 3.25
  void DrawImage(const(char)* name, int x, int y, int w, int h) { IupDrawImage(_ih, name, x, y, w, h); } // signature changed from 3.24 to 3.25
  void DrawSelectRect(int x1, int y1, int x2, int y2) { IupDrawSelectRect(_ih, x1, y1, x2, y2); }
  void DrawFocusRect(int x1, int y1, int x2, int y2) { IupDrawFocusRect(_ih, x1, y1, x2, y2); }
  void DrawGetSize(ref int w, ref int h) { IupDrawGetSize(_ih, &w, &h); }
  void DrawGetTextSize(const(char)* str, int len, ref int w, ref int h) { IupDrawGetTextSize(_ih, str, len, &w, &h); } // signature changed from 3.24 to 3.25
  void DrawGetImageInfo(const(char)* name, ref int w, ref int h, ref int bpp) { IupDrawGetImageInfo(name, &w, &h, &bpp); }
}

class Link : Control
{
  nothrow:
  this(const(char)* url = null, const(char)* title = null) { super(IupLink(url, title)); }
}

class Label : Control
{
  nothrow:
  this(           const(char)* title = null) { super(IupLabel(title)); }
  this(string CN, const(char)* title)        { this(title); if (!CN.empty) { AA[CN] = this; IupSetHandle(CN.toStringz, _ih); } }
}

class Button : Control
{
  nothrow:
  this(           const(char)* title = null) { super(IupButton(title, null)); }
  this(string CN, const(char)* title)        { this(title); if (!CN.empty) { AA[CN] = this; IupSetHandle(CN.toStringz, _ih); } }
}

class FlatButton : Control
{
  nothrow:
  this(           const(char)* title = null) { super(IupFlatButton(title)); }
  this(string CN, const(char)* title)        { this(title); if (!CN.empty) { AA[CN] = this; IupSetHandle(CN.toStringz, _ih); } }
}

class FlatToggle : Control
{
    nothrow:
    this(const(char)* title = null) { super(IupFlatToggle(title)); }
    this(Ihandle* ih) { super(ih); }
    this(/*Element*/Handle elem) { this(elem._ih); }
}

class FlatSeparator : Control
{
    nothrow:
    this() { super(IupFlatSeparator()); }
    this(Ihandle* ih) { super(ih); }
    this(/*Element*/Handle elem) { this(elem._ih); }
}

class Space : Control
{
    nothrow:
    this() { super(IupSpace()); }
    this(Ihandle* ih) { super(ih); }
    this(/*Element*/Handle elem) { this(elem._ih); }
}

class DropButton : Control
{
    nothrow:
    this() { super(IupDropButton(null)); }
    this(Control child) { super(IupDropButton(child.GetHandle())); }
    this(Ihandle* ih) { super(ih); }
    this(/*Element*/Handle elem) { this(elem._ih); }
}

class FlatLabel : Control
{
    nothrow:
    this(const(char)* title = null) { super(IupFlatLabel(title)); }
    this(Ihandle* ih) { super(ih); }
    this(/*Element*/Handle elem) { this(elem._ih); }
}

class AnimatedLabel : Control
{
  nothrow:
  this(           Ihandle* animation = null) { super(IupAnimatedLabel(animation)); }
  this(string CN, Ihandle* animation)        { this(animation); if (!CN.empty) { AA[CN] = this; IupSetHandle(CN.toStringz, _ih); } }
}

class Toggle : Control
{
  nothrow:
  this(           const(char)* title = null) { super(IupToggle(title, null /*no action set by constructor */)); }
  this(string CN, const(char)* title)        { this(title); if (!CN.empty) { AA[CN] = this; IupSetHandle(CN.toStringz, _ih); } }
}

class Fill : Control
{
  nothrow:
  this() { super(IupFill); }
}

deprecated class Spin : Control
{
  nothrow:
  this() { super(IupSpin); }
}

class Calendar : Control
{
  nothrow:
  this()          { super(IupCalendar); }
  this(string CN) { this(); if (!CN.empty) { AA[CN] = this; IupSetHandle(CN.toStringz, _ih); } }
}

class Tree : Control
{
  nothrow:
  this() { super(IupTree); }
  this(string CN) { this(); if (!CN.empty) { AA[CN] = this; IupSetHandle(CN.toStringz, _ih); } }

  int SetUserId(int id, void* userid) { return IupTreeSetUserId(_ih, id, userid); }
  void* GetUserId(int id) { return IupTreeGetUserId(_ih, id); }
  int GetId(void* userid) { return IupTreeGetId(_ih, userid); }
  void  SetAttributeHandle(const(char)* name, int id, Ihandle* ih_named) { IupSetAttributeHandleId(_ih, name, id, ih_named); }
}

class Val : Control
{
  nothrow:
  this(const(char)* orientation = null) { super(IupVal(orientation)); }
}

class ProgressBar : Control
{
  nothrow:
  this() { super(IupProgressBar); }
}

class List : Control
{
  nothrow:
  this()          { super(IupList(null)); }
  this(string CN) { this(); if (!CN.empty) { AA[CN] = this; IupSetHandle(CN.toStringz, _ih); } }
}

class Text : Control
{
  nothrow:
  this()          { super(IupText(null)); }
  this(string CN) { this(); if (!CN.empty) { AA[CN] = this; IupSetHandle(CN.toStringz, _ih); } }
}


class Split : Container
{
  nothrow:
  this()                               { super(IupSplit(null, null)); }
  this(Control child)                  { super(IupSplit(child.GetHandle(), null)); }
  this(Control child1, Control child2) { super(IupSplit(child1.GetHandle(), child2.GetHandle())); }
}

class Submenu : Container
{
  nothrow:
  this(const(char)* title = null)         { super(IupSubmenu(title, null)); }
  this(const(char)* title, Control child) { super(IupSubmenu(title, child.GetHandle())); }
}

class Radio : Container
{
  nothrow:
  this()              { super(IupRadio(null)); }
  this(Control child) { super(IupRadio(child.GetHandle())); }
  this(string CN, Control child) { super(IupRadio(child.GetHandle())); if (!CN.empty) { AA[CN] = this; IupSetHandle(CN.toStringz, _ih); } }
}

class Sbox : Container
{
  nothrow:
  this()              { super(IupSbox(null)); }
  this(Control child) { super(IupSbox(child.GetHandle())); }
}

class ScrollBox : Container
{
  nothrow:
  this()              { super(IupScrollBox(null)); }
  this(Control child) { super(IupScrollBox(child.GetHandle())); }
}

class FlatScrollBox : Container
{
  nothrow:
  this()              { super(IupFlatScrollBox(null)); }
  this(Control child) { super(IupFlatScrollBox(child.GetHandle())); }
  this(FlatScrollBox container) { super(container.GetHandle()); }
  this(Ihandle* _ih)  { super(_ih); }
}

class Expander : Container
{
  nothrow:
  this()              { super(IupExpander(null)); }
  this(Control child) { super(IupExpander(child.GetHandle())); }
}

class DetachBox : Container
{
  nothrow:
  this()              { super(IupDetachBox(null)); }
  this(Control child) { super(IupDetachBox(child.GetHandle())); }
}

  class BackgroundBox : Container
  {
    nothrow:
    this()              { super(IupBackgroundBox(null)); }
    this(Control child) { super(IupBackgroundBox(child.GetHandle())); }

    void DrawBegin() { IupDrawBegin(_ih); }
    void DrawEnd() { IupDrawEnd(_ih); }
    void DrawSetClipRect(int x1, int y1, int x2, int y2) { IupDrawSetClipRect(_ih, x1, y1, x2, y2); }
    void DrawGetClipRect(ref int x1, ref int y1, ref int x2, ref int y2) { IupDrawGetClipRect(_ih, &x1, &y1, &x2, &y2); }
    void DrawResetClip() { IupDrawResetClip(_ih); }
    void DrawParentBackground() { IupDrawParentBackground(_ih); }
    void DrawLine(int x1, int y1, int x2, int y2) { IupDrawLine(_ih, x1, y1, x2, y2); }
    void DrawRectangle(int x1, int y1, int x2, int y2) { IupDrawRectangle(_ih, x1, y1, x2, y2); }
    void DrawArc(int x1, int y1, int x2, int y2, double a1, double a2) { IupDrawArc(_ih, x1, y1, x2, y2, a1, a2); }
    void DrawPolygon(int* points, int count) { IupDrawPolygon(_ih, points, count); }
    void DrawText(const(char)* text, int len, int x, int y, int w, int h) { IupDrawText(_ih, text, len, x, y, w, h); } // signature changed from 3.24 to 3.25
    void DrawImage(const(char)* name, int x, int y, int w, int h) { IupDrawImage(_ih, name, x, y, h, h); } // signature changed from 3.24 to 3.25
    void DrawSelectRect(int x1, int y1, int x2, int y2) { IupDrawSelectRect(_ih, x1, y1, x2, y2); }
    void DrawFocusRect(int x1, int y1, int x2, int y2) { IupDrawFocusRect(_ih, x1, y1, x2, y2); }
    void DrawGetSize(ref int w, ref int h) { IupDrawGetSize(_ih, &w, &h); }
    void DrawGetTextSize(const(char)* str, int len, ref int w, ref int h) { IupDrawGetTextSize(_ih, str, len, &w, &h); } // signature changed from 3.24 to 3.25
    void DrawGetImageInfo(const(char)* name, ref int w, ref int h, ref int bpp) { IupDrawGetImageInfo(name, &w, &h, &bpp); }
  }

class Frame : Container
{
  nothrow:
  this()              { super(IupFrame(null)); }
  this(Control child) { super(IupFrame(child.GetHandle)); }
}


class FlatFrame : Container
{
  nothrow:
  this()              { super(IupFlatFrame(null)); }
  this(Control child) { super(IupFlatFrame(child.GetHandle)); }
}
deprecated class Spinbox : Container
{
  nothrow:
  this()              { super(IupSpinbox(null)); }
  this(Control child) { super(IupSpinbox(child.GetHandle())); }
}

class Vbox : Container //TODO do care for last element/child=null
{
  nothrow:
  this()              { super(IupVbox(null)); }
  this(Ihandle* ih)   { super(ih); } // temporarily
  this(Control child) { super(IupVbox(child.GetHandle, null)); }
  this(Control child0, Control child1 = null, Control child2 = null, Control child3 = null, Control child4 = null,
    Control child5 = null, Control child6 = null, Control child7 = null, Control child8 = null, Control child9 = null)
    { super(IupVbox(null), child0, child1, child2, child3, child4, child5, child6, child7, child8, child9); }

  this(           Control[] child_array, FILL_TYPE fill=FILL_TYPE.FILL_NONE) { super(IupVbox(null), child_array, fill); }
  this(string CN, Control[] child_array, FILL_TYPE fill=FILL_TYPE.FILL_NONE) { this(child_array, fill); if (!CN.empty) { AA[CN] = this; IupSetHandle(CN.toStringz, _ih); } }
}

class Hbox : Container
{
  nothrow:
  this()              { super(IupHbox(null)); }
  this(Ihandle* ih)   { super(ih); } // temporarily
  this(Control child) { super(IupHbox(child.GetHandle, null)); }

  this(Control child0, Control child1 = null, Control child2 = null, Control child3 = null, Control child4 = null,
     Control child5 = null, Control child6 = null, Control child7 = null, Control child8 = null, Control child9 = null)
    { super(IupHbox(null), child0, child1, child2, child3, child4, child5, child6, child7, child8, child9); }
  this(string CN, Control child0, Control child1 = null, Control child2 = null, Control child3 = null, Control child4 = null,
    Control child5 = null, Control child6 = null, Control child7 = null, Control child8 = null, Control child9 = null)
    { this(child0, child1, child2, child3, child4, child5, child6, child7, child8, child9);
      if (!CN.empty) { AA[CN] = this; IupSetHandle(CN.toStringz, _ih); } }

  this(           Control[] child_array, FILL_TYPE fill=FILL_TYPE.FILL_NONE) { super(IupHbox(null), child_array, fill); }
  this(string CN, Control[] child_array, FILL_TYPE fill=FILL_TYPE.FILL_NONE) { this(child_array, fill); if (!CN.empty) { AA[CN] = this; IupSetHandle(CN.toStringz, _ih); } }
}

  class Zbox : Container
  {
    nothrow:
    this() { super(IupZbox(null)); }
    this(Control child) { super(IupZbox(child.GetHandle(), null)); }
    this(Control child0, Control child1 = null, Control child2 = null, Control child3 = null, Control child4 = null,
      Control child5 = null, Control child6 = null, Control child7 = null, Control child8 = null, Control child9 = null)
      { super(IupZbox(null), child0, child1, child2, child3, child4, child5, child6, child7, child8, child9); }
    this(Control[] child_array) { super(IupZbox(null), child_array); }
  }

  class Cbox : Container
  {
    nothrow:
    this() { super(IupCbox(null)); }
    this(Control child) { super(IupCbox(child.GetHandle(), null)); }
    this(Control child0, Control child1 = null, Control child2 = null, Control child3 = null, Control child4 = null,
      Control child5 = null, Control child6 = null, Control child7 = null, Control child8 = null, Control child9 = null)
      { super(IupCbox(null), child0, child1, child2, child3, child4, child5, child6, child7, child8, child9); }
    this(Control[] child_array) { super(IupCbox(null), child_array); }
  }


class Tabs : Container
{
    nothrow:
    this()                        { super(IupTabs(null)); }
//  this(Ihandle* ih)             { super(ih); } // temporarily
//  this(string CN, Ihandle* ih)  { super(ih); if (!CN.empty) { AA[CN] = this; IupSetHandle(CN.toStringz, _ih); } } // temporarily
    this(Control child) { super(IupTabs(child.GetHandle(), null)); }
    this(Control child0, Control child1 = null, Control child2 = null, Control child3 = null, Control child4 = null,
        Control child5 = null, Control child6 = null, Control child7 = null, Control child8 = null, Control child9 = null)
    {
        Control[] child_array;
        child_array ~= child0; child_array ~= child1; child_array ~= child2; child_array ~= child3; child_array ~= child4;
        child_array ~= child5; child_array ~= child6; child_array ~= child7; child_array ~= child8; child_array ~= child9;
        this(child_array);
    }
    this(Control[] child_array)
    {
        ptrdiff_t  index = index_first_null(child_array);
        if      (index==0)
            this();
        else if (index==1)
            this(child_array[0]);
        else {
            Ihandle*[] arr_ih = new Ihandle*[index+1];
            foreach (i; 0..index)
                arr_ih[i] = child_array[i].GetHandle();
            arr_ih[index] = null;
            super(IupTabsv(arr_ih.ptr));
       }
//      super(IupTabs(null), child_array);
  }
  this(string CN, Control[] child_array) { this(child_array); if (!CN.empty) { AA[CN] = this; IupSetHandle(CN.toStringz, _ih); } }
}

class GridBox : Container
{
  nothrow:
  this() { super(IupGridBox(null)); }
  this(Control child) { super(IupGridBox(child.GetHandle(), null)); }
  this(Control child0, Control child1 = null, Control child2 = null, Control child3 = null, Control child4 = null,
    Control child5 = null, Control child6 = null, Control child7 = null, Control child8 = null, Control child9 = null)
    { super(IupGridBox(null), child0, child1, child2, child3, child4, child5, child6, child7, child8, child9); }
  this(Control[] child_array) { super(IupGridBox(null), child_array); }
}

class ParamBox : Container
{
  nothrow:
  this() { super(IupParamBox(null)); }
  this(Control child) { super(IupParamBox(child.GetHandle(), null)); }
  this(Control child0, Control child1 = null, Control child2 = null, Control child3 = null, Control child4 = null,
    Control child5 = null, Control child6 = null, Control child7 = null, Control child8 = null, Control child9 = null)
    { super(IupParamBox(child0.GetHandle(), child1.GetHandle(), child2.GetHandle(), child3.GetHandle(), child4.GetHandle(),
    child5.GetHandle(), child6.GetHandle(), child7.GetHandle(), child8.GetHandle(), child9.GetHandle(), null)); }
}

  class Normalizer : Container
  {
    nothrow:
    this() { super(IupNormalizer(null)); }
    this(Control child) { super(IupNormalizer(child.GetHandle(), null)); }
    this(Control child0, Control child1 = null, Control child2 = null, Control child3 = null, Control child4 = null,
      Control child5 = null, Control child6 = null, Control child7 = null, Control child8 = null, Control child9 = null)
      { super(IupNormalizer(null), child0, child1, child2, child3, child4, child5, child6, child7, child8, child9); }
    this(Control[] child_array) { super(IupNormalizer(null), child_array); }
  }


class FileDialog : Dialog
{
  nothrow:
  this() { super(IupFileDlg); }
}

class MessageDialog : Dialog
{
  nothrow:
  this(bool autoDestroy = true) { super(autoDestroy, IupMessageDlg()); }
}

class ColorDialog : Dialog
{
  nothrow:
  this() { super(IupColorDlg); }
}

class FontDialog : Dialog
{
  nothrow:
  this() { super(IupFontDlg); }
}

class ProgressDialog : Dialog
{
  nothrow:
  this() { super(IupProgressDlg); }
}

version(IUP_SCINTILLA)
{
class ScintillaDlg : Dialog
{
  public import iup.iup_scintilla;
  nothrow:
  this() { super(IupScintillaDlg()); }
}
}
/+
#ifdef LUA_VERSION
  public:
    LuaScripterDlg(lua_State *L) : Dialog(IupLuaScripterDlg(L)) {}
  };
#endif
+/
version(IUP_GL)
{
  public import iup.iupgl;

  class GLCanvas : Control
  {
    nothrow:
    this() { super(IupGLCanvas(null)); }

    static void Open() { IupGLCanvasOpen; }

    void MakeCurrent() { IupGLMakeCurrent(_ih); }
    int IsCurrent() { return IupGLIsCurrent(_ih); }
    void SwapBuffers() { IupGLSwapBuffers(_ih); }
    void Palette(int index, float r, float g, float b) { IupGLPalette(_ih, index, r, g, b); }
    void UseFont(int first, int count, int list_base) { IupGLUseFont(_ih, first, count, list_base); }

    static void Wait(int gl) { IupGLWait(gl); }
  }

  class GLBackgroundBox : Container
  {
    nothrow:
    this() { super(IupGLBackgroundBox(null)); }
    this(Control child) { super(IupGLBackgroundBox(child.GetHandle)); }
  }
}
/+
  class Controls
  {
    static void Open() { IupControlsOpen(); }
  }
+/
class Dial : Control
{
  nothrow:
  this(const(char)* orientation = null) { super(IupDial(orientation)); }
}

class Gauge : Control
{
  nothrow:
  this() { super(IupGauge); }
}

class ColorBrowser : Control
{
  nothrow:
  this() { super(IupColorBrowser); }
}

class Cells : Control
{
  nothrow:
  this() { super(IupCells); }
}

class Colorbar : Control
{
  nothrow:
  this() { super(IupColorbar); }
}

class Matrix : Control
{
  nothrow:
  this()          { super(IupMatrix(null)); }
  this(string CN) { this(); if (!CN.empty) { AA[CN] = this; IupSetHandle(CN.toStringz, _ih); } }

//  void SetFormula(int col, const(char)* formula, const(char)* init = null) { IupMatrixSetFormula(_ih, col, formula, init); }
//  void SetDynamic(const(char)* init = null) { IupMatrixSetDynamic(_ih, init); }
}

class MatrixList : Control
{
  nothrow:
  this()          { super(IupMatrixList); }
  this(string CN) { this(); if (!CN.empty) { AA[CN] = this; IupSetHandle(CN.toStringz, _ih); } }
}

version(none/*IUP_MATRIXEX*/) {
/+
  public import iup.iupmatrixex;

  class MatrixEx : Control
  {
    nothrow:
    this() { super(IupMatrixEx); }

    static void Open() { IupMatrixExOpen; }
  }
+/
}

version(IUP_GLCONTROLS)
{
  public import iup.iupglcontrols;

/+
  class GLControls
  {
    static void Open() { IupGLControlsOpen(); }
  }
+/

  class GLSubCanvas : Control
  {
    nothrow:
    this() { super(IupGLSubCanvas); }
  }

  class GLSeparator : Control
  {
    nothrow:
    this() { super(IupGLSeparator); }
  }

  class GLProgressBar : Control
  {
    nothrow:
    this() { super(IupGLProgressBar); }
  }

  class GLVal : Control
  {
    nothrow:
    this() { super(IupGLVal); }
  }

  class GLLabel : Control
  {
    nothrow:
    this(const(char)* title = null) { super(IupGLLabel(title)); }
  }

  class GLButton : Control
  {
    nothrow:
    this(const(char)* title = null) { super(IupGLButton(title)); }
  }

  class GLToggle : Control
  {
    nothrow:
    this(const(char)* title = null) { super(IupGLToggle(title)); }
  }

  class GLLink : Control
  {
    nothrow:
    this(const(char)* url = null, const(char)* title = null) { super(IupGLLink(url, title)); }
  }

  class GLFrame : Container
  {
    nothrow:
    this(Control child) { super(IupGLFrame(child.GetHandle)); }
    this() { super(IupGLFrame(null)); }
  }

  class GLExpander : Container
  {
    nothrow:
    this(Control child) { super(IupGLExpander(child.GetHandle)); }
    this() { super(IupGLExpander(null)); }
  }

  class GLScrollBox : Container
  {
    nothrow:
    this(Control child) { super(IupGLScrollBox(child.GetHandle)); }
    this() { super(IupGLScrollBox(null)); }
  }

  class GLSizeBox : Container
  {
    nothrow:
    this(Control child) { super(IupGLSizeBox(child.GetHandle)); }
    this() { super(IupGLSizeBox(null)); }
  }

  class GLCanvasBox : Container
  {
    nothrow:
    this() { super(IupGLCanvasBox(null)); }
    this(Control child) { super(IupGLCanvasBox(child.GetHandle(), null)); }
    this(Control child0, Control child1 = null, Control child2 = null, Control child3 = null, Control child4 = null,
      Control child5 = null, Control child6 = null, Control child7 = null, Control child8 = null, Control child9 = null)
      { super(IupGLCanvasBox(null), child0, child1, child2, child3, child4, child5, child6, child7, child8, child9); }
    this(Control[] child_array) { super(IupGLCanvasBox(null), child_array); }
  }

} // version(IUP_GLCONTROLS)

version(IUP_PLOT) {
  public import iup.iup_plot;

  class Plot : Control
  {
    nothrow:
    this() { super(IupPlot); }

    static void Open() { IupPlotOpen; }

    void Begin(int strXdata) { IupPlotBegin(_ih, strXdata); }
    void Add(double x, double y) { IupPlotAdd(_ih, x, y); }
    void AddStr(const(char)* x, double y) { IupPlotAddStr(_ih, x, y); }
    void AddSegment(double x, double y) { IupPlotAddSegment(_ih, x, y); }
    int End() { return IupPlotEnd(_ih); }

    int LoadData(const(char)* filename, int strXdata) { return IupPlotLoadData(_ih, filename, strXdata); }

//  int SetFormula(int sample_count, const(char)* formula, const(char)* init) { return IupPlotSetFormula(_ih, sample_count, formula, init); }

    void Insert(int ds_index, int sample_index, double x, double y) { IupPlotInsert(_ih, ds_index, sample_index, x, y); }
    void InsertStr(int ds_index, int sample_index, const(char)* x, double y) { IupPlotInsertStr(_ih, ds_index, sample_index, x, y); }
    void InsertSegment(int ds_index, int sample_index, double x, double y) { IupPlotInsertSegment(_ih, ds_index, sample_index, x, y); }

    void InsertStrSamples(int ds_index, int sample_index, const(char)** x, double* y, int count) { IupPlotInsertStrSamples(_ih, ds_index, sample_index, x, y, count); }
    void InsertSamples(int ds_index, int sample_index, double* x, double* y, int count) { IupPlotInsertSamples(_ih, ds_index, sample_index, x, y, count); }

    void AddSamples(int ds_index, double* x, double* y, int count) { IupPlotAddSamples(_ih, ds_index, x, y, count); }
    void AddStrSamples(int ds_index, const(char)** x, double* y, int count) { IupPlotAddStrSamples(_ih, ds_index, x, y, count); }

    void GetSample(int ds_index, int sample_index, ref double x, ref double y) { IupPlotGetSample(_ih, ds_index, sample_index, &x, &y); }
    void GetSampleStr(int ds_index, int sample_index, const(char)** x, ref double y) { IupPlotGetSampleStr(_ih, ds_index, sample_index, x, &y); }
    int GetSampleSelection(int ds_index, int sample_index) { return IupPlotGetSampleSelection(_ih, ds_index, sample_index); }
    double GetSampleExtra(int ds_index, int sample_index) { return IupPlotGetSampleExtra(_ih, ds_index, sample_index); }
    void SetSample(int ds_index, int sample_index, double x, double y) { IupPlotSetSample(_ih, ds_index, sample_index, x, y); }
    void SetSampleStr(int ds_index, int sample_index, const(char)* x, double y) { IupPlotSetSampleStr(_ih, ds_index, sample_index, x, y); }
    void SetSampleSelection(int ds_index, int sample_index, int selected) { IupPlotSetSampleSelection(_ih, ds_index, sample_index, selected); }
    void SetSampleExtra(int ds_index, int sample_index, double extra) { IupPlotSetSampleExtra(_ih, ds_index, sample_index, extra); }

    void Transform(double x, double y, ref double cnv_x, ref double cnv_y) { IupPlotTransform(_ih, x, y, &cnv_x, &cnv_y); }
    void TransformTo(double cnv_x, double cnv_y, ref double x, ref double y) { IupPlotTransformTo(_ih, cnv_x, cnv_y, &x, &y); }

    int FindSample(double cnv_x, double cnv_y, ref int ds_index, ref int sample_index) { return IupPlotFindSample(_ih, cnv_x, cnv_y, &ds_index, &sample_index); }

    version(CD) void PaintTo(cd.cd_plusD.Canvas cd_canvas) { IupPlotPaintTo(_ih, cd_canvas.GetHandle()); }
  } // class Plot
} // version(IUP_PLOT)

version(IUP_MGLPLOT) {
  import iup.iup_mglplot;

  class MglPlot : Control
  {
    nothrow:
    this() { super(IupMglPlot); }

    static void Open() { IupMglPlotOpen; }

    void Begin(int dim) { IupMglPlotBegin(_ih, dim); }
    void Add1D(const(char)* name, double y) { IupMglPlotAdd1D(_ih, name, y); }
    void Add2D(double x, double y) { IupMglPlotAdd2D(_ih, x, y); }
    void Add3D(double x, double y, double z) { IupMglPlotAdd3D(_ih, x, y, z); }
    int End() { return IupMglPlotEnd(_ih); }

    int NewDataSet(int dim) { return IupMglPlotNewDataSet(_ih, dim); }

    void Insert1D(int ds_index, int sample_index, const(char)** names, const double* y, int count) { IupMglPlotInsert1D(_ih, ds_index, sample_index, names, y, count); }
    void Insert2D(int ds_index, int sample_index, const double* x, const double* y, int count) { IupMglPlotInsert2D(_ih, ds_index, sample_index, x, y, count); }
    void Insert3D(int ds_index, int sample_index, const double* x, const double* y, const double* z, int count) { IupMglPlotInsert3D(_ih, ds_index, sample_index, x, y, z, count); }

    void Set1D(int ds_index, const(char)** names, const double* y, int count) { IupMglPlotSet1D(_ih, ds_index, names, y, count); }
    void Set2D(int ds_index, const double* x, const double* y, int count) { IupMglPlotSet2D(_ih, ds_index, x, y, count); }
    void Set3D(int ds_index, const double* x, const double* y, const double* z, int count) { IupMglPlotSet3D(_ih, ds_index, x, y, z, count); }
    void SetFormula(int ds_index, const(char)* formulaX, const(char)* formulaY, const(char)* formulaZ, int count) { IupMglPlotSetFormula(_ih, ds_index, formulaX, formulaY, formulaZ, count); }

    void SetData(int ds_index, const double* data, int count_x, int count_y, int count_z) { IupMglPlotSetData(_ih, ds_index, data, count_x, count_y, count_z); }
    void LoadData(int ds_index, const(char)* filename, int count_x, int count_y, int count_z) { IupMglPlotLoadData(_ih, ds_index, filename, count_x, count_y, count_z); }
    void SetFromFormula(int ds_index, const(char)* formula, int count_x, int count_y, int count_z) { IupMglPlotSetFromFormula(_ih, ds_index, formula, count_x, count_y, count_z); }

    void Transform(double x, double y, double z, ref int ix, ref int iy) { IupMglPlotTransform(_ih, x, y, z, &ix, &iy); }
    void TransformTo(int ix, int iy, ref double x, ref double y, ref double z) { IupMglPlotTransformTo(_ih, ix, iy, &x, &y, &z); }

    void DrawMark(double x, double y, double z) { IupMglPlotDrawMark(_ih, x, y, z); }
    void DrawLine(double x1, double y1, double z1, double x2, double y2, double z2) { IupMglPlotDrawLine(_ih, x1, y1, z1, x2, y2, z2); }
    void DrawText(const(char)* text, double x, double y, double z) { IupMglPlotDrawText(_ih, text, x, y, z); }

    void PaintTo(const(char)* format, int w, int h, double dpi, ubyte* data) { IupMglPlotPaintTo(_ih, format, w, h, dpi, cast(void*)data); }
    void PaintTo(const(char)* format, int w, int h, double dpi, const(char)* filename) { IupMglPlotPaintTo(_ih, format, w, h, dpi, cast(void*)filename); }

  }

  class MglLabel : Control
  {
    nothrow:
    this(const(char)* title) { super(IupMglLabel(title)); }
  }
}

version(Windows) { version(IUP_OLE) {
  public import iup.iupole;

  class OleControl : Control
  {
    nothrow:
    this(const(char)* progid) { super(IupOleControl(progid)); }

    static void Open() { IupOleControlOpen; }
 }
} }

version(IUP_WEB) {
  public import iup.iupweb;

  class WebBrowser : Control
  {
    nothrow:
    this() { super(IupWebBrowser); }

    static void Open() { IupWebBrowserOpen; }
  }
}


version(IUP_SCINTILLA) {
  public import iup.iup_scintilla;

  class Scintilla : Control
  {
    nothrow:
    this() { super(IupScintilla); }

    static void Open() { IupScintillaOpen; }
  }
}

version(IUP_TUIO) {
  public import iup.iuptuio;

  class TuioClient : Handle
  {
    nothrow:
    this(int port) { super(IupTuioClient(port)); }

    static void Open() { IupTuioOpen; }
  }
}

class Config : Handle
{
  nothrow:
  this()          { super(IupConfig()); }
//  this(string CN) { this(); if (!CN.empty) { AA[CN] = this; IupSetHandle(CN.toStringz, _ih); } }

  int LoadConfig() { return IupConfigLoad(_ih); }
  int SaveConfig() { return IupConfigSave(_ih); }

  void SetVariableStrId   (const(char)* group, const(char)* key, int id, const(char)* value) { IupConfigSetVariableStrId(_ih, group, key, id, value); }
  void SetVariableIntId   (const(char)* group, const(char)* key, int id, int value)          { IupConfigSetVariableIntId(_ih, group, key, id, value); }
  void SetVariableDoubleId(const(char)* group, const(char)* key, int id, double value) { IupConfigSetVariableDoubleId(_ih, group, key, id, value); }
  void SetVariableStr(     const(char)* group, const(char)* key, const(char)* value)   { IupConfigSetVariableStr(_ih, group, key, value); }
  void SetVariableInt     (const(char)* group, const(char)* key, int value)            { IupConfigSetVariableInt(_ih, group, key, value); }
  void SetVariableDouble  (const(char)* group, const(char)* key, double value)         { IupConfigSetVariableDouble(_ih, group, key, value); }

  char*  GetVariableStr     (const(char)* group, const(char)* key)         { return cast(char*)IupConfigGetVariableStr(_ih, group, key); }
  int    GetVariableInt     (const(char)* group, const(char)* key)         { return IupConfigGetVariableInt(_ih, group, key); }
  double GetVariableDouble  (const(char)* group, const(char)* key)         { return IupConfigGetVariableDouble(_ih, group, key); }
  char*  GetVariableStrId   (const(char)* group, const(char)* key, int id) { return cast(char*)IupConfigGetVariableStrId(_ih, group, key, id); }
  int    GetVariableIntId   (const(char)* group, const(char)* key, int id) { return IupConfigGetVariableIntId(_ih, group, key, id); }
  double GetVariableDoubleId(const(char)* group, const(char)* key, int id) { return IupConfigGetVariableDoubleId(_ih, group, key, id); }

  char*  GetVariableStrDef     (const(char)* group, const(char)* key, const(char)* def) { return cast(char*)IupConfigGetVariableStrDef(_ih, group, key, def); }
  int    GetVariableIntDef     (const(char)* group, const(char)* key, int def) { return IupConfigGetVariableIntDef(_ih, group, key, def); }
  double GetVariableDoubleDef  (const(char)* group, const(char)* key, double def) { return IupConfigGetVariableDoubleDef(_ih, group, key, def); }
  char*  GetVariableStrIdDef   (const(char)* group, const(char)* key, int id, const(char)* def) { return cast(char*)IupConfigGetVariableStrIdDef(_ih, group, key, id, def); }
  int    GetVariableIntIdDef   (const(char)* group, const(char)* key, int id, int def) { return IupConfigGetVariableIntIdDef(_ih, group, key, id, def); }
  double GetVariableDoubleIdDef(const(char)* group, const(char)* key, int id, double def) { return IupConfigGetVariableDoubleIdDef(_ih, group, key, id, def); }

  void Copy(Config config2, const(char)* exclude_prefix) { IupConfigCopy(_ih, config2.GetHandle(), exclude_prefix); }

  void SetListVariable(const(char)* group, const(char)* key, const(char)* value, int add) { IupConfigSetListVariable(_ih, group, key, value, add); }

  void RecentInit(Menu menu, Icallback recent_cb, int max_recent) { IupConfigRecentInit(_ih, menu.GetHandle(), recent_cb, max_recent); }
  void RecentUpdate(const(char)* filename) { IupConfigRecentUpdate(_ih, filename); }

  void DialogShow(Dialog dialog, const(char)* name) { IupConfigDialogShow(_ih, dialog.GetHandle(), name); }
  void DialogClosed(Dialog dialog, const(char)* name) { IupConfigDialogClosed(_ih, dialog.GetHandle(), name); }
}

//} // namespace iup


version(CD) //#ifdef __CD_PLUS_H
{ // was in C++ namespace cd
  import cd.cd_plusD;

  class CanvasIup : cd.cd_plusD.Canvas // public Canvas
  {
    nothrow:
    this(iup.iup_plusD.Canvas iup_canvas) { // CanvasIup(Iup::Canvas& iup_canvas) : Canvas() { ... }
      super();
      canvas = cdCreateCanvas(CD_IUP, iup_canvas.GetHandle());
    }
  }

  class CanvasIupDoubleBuffer : cd.cd_plusD.Canvas // public Canvas
  {
    nothrow:
    this(iup.iup_plusD.Canvas iup_canvas) { // CanvasIupDoubleBuffer(Iup::Canvas& iup_canvas) : Canvas() { ... }
      super();
      canvas = cdCreateCanvas(CD_IUPDBUFFER, iup_canvas.GetHandle());
    }
  }

  class CanvasIupDoubleBufferRGB : cd.cd_plusD.Canvas // public Canvas
  {
    nothrow:
    this(iup.iup_plusD.Canvas iup_canvas) { // CanvasIupDoubleBufferRGB(Iup::Canvas& iup_canvas) : Canvas() { ... }
      super();
      canvas = cdCreateCanvas(CD_IUPDBUFFERRGB, iup_canvas.GetHandle());
    }
  }
} // version(CD)

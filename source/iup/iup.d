/** \file
 * \brief User API
 * IUP - A Portable User Interface Toolkit
 * Tecgraf: Computer Graphics Technology Group, PUC-Rio, Brazil
 * http://www.tecgraf.puc-rio.br/iup  mailto:iup@tecgraf.puc-rio.br
 *
 * See Copyright Notice at the end of this file
 *
 * Macros:
 * ROOT = https://www.tecgraf.puc-rio.br/iup/en
 */
// dmd -o- -D iup/iup.d  https://www.tecgraf.puc-rio.br/iup/en/func/?C=S;O=D

module iup.iup;

public import iup.iupkey;
public import iup.iupdef;

version(DigitalMars) version(Windows) { pragma(lib, "iup.lib"); }
//version(DigitalMars) version(Windows) { pragma(lib, "iupimglib"); } // required only if function IupImageLibOpen() is called

extern(C) {

enum IUP_NAME = "IUP - Portable User Interface";
enum IUP_DESCRIPTION	= "Multi-platform Toolkit for Building Graphical User Interfaces";
enum IUP_COPYRIGHT = "Copyright (C) 1994-2023 Tecgraf/PUC-Rio";
enum IUP_VERSION = "3.31";         /* bug fixes are reported only by IupVersion functions */
enum IUP_VERSION_NUMBER = 331000;
enum IUP_VERSION_DATE = "2023/10/13";  /* does not include bug fix releases */

//struct Ihandle_;
//alias Ihandle = Ihandle_;
struct Ihandle;

alias Icallback = int function(Ihandle*) nothrow;
alias Iparamcb  = int function(Ihandle* dialog, int param_index, void* user_data) nothrow;

@nogc nothrow {

/************************************************************************/
/*                        Main API                                      */
/************************************************************************/

int       IupOpen          (int* argc, char*** argv); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/sys_guide.html <br> https://www.tecgraf.puc-rio.br/iup/en/func/iupopen.html
void      IupClose         ();                        /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/sys_guide.html <br> https://www.tecgraf.puc-rio.br/iup/en/func/iupclose.html
int       IupIsOpened      ();

void      IupImageLibOpen  ();                        /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/iupimglib.html

int       IupMainLoop      (); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupmainloop.html
int       IupLoopStep      (); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iuploopstep.html
int       IupLoopStepWait  (); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iuploopstep.html
int       IupMainLoopLevel (); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupmainlooplevel.html
void      IupFlush         (); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupflush.html
void      IupExitLoop      (); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupexitloop.html
void      IupPostMessage   (Ihandle* ih, const(char)* s, int i, double d, void* p);

int       IupRecordInput(const(char)* filename, int mode); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iuprecordinput.html
int       IupPlayInput(const(char)* filename);             /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupplayinput.html

void      IupUpdate        (Ihandle* ih); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupupdate.html
void      IupUpdateChildren(Ihandle* ih); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupupdate.html
void      IupRedraw        (Ihandle* ih, int children); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupredraw.html
void      IupRefresh       (Ihandle* ih);  /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iuprefresh.html
void      IupRefreshChildren(Ihandle* ih); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iuprefreshchildren.html

int       IupExecute       (const(char)* filename, const(char)* parameters); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupexecute.html
int       IupExecuteWait   (const(char)* filename, const(char)* parameters); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupexecutewait.html
int       IupHelp          (const(char)* url); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iuphelp.html
void      IupLog(const(char)* type, const(char)* format, ...); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iuplog.html

char*     IupLoad          (const(char)* filename); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupload.html
char*     IupLoadBuffer    (const(char)* buffer);   /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupload.html

char*     IupVersion       (); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupversion.html
char*     IupVersionDate   (); //  See_Also: undocumented
int       IupVersionNumber (); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupversion.html
void      IupVersionShow   ();

void      IupSetLanguage   (const(char)* lng); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetlanguage.html
char*     IupGetLanguage   (); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetlanguage.html
void      IupSetLanguageString(const(char)* name, const(char)* str);   /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetlanguagestring.html
void      IupStoreLanguageString(const(char)* name, const(char)* str); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetlanguagestring.html
char*     IupGetLanguageString(const(char)* name); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetlanguagestring.html
void      IupSetLanguagePack(Ihandle* ih); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetlanguagepack.html

void      IupDestroy       (Ihandle* ih); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupdestroy.html
void      IupDetach        (Ihandle* child); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupdetach.html
Ihandle*  IupAppend        (Ihandle* ih, Ihandle* child); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupappend.html
Ihandle*  IupInsert        (Ihandle* ih, Ihandle* ref_child, Ihandle* child); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupinsert.html
Ihandle*  IupGetChild      (Ihandle* ih, int pos); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetchild.html
int       IupGetChildPos   (Ihandle* ih, Ihandle* child); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetchildpos.html
int       IupGetChildCount (Ihandle* ih); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetchildcount.html
Ihandle*  IupGetNextChild  (Ihandle* ih, Ihandle* child); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetnextchild.html
Ihandle*  IupGetBrother    (Ihandle* ih); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetbrother.html
Ihandle*  IupGetParent     (Ihandle* ih); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetparent.html
Ihandle*  IupGetDialog     (Ihandle* ih); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetdialog.html
Ihandle*  IupGetDialogChild(Ihandle* ih, const(char)* name); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetdialogchild.html
int       IupReparent      (Ihandle* ih, Ihandle* new_parent, Ihandle* ref_child); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupreparent.html

int       IupPopup         (Ihandle* ih, int x, int y); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iuppopup.html
int       IupShow          (Ihandle* ih);               /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupshow.html
int       IupShowXY        (Ihandle* ih, int x, int y); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupshowxy.html
int       IupHide          (Ihandle* ih); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iuphide.html
int       IupMap           (Ihandle* ih); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupmap.html
void      IupUnmap         (Ihandle* ih); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupunmap.html

void      IupResetAttribute(Ihandle* ih, const(char)* name); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupresetattribute.html
int       IupGetAllAttributes(Ihandle* ih, char** names, int n); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetallattributes.html
void      IupCopyAttributes(Ihandle* src_ih, Ihandle* dst_ih);   /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupcopyattributes.html
Ihandle*  IupSetAtt(const(char)* handle_name, Ihandle* ih, const(char)* name, ...); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetatt.html
Ihandle*  IupSetAttributes (Ihandle* ih, const(char)* str); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattributes.html
char*     IupGetAttributes (Ihandle* ih); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetattributes.html

void      IupSetAttribute   (Ihandle* ih, const(char)* name, const(char)* value); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/attrib_guide.html <br> https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html
void      IupSetStrAttribute(Ihandle* ih, const(char)* name, const(char)* value); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html
void      IupSetStrf        (Ihandle* ih, const(char)* name, const(char)* format, ...); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html
void      IupSetInt         (Ihandle* ih, const(char)* name, int value); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html
void      IupSetFloat       (Ihandle* ih, const(char)* name, float value); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html
void      IupSetDouble      (Ihandle* ih, const(char)* name, double value); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html
void      IupSetRGB         (Ihandle* ih, const(char)* name, ubyte r, ubyte g, ubyte b); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html
void      IupSetRGBA        (Ihandle* ih, const(char)* name, ubyte r, ubyte g, ubyte b, ubyte a);

char*     IupGetAttribute(Ihandle* ih, const(char)* name); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/attrib_guide.html <br> https://www.tecgraf.puc-rio.br/iup/en/func/iupgetattribute.html
int       IupGetInt      (Ihandle* ih, const(char)* name); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetattribute.html
int       IupGetInt2     (Ihandle* ih, const(char)* name); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetattribute.html
int       IupGetIntInt   (Ihandle* ih, const(char)* name, int* i1, int* i2); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetattribute.html
float     IupGetFloat    (Ihandle* ih, const(char)* name); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetattribute.html
double    IupGetDouble   (Ihandle* ih, const(char)* name); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetattribute.html
void      IupGetRGB      (Ihandle* ih, const(char)* name, ubyte* r, ubyte* g, ubyte* b); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetattribute.html
void      IupGetRGBA     (Ihandle* ih, const(char)* name, ubyte* r, ubyte* g, ubyte* b, ubyte* a);

void  IupSetAttributeId(Ihandle* ih, const(char)* name, int id, const(char)* value); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html
void  IupSetStrAttributeId(Ihandle* ih, const(char)* name, int id, const(char)* value); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html
void  IupSetStrfId(Ihandle* ih, const(char)* name, int id, const(char)* format, ...); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html
void  IupSetIntId(Ihandle* ih, const(char)* name, int id, int value); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html
void  IupSetFloatId(Ihandle* ih, const(char)* name, int id, float value); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html
void  IupSetDoubleId(Ihandle* ih, const(char)* name, int id, double value); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html
void  IupSetRGBId(Ihandle* ih, const(char)* name, int id, ubyte r, ubyte g, ubyte b); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html

char*  IupGetAttributeId(Ihandle* ih, const(char)* name, int id); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetattribute.html
int    IupGetIntId(Ihandle* ih, const(char)* name, int id); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetattribute.html
float  IupGetFloatId(Ihandle* ih, const(char)* name, int id); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetattribute.html
double IupGetDoubleId(Ihandle* ih, const(char)* name, int id); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetattribute.html
void   IupGetRGBId(Ihandle* ih, const(char)* name, int id, ubyte* r, ubyte* g, ubyte* b); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetattribute.html

void  IupSetAttributeId2(Ihandle* ih, const(char)* name, int lin, int col, const(char)* value); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html
void  IupSetStrAttributeId2(Ihandle* ih, const(char)* name, int lin, int col, const(char)* value); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html
void  IupSetStrfId2(Ihandle* ih, const(char)* name, int lin, int col, const(char)* format, ...); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html
void  IupSetIntId2(Ihandle* ih, const(char)* name, int lin, int col, int value); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html
void  IupSetFloatId2(Ihandle* ih, const(char)* name, int lin, int col, float value); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html
void  IupSetDoubleId2(Ihandle* ih, const(char)* name, int lin, int col, double value); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html
void  IupSetRGBId2(Ihandle* ih, const(char)* name, int lin, int col, ubyte r, ubyte g, ubyte b); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html

char*  IupGetAttributeId2(Ihandle* ih, const(char)* name, int lin, int col); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetattribute.html
int    IupGetIntId2(Ihandle* ih, const(char)* name, int lin, int col); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetattribute.html
float  IupGetFloatId2(Ihandle* ih, const(char)* name, int lin, int col); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetattribute.html
double IupGetDoubleId2(Ihandle* ih, const(char)* name, int lin, int col); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetattribute.html
void   IupGetRGBId2(Ihandle* ih, const(char)* name, int lin, int col, ubyte* r, ubyte* g, ubyte* b); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetattribute.html

void      IupSetGlobal  (const(char)* name, const(char)* value); /// https://www.tecgraf.puc-rio.br/iup/en/attrib/iup_globals.html <br> See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetglobal.html
void      IupSetStrGlobal(const(char)* name, const(char)* value); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetglobal.html
char*     IupGetGlobal  (const(char)* name); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/attrib/iup_globals.html <br> https://www.tecgraf.puc-rio.br/iup/en/func/iupgetglobal.html

Ihandle*  IupSetFocus     (Ihandle* ih); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetfocus.html
Ihandle*  IupGetFocus     ();            /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetfocus.html
Ihandle*  IupPreviousField(Ihandle* ih); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iuppreviousfield.html
Ihandle*  IupNextField    (Ihandle* ih); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupnextfield.html

Icallback IupGetCallback (Ihandle* ih, const(char)* name); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetcallback.html
Icallback IupSetCallback (Ihandle* ih, const(char)* name, Icallback func); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetcallback.html
Ihandle*  IupSetCallbacks(Ihandle* ih, const(char)* name, Icallback func, ...); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetcallbacks.html

Icallback IupGetFunction(const(char)* name); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetfunction.html
Icallback IupSetFunction(const(char)* name, Icallback func); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetfunction.html

Ihandle*  IupGetHandle    (const(char)* name);              /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgethandle.html
Ihandle*  IupSetHandle    (const(char)* name, Ihandle* ih); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsethandle.html
int       IupGetAllNames  (char** names, int n); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetallnames.html
int       IupGetAllDialogs(char** names, int n); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetalldialogs.html
char*     IupGetName      (Ihandle* ih); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetname.html

void      IupSetAttributeHandle(Ihandle* ih, const(char)* name, Ihandle* ih_named); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattributehandle.html
Ihandle*  IupGetAttributeHandle(Ihandle* ih, const(char)* name); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetattributehandle.html
void      IupSetAttributeHandleId(Ihandle* ih, const(char)* name, int id, Ihandle* ih_named); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattributehandle.html
Ihandle*  IupGetAttributeHandleId(Ihandle* ih, const(char)* name, int id); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetattributehandle.html
void      IupSetAttributeHandleId2(Ihandle* ih, const(char)* name, int lin, int col, Ihandle* ih_named); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetattributehandle.html
Ihandle*  IupGetAttributeHandleId2(Ihandle* ih, const(char)* name, int lin, int col); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetattributehandle.html

char*     IupGetClassName(Ihandle* ih); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetclassname.html
char*     IupGetClassType(Ihandle* ih); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetclasstype.html
int       IupGetAllClasses(char** names, int n);  /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetallclasses.html
int       IupGetClassAttributes(const(char)* classname, char** names, int n); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetclassattributes.html
int       IupGetClassCallbacks(const(char)* classname, char** names, int n);  /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupgetclasscallbacks.html
void      IupSaveClassAttributes(Ihandle* ih); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsaveclassattributes.html
void      IupCopyClassAttributes(Ihandle* src_ih, Ihandle* dst_ih); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupcopyclassattributes.html
void      IupSetClassDefaultAttribute(const(char)* classname, const(char)* name, const(char)* value); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsetclassdefaultattribute.html
int       IupClassMatch(Ihandle* ih, const(char)* classname); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupclassmatch.html

Ihandle*  IupCreate (const(char)* classname); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupcreate.html
Ihandle*  IupCreatev(const(char)* classname, void** params);    /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupcreate.html
Ihandle*  IupCreatep(const(char)* classname, void* first, ...); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupcreate.html

/************************************************************************/
/*                        Elements                                      */
/************************************************************************/

Ihandle*  IupFill       ();                    /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupfill.html
Ihandle*  IupSpace      ();

Ihandle*  IupRadio      (Ihandle* child);      /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupradio.html
Ihandle*  IupVbox       (Ihandle* child, ...); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupvbox.html
Ihandle*  IupVboxv      (Ihandle** children);  /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupvbox.html
Ihandle*  IupZbox       (Ihandle* child, ...); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupzbox.html
Ihandle*  IupZboxv      (Ihandle** children);  /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupzbox.html
Ihandle*  IupHbox       (Ihandle* child, ...); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iuphbox.html
Ihandle*  IupHboxv      (Ihandle** children);  /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iuphbox.html

Ihandle*  IupNormalizer (Ihandle* ih_first, ...); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupnormalizer.html
Ihandle*  IupNormalizerv(Ihandle** ih_list);      /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupnormalizer.html

Ihandle*  IupCbox       (Ihandle* child, ...); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupcbox.html
Ihandle*  IupCboxv      (Ihandle** children);  /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupcbox.html
Ihandle*  IupSbox       (Ihandle* child);      /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupsbox.html
Ihandle*  IupSplit      (Ihandle* child1, Ihandle* child2); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupsplit.html
Ihandle*  IupScrollBox  (Ihandle* child);      /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupscrollbox.html
Ihandle*  IupFlatScrollBox(Ihandle* child);    /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupflatscrollbox.html
Ihandle*  IupGridBox    (Ihandle* child, ...); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupgridbox.html
Ihandle*  IupGridBoxv   (Ihandle** children);  /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupgridbox.html
Ihandle*  IupMultiBox   (Ihandle* child, ...); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupmultibox.html
Ihandle*  IupMultiBoxv  (Ihandle** children);  /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupmultibox.html
Ihandle*  IupExpander   (Ihandle* child);      /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupexpander.html
Ihandle*  IupDetachBox  (Ihandle* child);      /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupdetachbox.html
Ihandle*  IupBackgroundBox(Ihandle* child);    /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupbackgroundbox.html

Ihandle*  IupFrame      (Ihandle* child); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupframe.html
Ihandle*  IupFlatFrame  (Ihandle* child); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupflatframe.html

Ihandle*  IupImage      (int width, int height, const(ubyte)* pixels); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupimage.html
Ihandle*  IupImageRGB   (int width, int height, const(ubyte)* pixels); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupimage.html
Ihandle*  IupImageRGBA  (int width, int height, const(ubyte)* pixels); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupimage.html

Ihandle*  IupItem       (const(char)* title, const(char)* action); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupitem.html
Ihandle*  IupSubmenu    (const(char)* title, Ihandle* child); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupsubmenu.html
Ihandle*  IupSeparator  ();                    /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupseparator.html
Ihandle*  IupMenu       (Ihandle* child, ...); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupmenu.html
Ihandle*  IupMenuv      (Ihandle** children);  /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupmenu.html

Ihandle*  IupButton     (const(char)* title, const(char)* action); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupbutton.html
Ihandle*  IupFlatButton (const(char)* title);  /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupflatbutton.html
Ihandle*  IupFlatToggle (const(char)* title);  /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupflattoggle.html
Ihandle*  IupDropButton (Ihandle* dropchild);  /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupdropbutton.html
Ihandle*  IupFlatLabel  (const(char)* title);  /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupflatlabel.html
Ihandle*  IupFlatSeparator();                  /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupflatseparator.html
Ihandle*  IupCanvas     (const(char)* action); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupcanvas.html
Ihandle*  IupDialog     (Ihandle* child);      /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/dlg/iupdialog.html
Ihandle*  IupUser       ();                    /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupuser.html
Ihandle*  IupThread     ();
Ihandle*  IupLabel      (const(char)* title);  /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iuplabel.html
Ihandle*  IupList       (const(char)* action); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iuplist.html
Ihandle*  IupFlatList   ();                    /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupflatlist.html
Ihandle*  IupText       (const(char)* action); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iuptext.html
Ihandle*  IupMultiLine  (const(char)* action); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupmultiline.html
Ihandle*  IupToggle     (const(char)* title, const(char)* action); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iuptoggle.html
Ihandle*  IupTimer      (); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iuptimer.html
Ihandle*  IupClipboard  (); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupclipboard.html
Ihandle*  IupProgressBar(); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/.../iupprogressbar.html
Ihandle*  IupVal        (const(char)* type);   /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupval.html
Ihandle*  IupFlatVal    (const(char)* type);
Ihandle*  IupFlatTree   ();
Ihandle*  IupTabs       (Ihandle* child, ...); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iuptabs.html
Ihandle*  IupTabsv      (Ihandle** children);  /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iuptabs.html
Ihandle*  IupFlatTabs   (Ihandle* first, ...); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupflattabs.html
Ihandle*  IupFlatTabsv  (Ihandle** children);  /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupflattabs.html
Ihandle*  IupTree       (); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iuptree.html
Ihandle*  IupLink       (const(char)* url, const(char)* title); /// See_Also: webserver2.tecgraf.puc-rio.br/iup/en/elem/iuplink.html
Ihandle*  IupAnimatedLabel(Ihandle* animation); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/.../iupanimatedlabel.html
Ihandle*  IupDatePick   (); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupdatepick.html
Ihandle*  IupCalendar   (); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupcalendar.html
Ihandle*  IupColorbar   (); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupcolorbar.html
Ihandle*  IupGauge      (); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupgauge.html
Ihandle*  IupDial       (const(char)* type); /// See_Also: http://webserver2.tecgraf.puc-rio.br/iup/en/elem/iupdial.html
Ihandle*  IupColorBrowser(); /// See_Also: http://webserver2.tecgraf.puc-rio.br/iup/en/elem/iupcolorbrowser.html

/* Old controls, use SPIN attribute of IupText */
Ihandle*  IupSpin       ();               /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupspin.html
Ihandle*  IupSpinbox    (Ihandle* child); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupspin.html


/************************************************************************/
/*                      Utilities                                       */
/************************************************************************/

/* String compare utility */
int  IupStringCompare(const(char)* str1, const(char)* str2, int casesensitive, int lexicographic); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupstringcompare.html

/* IupImage utilities */
int  IupSaveImageAsText(Ihandle* ih, const(char)* file_name, const(char)* format, const(char)* name); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupsaveimageastext.html
Ihandle* IupImageGetHandle(const(char)* name);

/* IupText and IupScintilla utilities */
void IupTextConvertLinColToPos(Ihandle* ih, int lin, int col, int* pos);  /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iuptext.html
void IupTextConvertPosToLinCol(Ihandle* ih, int pos, int* lin, int* col); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iuptext.html

/* IupText, IupList, IupTree, IupMatrix and IupScintilla utility */
int  IupConvertXYToPos(Ihandle* ih, int x, int y); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupconvertxytopos.html

/* OLD names, kept for backward compatibility, will never be removed. */
void IupStoreGlobal(const(char)* name, const(char)* value);
void IupStoreAttribute(Ihandle* ih, const(char)* name, const(char)* value);
void IupSetfAttribute(Ihandle* ih, const(char)* name, const(char)* format, ...);
void IupStoreAttributeId(Ihandle* ih, const(char)* name, int id, const(char)* value);
void IupSetfAttributeId(Ihandle* ih, const(char)* name, int id, const(char)* f, ...);
void IupStoreAttributeId2(Ihandle* ih, const(char)* name, int lin, int col, const(char)* value);
void IupSetfAttributeId2(Ihandle* ih, const(char)* name, int lin, int col, const(char)* format, ...);

/* IupTree and IupFlatTree utilities (work for both) */
int   IupTreeSetUserId(Ihandle* ih, int id, void* userid); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iuptree.html
void* IupTreeGetUserId(Ihandle* ih, int id);               /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iuptree.html
int   IupTreeGetId(Ihandle* ih, void* userid);             /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iuptree.html
deprecated("use IupSetAttributeHandleId")
void  IupTreeSetAttributeHandle(Ihandle* ih, const(char)* name, int id, Ihandle* ih_named);


/************************************************************************/
/*                      Pre-definided dialogs                           */
/************************************************************************/

Ihandle* IupFileDlg();     /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/dlg/iupfiledlg.html
Ihandle* IupMessageDlg();  /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/dlg/iupmessagedlg.html
Ihandle* IupColorDlg();    /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/dlg/iupcolordlg.html
Ihandle* IupFontDlg();     /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/dlg/iupfontdlg.html
Ihandle* IupProgressDlg(); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/dlg/iupprogressdlg.html

int  IupGetFile(char* arq); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/dlg/iupgetfile.html
void IupMessage(const(char)* title, const(char)* msg);          /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/dlg/iupmessage.html
void IupMessagef(const(char)* title, const(char)* format, ...); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/dlg/iupmessage.html
void IupMessageError(Ihandle* parent, const(char)* message); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/dlg/iupmessageerror.html
int  IupMessageAlarm(Ihandle* parent, const(char)* title, const(char)* message, const(char)* buttons); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/dlg/iupmessagealarm.html
int  IupAlarm(const(char)* title, const(char)* msg, const(char)* b1, const(char)* b2, const(char)* b3); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/dlg/iupalarm.html
int  IupScanf(const(char)* format, ...); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/dlg/iupscanf.html
int  IupListDialog(int type, const(char)* title, int size, const(char)** list,
                   int op, int max_col, int max_lin, int* marks); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/dlg/iuplistdialog.html
int  IupGetText(const(char)* title, char* text, int maxsize); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/dlg/iupgettext.html
int  IupGetColor(int x, int y, ubyte* r, ubyte* g, ubyte* b); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/dlg/iupgetcolor.html

//alias Iparamcb = int function(Ihandle* dialog, int param_index, void* user_data) nothrow;
int  IupGetParam(const(char)* title, Iparamcb action, void* user_data, const(char)* format, ...); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/dlg/iupgetparam.html
int  IupGetParamv(const(char)* title, Iparamcb action, void* user_data, const(char)* format, int param_count, int param_extra, void** param_data); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/dlg/iupgetparam.html
Ihandle* IupParam(const(char)* format);       /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupparam.html
Ihandle* IupParamBox(Ihandle* param, ...);    /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupparambox.html
Ihandle* IupParamBoxv(Ihandle** param_array); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupparambox.html

Ihandle* IupLayoutDialog(Ihandle* dialog);          /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/.../iuplayoutdialog.html
Ihandle* IupElementPropertiesDialog(Ihandle* elem); /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/dlg/iupelementpropdialog.html
Ihandle* IupGlobalsDialog();

} // @nogc nothrow
} // extern(C)

/************************************************************************/
/*                   Common Flags and Return Values                     */
/************************************************************************/
enum {
	IUP_ERROR      =   1,
	IUP_NOERROR    =   0,
	IUP_OPENED     =  -1, /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iupopen.html
	IUP_INVALID    =  -1,
	IUP_INVALID_ID = -10,
}

/************************************************************************/
/*                   Callback Return Values                             */
/************************************************************************/
enum {
	IUP_IGNORE    = -1, /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/call_guide.html
	IUP_DEFAULT   = -2, /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/call_guide.html
	IUP_CLOSE     = -3, /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/call_guide.html
	IUP_CONTINUE  = -4, /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/call_guide.html
}

/************************************************************************/
/*           IupPopup and IupShowXY Parameter Values                    */
/************************************************************************/
enum {                  /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iuppopup.html
	IUP_CENTER        = 0xFFFF,  /* 65535 */
	IUP_LEFT          = 0xFFFE,  /* 65534 */
	IUP_RIGHT         = 0xFFFD,  /* 65533 */
	IUP_MOUSEPOS      = 0xFFFC,  /* 65532 */
	IUP_CURRENT       = 0xFFFB,  /* 65531 */
	IUP_CENTERPARENT  = 0xFFFA,  /* 65530 */
	IUP_TOP       = IUP_LEFT,
	IUP_BOTTOM    = IUP_RIGHT,
}

/************************************************************************/
/*               SHOW_CB Callback Values                                */
/************************************************************************/
enum {                  /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/call/iup_show_cb.html
    IUP_SHOW,
    IUP_RESTORE,
    IUP_MINIMIZE,
    IUP_MAXIMIZE,
    IUP_HIDE
}

/************************************************************************/
/*               SCROLL_CB Callback Values                              */
/************************************************************************/
enum {IUP_SBUP,   IUP_SBDN,    IUP_SBPGUP,   IUP_SBPGDN,    IUP_SBPOSV, IUP_SBDRAGV,
      IUP_SBLEFT, IUP_SBRIGHT, IUP_SBPGLEFT, IUP_SBPGRIGHT, IUP_SBPOSH, IUP_SBDRAGH} /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/call/iup_scroll_cb.html

/************************************************************************/
/*               Mouse Button Values and Macros                         */
/************************************************************************/
enum : char {
	IUP_BUTTON1   = '1', /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/call/iup_button_cb.html
	IUP_BUTTON2   = '2', /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/call/iup_button_cb.html
	IUP_BUTTON3   = '3', /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/call/iup_button_cb.html
	IUP_BUTTON4   = '4', /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/call/iup_button_cb.html
	IUP_BUTTON5   = '5', /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/call/iup_button_cb.html
}

//#define iup_isshift(_s)    (_s[0]=='S')
bool iup_isshift()(string _s) {
	if (_s.length > 0)
		return _s[0] == 'S';
	return false;
}

//#define iup_iscontrol(_s)  (_s[1]=='C')
bool iup_iscontrol()(string _s){
	if (_s.length > 1)
		return _s[1]=='C';
	return false;
}

//#define iup_isbutton1(_s)  (_s[2]=='1')
bool iup_isbutton1(T)(T _s) nothrow
  if (is (T : string) || is (T : char*))
{
	static if (is (T : string)) {
		if (_s.length > 2)
			return _s[2]=='1';
		return false;
	}
	else {
		return _s[2]=='1';
	}
}

//bool iup_isbutton1(char* _s) nothrow {
//	return _s[2]=='1';
//}

//#define iup_isbutton2(_s)  (_s[3]=='2')
bool iup_isbutton2(T)(T _s) nothrow
  if (is (T : string) || is (T : char*))
{
	static if (is (T : string)) {
		if (_s.length > 3)
			return _s[3]=='2';
		return false;
	}
	else {
		return _s[3]=='2';
	}
}

//bool iup_isbutton2(char* _s) nothrow {
//	return _s[3]=='2';
//}

//#define iup_isbutton3(_s)  (_s[4]=='3')
bool iup_isbutton3(T)(T _s) nothrow
  if (is (T : string) || is (T : char*))
{
	static if (is (T : string)) {
		if (_s.length > 4)
			return _s[4]=='3';
		return false;
	}
	else {
		return _s[4]=='3';
	}
}

//bool iup_isbutton3(char* _s) nothrow {
//	return _s[4]=='3';
//}

//#define iup_isdouble(_s)   (_s[5]=='D')
bool iup_isdouble()(string _s) {
	if (_s.length > 5)
		return _s[5]=='D';
	return false;
}

//#define iup_isalt(_s)      (_s[6]=='A')
bool iup_isalt()(string _s) {
	if (_s.length > 6)
		return _s[6]=='A';
	return false;
}

//#define iup_issys(_s)      (_s[7]=='Y')
bool iup_issys()(string _s) {
	if (_s.length > 7)
		return _s[7]=='Y';
	return false;
}

//#define iup_isbutton4(_s)  (_s[8]=='4')
bool iup_isbutton4()(string _s) {
	if (_s.length > 8)
		return _s[8]=='4';
	return false;
}

//#define iup_isbutton5(_s)  (_s[9]=='5')
bool iup_isbutton5()(string _s) {
	if (_s.length > 9)
		return _s[9]=='5';
	return false;
}

/* Old definitions for backward compatibility */
alias isshift     = iup_isshift;
alias iscontrol   = iup_iscontrol;
alias isbutton1   = iup_isbutton1;
alias isbutton2   = iup_isbutton2;
alias isbutton3   = iup_isbutton3;
alias isdouble    = iup_isdouble;
alias isalt       = iup_isalt;
alias issys       = iup_issys;
alias isbutton4   = iup_isbutton4;
alias isbutton5   = iup_isbutton5;


/************************************************************************/
/*                      Pre-Defined Masks                               */
/************************************************************************/
enum /* const(char)* */ IUP_MASK_FLOAT       = "[+/-]?(/d+/.?/d*|/./d+)"; /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/attrib/iup_mask.html
enum /* const(char)* */ IUP_MASK_UFLOAT            = "(/d+/.?/d*|/./d+)"; /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/attrib/iup_mask.html
enum /* const(char)* */ IUP_MASK_EFLOAT      = "[+/-]?(/d+/.?/d*|/./d+)([eE][+/-]?/d+)?"; /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/attrib/iup_mask.html
enum /* const(char)* */ IUP_MASK_UEFLOAT     = "(/d+/.?/d*|/./d+)([eE][+/-]?/d+)?"; /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/attrib/iup_mask.html
enum /* const(char)* */ IUP_MASK_FLOATCOMMA  = "[+/-]?(/d+/,?/d*|/,/d+)"; /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/attrib/iup_mask.html
enum /* const(char)* */ IUP_MASK_UFLOATCOMMA =       "(/d+/,?/d*|/,/d+)"; /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/attrib/iup_mask.html
enum /* const(char)* */ IUP_MASK_INT         =  "[+/-]?/d+"; /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/attrib/iup_mask.html
enum /* const(char)* */ IUP_MASK_UINT        =        "/d+"; /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/attrib/iup_mask.html

/* Old definitions for backward compatibility */
alias IUPMASK_FLOAT     = IUP_MASK_FLOAT;
alias IUPMASK_UFLOAT    = IUP_MASK_UFLOAT;
alias IUPMASK_EFLOAT    = IUP_MASK_EFLOAT;
alias IUPMASK_INT       = IUP_MASK_INT;
alias IUPMASK_UINT      = IUP_MASK_UINT;


/************************************************************************/
/*                   IupGetParam Callback situations                    */
/************************************************************************/
enum {
	IUP_GETPARAM_BUTTON1 = -1, /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupparambox.html
	IUP_GETPARAM_INIT    = -2, /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupparambox.html
	IUP_GETPARAM_BUTTON2 = -3, /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupparambox.html
	IUP_GETPARAM_BUTTON3 = -4, /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupparambox.html
	IUP_GETPARAM_CLOSE   = -5, /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupparambox.html
	IUP_GETPARAM_MAP     = -6, /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupparambox.html
	IUP_GETPARAM_OK     = IUP_GETPARAM_BUTTON1, /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupparambox.html
	IUP_GETPARAM_CANCEL = IUP_GETPARAM_BUTTON2, /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupparambox.html
	IUP_GETPARAM_HELP   = IUP_GETPARAM_BUTTON3, /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupparambox.html
}

/************************************************************************/
/*                   Used by IupColorbar                                */
/************************************************************************/
enum IUP_PRIMARY   = -1; /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupcolorbar.html
enum IUP_SECONDARY = -2; /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/elem/iupcolorbar.html

/************************************************************************/
/*                   Record Input Modes                                 */
/************************************************************************/
enum {
    IUP_RECBINARY, /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iuprecordinput.html
    IUP_RECTEXT    /// See_Also: https://www.tecgraf.puc-rio.br/iup/en/func/iuprecordinput.html
}


/******************************************************************************
* Copyright (C) 1994-2019 Tecgraf, PUC-Rio.
*
* Permission is hereby granted, free of charge, to any person obtaining
* a copy of this software and associated documentation files (the
* "Software"), to deal in the Software without restriction, including
* without limitation the rights to use, copy, modify, merge, publish,
* distribute, sublicense, and/or sell copies of the Software, and to
* permit persons to whom the Software is furnished to do so, subject to
* the following conditions:
*
* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
* MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
* IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
* CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
* TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
* SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
******************************************************************************/

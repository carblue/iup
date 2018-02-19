/** \file
 * \brief Configuration file Utilities
 *
 * See Copyright Notice in "iup.h"
 */

module iup.iup_config;

import iup.iup : Ihandle, Icallback;

//version(DigitalMars) version(Windows) { pragma(lib, "iup.lib"); } // import iup.iup required anyway, that comes with this pragma

extern(C) @nogc nothrow :

Ihandle* IupConfig();

int IupConfigLoad(Ihandle* ih); /// See_Also: https://webserver2.tecgraf.puc-rio.br/iup/en/func/iupconfig.html
int IupConfigSave(Ihandle* ih); /// See_Also: https://webserver2.tecgraf.puc-rio.br/iup/en/func/iupconfig.html

/****************************************************************/

void IupConfigSetVariableStr(Ihandle* ih, const(char)* group, const(char)* key, const(char)* value);           /// See_Also:
void IupConfigSetVariableStrId(Ihandle* ih, const(char)* group, const(char)* key, int id, const(char)* value); /// See_Also:
void IupConfigSetVariableInt(Ihandle* ih, const(char)* group, const(char)* key, int value);                    /// See_Also:
void IupConfigSetVariableIntId(Ihandle* ih, const(char)* group, const(char)* key, int id, int value);          /// See_Also:
void IupConfigSetVariableDouble(Ihandle* ih, const(char)* group, const(char)* key, double value);              /// See_Also:
void IupConfigSetVariableDoubleId(Ihandle* ih, const(char)* group, const(char)* key, int id, double value);    /// See_Also:

const(char)* IupConfigGetVariableStr(Ihandle* ih, const(char)* group, const(char)* key);           /// See_Also:
const(char)* IupConfigGetVariableStrId(Ihandle* ih, const(char)* group, const(char)* key, int id); /// See_Also:
int    IupConfigGetVariableInt(Ihandle* ih, const(char)* group, const(char)* key);                 /// See_Also:
int    IupConfigGetVariableIntId(Ihandle* ih, const(char)* group, const(char)* key, int id);       /// See_Also:
double IupConfigGetVariableDouble(Ihandle* ih, const(char)* group, const(char)* key);              /// See_Also:
double IupConfigGetVariableDoubleId(Ihandle* ih, const(char)* group, const(char)* key, int id);    /// See_Also:

const(char)* IupConfigGetVariableStrDef(Ihandle* ih, const(char)* group, const(char)* key, const(char)* def);
const(char)* IupConfigGetVariableStrIdDef(Ihandle* ih, const(char)* group, const(char)* key, int id, const(char)* def);
int    IupConfigGetVariableIntDef(Ihandle* ih, const(char)* group, const(char)* key, int def);
int    IupConfigGetVariableIntIdDef(Ihandle* ih, const(char)* group, const(char)* key, int id, int def);
double IupConfigGetVariableDoubleDef(Ihandle* ih, const(char)* group, const(char)* key, double def);
double IupConfigGetVariableDoubleIdDef(Ihandle* ih, const(char)* group, const(char)* key, int id, double def);

void IupConfigCopy(Ihandle* ih1, Ihandle* ih2, const(char)* exclude_prefix);

/****************************************************************/

void IupConfigSetListVariable(Ihandle* ih, const(char)* group, const(char)* key, const(char)* value, int add);

void IupConfigRecentInit(Ihandle* ih, Ihandle* menu, Icallback recent_cb, int max_recent);
void IupConfigRecentUpdate(Ihandle* ih, const(char)* filename);

void IupConfigDialogShow(Ihandle* ih, Ihandle* dialog, const(char)* name);
void IupConfigDialogClosed(Ihandle* ih, Ihandle* dialog, const(char)* name);

/** \file
* \brief IUP API with explicit variable argument parameters.
*
* See Copyright Notice in "iup.h"
*/

module iup.iup_varg;

import iup.iup : Ihandle, Icallback, Iparamcb;


extern(C) @nogc nothrow :


void      IupLogV(const(char)* type, const(char)* format, ...); /// See_Also: https://webserver2.tecgraf.puc-rio.br/iup/en/func/iuplog.html

Ihandle*  IupSetAttV(const(char)* handle_name, Ihandle* ih, const(char)* name, ...);

void      IupSetStrfV(Ihandle* ih, const(char)* name, const(char)* format, ...);
void      IupSetStrfIdV(Ihandle* ih, const(char)* name, int id, const(char)* format, ...);
void      IupSetStrfId2V(Ihandle* ih, const(char)* name, int lin, int col, const(char)* format, ...);

Ihandle*  IupSetCallbacksV(Ihandle* ih, const(char)* name, Icallback func, ...);

Ihandle*  IupCreateV(const(char)* classname, void* first, ...);
Ihandle*  IupVboxV(Ihandle* child, ...);
Ihandle*  IupZboxV(Ihandle* child, ...);
Ihandle*  IupHboxV(Ihandle* child, ...);
Ihandle*  IupNormalizerV(Ihandle* ih_first, ...);
Ihandle*  IupCboxV(Ihandle* child, ...);
Ihandle*  IupGridBoxV(Ihandle* child, ...);
Ihandle*  IupMenuV(Ihandle* child, ...);
Ihandle*  IupTabsV(Ihandle* child, ...);
Ihandle*  IupFlatTabsV(Ihandle* child, ...);

void      IupMessageV(const(char)* title, const(char)* format, ...);
Ihandle*  IupParamBoxV(Ihandle* param, ...);
int       IupGetParamV(const(char)* title, Iparamcb action, void* user_data, const(char)* format, ...);

Ihandle*  IupGLCanvasBoxV(Ihandle* child, ...);

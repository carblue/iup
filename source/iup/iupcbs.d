/** \file
 * \brief Contains all function pointer typedefs.
 *
 * See Copyright Notice in "iup.h"
 */
 
module iup.iupcbs;

import iup.iup : Ihandle;

struct _cdCanvas;

extern(C) nothrow :

alias IFidle  = int function();  /* idle */
alias IFentry = void function();  /* entry */

alias IFi     = void function(int); /* globalentermodal_cb, globalleavemodal_cb,  */
alias IFii    = void function(int, int); /* globalkeypress_cb */
alias IFiis   = void function(int, int, char*);  /* globalmotion_cb */
alias IFiiiis = void function(int, int, int, int, char*);  /* globalbutton_cb */
alias IFfiis  = void function(float,int,int,char*);  /* globalwheel_cb */
alias IFvs    = void function(void*, char*);  /* handleadd_cb, handleremove_cb, imagecreate_cb, imagedestroy_cb */

alias IFn        = int function(Ihandle*);  /* default definition, same as Icallback */
alias IFni       = int function(Ihandle*, int);   /* k_any, show_cb, toggle_action, spin_cb, branchopen_cb, branchclose_cb, executeleaf_cb, showrename_cb, rightclick_cb, extended_cb, height_cb, width_cb */
alias IFnii      = int function(Ihandle*, int, int);  /* resize_cb, caret_cb, matrix_mousemove_cb, enteritem_cb, leaveitem_cb, scrolltop_cb, dropcheck_cb, selection_cb, select_cb, switch_cb, scrolling_cb, vspan_cb, hspan_cb */
alias IFniii     = int function(Ihandle*, int, int, int); /* trayclick_cb, edition_cb */
alias IFniiii    = int function(Ihandle*, int, int, int, int); /* dragdrop_cb */
alias IFniiiiiiC = int function(Ihandle*, int, int, int, int, int, int, _cdCanvas*);  /* draw_cb */
alias IFniiiiii  = int function(Ihandle*, int, int, int, int, int, int);  /* OLD draw_cb */
alias IFnsidv    = int function(Ihandle*, char*, int, double, void*); /* postmessage_cb */

alias IFnff    = int function(Ihandle*, float, float);    /* canvas_action */
alias IFniff   = int function(Ihandle*,int,float,float);  /* scroll_cb */
alias IFnfiis  = int function(Ihandle*,float,int,int,char*);  /* wheel_cb */

alias IFnsVi   = int function(Ihandle*, char*, void*, int);  /* dragdata_cb */
alias IFnsViii = int function(Ihandle*, char*, void*, int, int, int);  /* dropdata_cb */
alias IFnsiii  = int function(Ihandle*, char*, int, int, int);  /* dropfiles_cb */
alias IFnssi   = int function(Ihandle*, char*, char*, int);  /* dragfilecreatename_cb */

alias IFnnii     = int function(Ihandle*, Ihandle*, int, int); /* drop_cb */
alias IFnn       = int function(Ihandle*, Ihandle*); /* savemarkers_cb, restoremarkers_cb */
alias IFnnn      = int function(Ihandle*, Ihandle*, Ihandle*); /* tabchange_cb */
alias IFnss      = int function(Ihandle*, char*, char*);  /* file_cb */
alias IFns       = int function(Ihandle*, char*);  /* multiselect_cb */
alias IFnsi      = int function(Ihandle*, char*, int);  /* copydata_cb */
alias IFnis      = int function(Ihandle*, int, char*);  /* text_action, multiline_action, edit_cb, rename_cb */
alias IFnsii     = int function(Ihandle*, char*, int, int);  /* list_action */
alias IFniis     = int function(Ihandle*, int, int, char*);  /* motion_cb, click_cb, value_edit_cb */
alias IFniiis    = int function(Ihandle*, int, int, int, char*);  /* touch_cb, dblclick_cb */
alias IFniiiis   = int function(Ihandle*, int, int, int, int, char*);  /* button_cb, matrix_action, mousemotion_cb */
alias IFniiiiiis = int function(Ihandle*, int, int, int, int, int, int, char*);  /* mouseclick_cb */

alias IFnIi     = int function(Ihandle*, int*, int); /* multiselection_cb, multiunselection_cb */
alias IFnd      = int function(Ihandle*, double);  /* mousemove_cb, button_press_cb, button_release_cb */
alias IFniiIII  = int function(Ihandle*, int, int, int*, int*, int*); /* fgcolor_cb, bgcolor_cb */
alias IFniinsii = int function(Ihandle*, int, int, Ihandle*, char*, int, int); /* dropselect_cb */
alias IFnccc    = int function(Ihandle*, ubyte, ubyte, ubyte); /* drag_cb, change_cb */
alias IFniIIII  = int function(Ihandle*, int, int*, int*, int*, int*); /* multitouch_cb */

alias IFnC        = int function(Ihandle*, _cdCanvas*); /* postdraw_cb, predraw_cb */
//alias IFniiff     = int function(Ihandle*, int, int, float, float); /* delete_cb (pplot) */
//alias IFniiffi    = int function(Ihandle*, int, int, float, float, int); /* select_cb (pplot) */
alias IFniidd     = int function(Ihandle*, int, int, double, double); /* delete_cb */
alias IFniiddi    = int function(Ihandle*, int, int, double, double, int); /* select_cb */
alias IFniiddiddi = int function(Ihandle*, int, int, double, double, int, double, double, int); /* clicksegment_cb */
//alias IFniiffFF   = int function(Ihandle*, int, int, float, float, float*, float*); /* edit_cb */
//alias IFniiffs    = int function(Ihandle*, int, int, float, float, char*);  /* plotbutton_cb (pplot) */
alias IFniidds    = int function(Ihandle*, int, int, double, double, char*);  /* plotbutton_cb */
alias IFndds      = int function(Ihandle*, double, double, char*);    /* plotmotion_cb */
alias IFnssds     = int function(Ihandle*, char*, char*, double, char*); /* plottickformat_cb */
alias IFnni       = int function(Ihandle*, Ihandle*, int);

alias sIFnii  = char* function(Ihandle*, int, int);  /* value_cb, font_cb */
alias sIFni   = char* function(Ihandle*, int);  /* cell_cb */
alias sIFniis = char* function(Ihandle*, int, int, char*);  /* translatevalue_cb */

alias dIFnii  = double function(Ihandle*, int, int);  /* numericgetvalue_cb */
alias IFniid  = int    function(Ihandle*, int, int, double);  /* numericsetvalue_cb */

alias IFniiv  = void function(Ihandle*, int, int, void*);  /* android_onactivityresult_cb */

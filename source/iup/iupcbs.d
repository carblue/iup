/** \file
 * \brief Contains all function pointer typedefs.
 *
 * See Copyright Notice in "iup.h"
 */
 
module iup.iupcbs;

struct _cdCanvas;

alias IFidle = int function();  /* idle */

alias IFi     = void function(int); /* globalentermodal_cb, globalleavemodal_cb,  */
alias IFii    = void function(int, int); /* globalkeypress_cb */
alias IFiis   = void function(int, int, char*);  /* globalmotion_cb */
alias IFiiiis = void function(int, int, int, int, char*);  /* globalbutton_cb */
alias IFfiis  = void function(float,int,int,char*);  /* globalwheel_cb */
/+
typedef int function(*IFn)(Ihandle*);  /* default definition, same as Icallback */
typedef int function(*IFni)(Ihandle*, int);   /* k_any, show_cb, toggle_action, spin_cb, branchopen_cb, branchclose_cb, executeleaf_cb, showrename_cb, rightclick_cb, extended_cb, height_cb, width_cb */
typedef int function(*IFnii)(Ihandle*, int, int);  /* resize_cb, caret_cb, matrix_mousemove_cb, enteritem_cb, leaveitem_cb, scrolltop_cb, dropcheck_cb, selection_cb, select_cb, switch_cb, scrolling_cb, vspan_cb, hspan_cb */
typedef int function(*IFniii)(Ihandle*, int, int, int); /* trayclick_cb, edition_cb */
typedef int function(*IFniiii)(Ihandle*, int, int, int, int); /* dragdrop_cb */
typedef int function(*IFniiiiiiC)(Ihandle*, int, int, int, int, int, int, struct _cdCanvas*);  /* draw_cb */
typedef int function(*IFniiiiii)(Ihandle*, int, int, int, int, int, int);  /* OLD draw_cb */

typedef int function(*IFnff)(Ihandle*, float, float);    /* canvas_action, plotmotion_cb (pplot) */
typedef int function(*IFniff)(Ihandle*,int,float,float);  /* scroll_cb */
typedef int function(*IFnfiis)(Ihandle*,float,int,int,char*);  /* wheel_cb */

typedef int function(*IFnsVi)(Ihandle*, char*, void*, int);  /* dragdata_cb */
typedef int function(*IFnsViii)(Ihandle*, char*, void*, int, int, int);  /* dropdata_cb */
typedef int function(*IFnsiii)(Ihandle*, char*, int, int, int);  /* dropfiles_cb */

typedef int function(*IFnnii)(Ihandle*, Ihandle*, int, int); /* drop_cb */
typedef int function(*IFnnn)(Ihandle*, Ihandle*, Ihandle*); /* tabchange_cb */
typedef int function(*IFnss)(Ihandle*, char *, char *);  /* file_cb */
typedef int function(*IFns)(Ihandle*, char *);  /* multiselect_cb */
typedef int function(*IFnsi)(Ihandle*, char *, int);  /* copydata_cb */
typedef int function(*IFnis)(Ihandle*, int, char *);  /* text_action, multiline_action, edit_cb, rename_cb */
typedef int function(*IFnsii)(Ihandle*, char*, int, int);  /* list_action */
typedef int function(*IFniis)(Ihandle*, int, int, char*);  /* motion_cb, click_cb, value_edit_cb */
typedef int function(*IFniiis)(Ihandle*, int, int, int, char*);  /* touch_cb, dblclick_cb */
typedef int function(*IFniiiis)(Ihandle*, int, int, int, int, char*);  /* button_cb, matrix_action, mousemotion_cb */
typedef int function(*IFniiiiiis)(Ihandle*, int, int, int, int, int, int, char*);  /* mouseclick_cb */

typedef int function(*IFnIi)(Ihandle*, int*, int); /* multiselection_cb, multiunselection_cb */
typedef int function(*IFnd)(Ihandle*, double);  /* mousemove_cb, button_press_cb, button_release_cb */
typedef int function(*IFniiIII)(Ihandle*, int, int, int*, int*, int*); /* fgcolor_cb, bgcolor_cb */
typedef int function(*IFniinsii)(Ihandle*, int, int, Ihandle*, char*, int, int); /* dropselect_cb */
typedef int function(*IFnccc)(Ihandle*, unsigned char, unsigned char, unsigned char); /* drag_cb, change_cb */
typedef int function(*IFniIIII)(Ihandle*, int, int*, int*, int*, int*); /* multitouch_cb */

typedef int function(*IFnC)(Ihandle*, struct _cdCanvas*); /* postdraw_cb, predraw_cb */
typedef int function(*IFniiff)(Ihandle*, int, int, float, float); /* delete_cb (pplot) */
typedef int function(*IFniiffi)(Ihandle*, int, int, float, float, int); /* select_cb (pplot) */
typedef int function(*IFniidd)(Ihandle*, int, int, double, double); /* delete_cb */
typedef int function(*IFniiddi)(Ihandle*, int, int, double, double, int); /* select_cb */
typedef int function(*IFniiffFF)(Ihandle*, int, int, float, float, float*, float*); /* edit_cb */
typedef int function(*IFniiffs)(Ihandle*, int, int, float, float, char*);  /* plotbutton_cb (pplot) */
typedef int function(*IFniidds)(Ihandle*, int, int, double, double, char*);  /* plotbutton_cb */
typedef int function(*IFndds)(Ihandle*, double, double, char*);    /* plotmotion_cb */

typedef char* function(*sIFnii)(Ihandle*, int, int);  /* value_cb, font_cb */
typedef char* function(*sIFni)(Ihandle*, int);  /* cell_cb */
typedef char* function(*sIFniis)(Ihandle*, int, int, char*);  /* translatevalue_cb */

typedef double function(*dIFnii)(Ihandle*, int, int);  /* numericgetvalue_cb */
typedef int    function(*IFniid)(Ihandle*, int, int, double);  /* numericsetvalue_cb */
+/
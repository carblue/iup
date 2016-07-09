/** \file
 * \brief NativeWindow driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cdnative;

version(CD) :
//version(DigitalMars) { pragma(lib, "cd"); } // required anyway

import cd.cd : cdContext;

extern(C) @nogc nothrow :

cdContext* cdContextNativeWindow();
alias CD_NATIVEWINDOW = cdContextNativeWindow;

void cdGetScreenSize(int* width, int* height, double* width_mm, double* height_mm);
int cdGetScreenColorPlanes();

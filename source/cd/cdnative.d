/** \file
 * \brief NativeWindow driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cdnative;

version(CD) :

import cd.cd : cdContext;

//version(DigitalMars) version(Windows) { pragma(lib, "cd.lib"); } // import cd.cd required anyway, that comes with this pragma

extern(C) @nogc nothrow :

cdContext* cdContextNativeWindow();
alias CD_NATIVEWINDOW = cdContextNativeWindow;

void cdGetScreenSize(int* width, int* height, double* width_mm, double* height_mm);
int cdGetScreenColorPlanes();

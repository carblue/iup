/** \file
 * \brief Utilities using IM
 *
 * See Copyright Notice in "iup.h"
 */

module iup.iupim;

/* Usage of any of these functions requires prior installation of package/toolkit IM */

version(IM) :

import iup.iup : Ihandle;

// version(Posix)   { pragma(lib, "libiupim.so"); } // libiupim.so i.a. depends on libim.so
// version(Windows) { pragma(lib, "iupim.lib"); }

extern(C) @nogc nothrow :

void IupImOpen();  /* optional */

Ihandle* IupLoadImage(const(char)* filename); /// See_Also: https://webserver2.tecgraf.puc-rio.br/iup/en/iupim.html
int IupSaveImage(Ihandle* ih, const(char)* filename, const(char)* format);

Ihandle* IupLoadAnimation(const(char)* filename);
Ihandle* IupLoadAnimationFrames(const(char)** filename_list, int file_count);

//#ifdef __IM_IMAGE_H
//version(IM) { // without IM-binding, type imImage is unknown
	import im.im_image : imImage;
	imImage* IupGetNativeHandleImage(void* handle);
	void* IupGetImageNativeHandle(const(imImage)* image);

	Ihandle* IupImageFromImImage(const(imImage)* image);
	imImage* IupImageToImImage(Ihandle* iup_image);
//}
//#endif

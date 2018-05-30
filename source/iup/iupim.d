/** \file
 * \brief Utilities using IM
 *
 * See Copyright Notice in "iup.h"
 */

module iup.iupim;

/* Usage of any of these functions requires prior installation of package/toolkit IM */

import iup.iup : Ihandle;

version(DigitalMars) version(Windows) { pragma(lib, "iupim.lib"); } // libiupim.so depends on libim.so, (maybe image type specific .so like libpng12.so), libiup.so,...

extern(C) @nogc nothrow :

Ihandle* IupLoadImage(const(char)* file_name); /// See_Also: https://webserver2.tecgraf.puc-rio.br/iup/en/iupim.html
int IupSaveImage(Ihandle* ih, const(char)* file_name, const(char)* format);
Ihandle* IupLoadAnimation(const(char)* file_name);
Ihandle* IupLoadAnimationFrames(const(char)** file_name_list, int file_count);

version(IM) { // without IM-binding, type imImage is unknown
	import im.im_image : imImage;
	imImage* IupGetNativeHandleImage(void* handle);       // in libiupim.so
	void* IupGetImageNativeHandle(const(imImage)* image); // in libiupim.so
	Ihandle* IupImageFromImImage(const(imImage)* image);  // in libiupim.so
	imImage* IupImageToImImage(Ihandle* iup_image);
}

/** \file
 * \brief Utilities using IM
 *
 * See Copyright Notice in "iup.h"
 */

module iup.iupim;

import iup.iup;
import im.im_image;

extern (C) :

Ihandle* IupLoadImage(const(char)* file_name);
int IupSaveImage(Ihandle* ih, const(char)* file_name, const(char)* format);
Ihandle* IupLoadAnimation(const(char)* file_name);
Ihandle* IupLoadAnimationFrames(const(char)** file_name_list, int file_count);

imImage* IupGetNativeHandleImage(void* handle);
void* IupGetImageNativeHandle(const(imImage)* image);
Ihandle* IupImageFromImImage(const(imImage)* image);

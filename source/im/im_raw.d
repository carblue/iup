/** \file
 * \brief RAW File Format
 *
 * See Copyright Notice in im_lib.h
 */
module im.im_raw;

version(IM) :

import im.im : imFile;

//version(DigitalMars) version(Windows) { pragma(lib, "im.lib"); } // required anyway

extern(C) @nogc nothrow :


/** Opens a RAW image file.
 * See also \ref imErrorCodes.
 *
 * \verbatim im.FileOpenRaw(file_name: string) -> ifile: imFile, error: number [in Lua 5] \endverbatim
 * \ingroup raw */
imFile* imFileOpenRaw(const(char)* file_name, int* error);
                   
/** Creates a RAW image file.
 * See also \ref imErrorCodes.
 *
 * \verbatim im.FileNewRaw(file_name: string) -> ifile: imFile, error: number [in Lua 5] \endverbatim
 * \ingroup raw */
imFile* imFileNewRaw(const(char)* file_name, int* error);

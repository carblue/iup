/** \file
 * \brief Utilities
 *
 * See Copyright Notice in im_lib.h
 */
module im.im_util;

version(IM) :

import core.stdc.config : c_long, c_ulong;
import std.algorithm.comparison: min, max, clamp;
import std.traits;
import im.im : FreeEnumMembers, IM_ALPHA, IM_PACKED, IM_TOPDOWN;

//version(DigitalMars) version(Windows) { pragma(lib, "im.lib"); } // required anyway
version(DigitalMars) version(Windows) { pragma(lib, "im_lzo"); }

extern(C) :

@nogc nothrow {
/** \defgroup util Utilities
 * \par
 * See \ref im_util.h
 * @{
 */

//#define IM_MIN(_a, _b) (_a < _b? _a: _b)
alias IM_MIN = min;
//#define IM_MAX(_a, _b) (_a > _b? _a: _b)
alias IM_MAX = max;

/** @} */


/** \defgroup str String Utilities
 * \par
 * See \ref im_util.h
 * \ingroup util */

/** Check if the two strings are equal.
 * \ingroup str */
int imStrEqual(const(char)* str1, const(char)* str2);

/** Calculate the size of the string but limited to max_len.
 * \ingroup str */
int imStrNLen(const(char)* str, int max_len);

/** Check if the data is a string.
 * \ingroup str */
int imStrCheck(const(void)* data, int count);



/** \defgroup imageutil Raw Data Utilities
 * \par
 * See \ref im_util.h
 * \ingroup imagerep */

/** Returns the size of the data buffer.
 *
 * \verbatim im.ImageDataSize(width: number, height: number, color_mode: number, data_type: number) -> datasize: number [in Lua 5] \endverbatim
 * \ingroup imageutil */
int imImageDataSize(int width, int height, int color_mode, int data_type);

/** Returns the size of one line of the data buffer. \n
 * This depends if the components are packed. If packed includes all components, if not includes only one.
 *
 * \verbatim im.ImageLineSize(width: number, color_mode: number, data_type: number) -> linesize: number [in Lua 5] \endverbatim
 * \ingroup imageutil */
int imImageLineSize(int width, int color_mode, int data_type);

/** Returns the number of elements of one line of the data buffer. \n
 * This depends if the components are packed. If packed includes all components, if not includes only one.
 *
 * \verbatim im.ImageLineCount(width: number, color_mode: number) -> linecount: number [in Lua 5] \endverbatim
 * \ingroup imageutil */
int imImageLineCount(int width, int color_mode);

/** Check if the combination color_mode+data_type is valid.
 *
 * \verbatim im.ImageCheckFormat(color_mode: number, data_type: number) -> check: boolean [in Lua 5] \endverbatim
 * \ingroup imageutil */
int imImageCheckFormat(int color_mode, int data_type);



/** \defgroup colorutl Color Utilities
 * \par
 * See \ref im_util.h
 * \ingroup util */

/** Encode RGB components in a long for palette usage. \n
 * "long" definition is compatible with the CD library definition.
 *
 * \verbatim im.ColorEncode(red: number, green: number, blue: number) -> color: lightuserdata [in Lua 5] \endverbatim
 * \ingroup colorutl */
c_long imColorEncode(ubyte red, ubyte green, ubyte blue);

/** Decode RGB components from a long for palette usage. \n
 * "long" definition is compatible with the CD library definition.
 *
 * \verbatim im.ColorDecode(color: lightuserdata) -> red: number, green: number, blue: number [in Lua 5] \endverbatim
 * \ingroup colorutl */
void imColorDecode(ubyte* red, ubyte* green, ubyte* blue, c_long color);



/** \defgroup colormodeutl Color Mode Utilities
 * \par
 * See \ref im_util.h
 * \ingroup imagerep */

/** Returns the color mode name.
 *
 * \verbatim im.ColorModeSpaceName(color_mode: number) -> name: string [in Lua 5] \endverbatim
 * \ingroup colormodeutl */
const(char)* imColorModeSpaceName(int color_mode);

/** Returns the number of components of the color space including alpha.
 *
 * \verbatim im.ColorModeDepth(color_mode: number) -> depth: number [in Lua 5] \endverbatim
 * \ingroup colormodeutl */
int imColorModeDepth(int color_mode);

/** Returns the color space of the color mode.
 *
 * \verbatim im.ColorModeSpace(color_mode: number) -> color_space: number [in Lua 5] \endverbatim
 * \ingroup colormodeutl */
T imColorModeSpace(T)(T _cm) if (isIntegral!T) { return _cm & 0xFF;}

/** Check if the two color modes match. Only the color space is compared.
 *
 * \verbatim im.ColorModeMatch(color_mode1: number, color_mode2: number) -> match: boolean [in Lua 5] \endverbatim
 * \ingroup colormodeutl */
T imColorModeMatch(T)(T _cm1, T _cm2) if (isIntegral!T) { return imColorModeSpace(_cm1) == imColorModeSpace(_cm2); }

/** Check if the color mode has an alpha channel.
 *
 * \verbatim im.ColorModeHasAlpha(color_mode: number) -> has_alpha: boolean [in Lua 5] \endverbatim
 * \ingroup colormodeutl */
T imColorModeHasAlpha(T)(T _cm) if (isIntegral!T) { return _cm & IM_ALPHA; }

/** Check if the color mode components are packed in one plane.
 *
 * \verbatim im.ColorModeIsPacked(color_mode: number) -> is_packed: boolean [in Lua 5] \endverbatim
 * \ingroup colormodeutl */
T imColorModeIsPacked(T)(T _cm) if (isIntegral!T) { return _cm & IM_PACKED; }

/** Check if the color mode orients the image from top down to bottom.
 *
 * \verbatim im.ColorModeIsTopDown(color_mode: number) -> is_top_down: boolean [in Lua 5] \endverbatim
 * \ingroup colormodeutl */
T imColorModeIsTopDown(T)(T _cm) if (isIntegral!T) { return _cm & IM_TOPDOWN; }

/** Returns the color space of the equivalent display bitmap image. \n
 * Original packing and alpha are ignored. Returns IM_RGB, IM_GRAY, IM_MAP or IM_BINARY.
 *
 * \verbatim im.ColorModeToBitmap(color_mode: number) -> color_space: number [in Lua 5] \endverbatim
 * \ingroup colormodeutl */
int imColorModeToBitmap(int color_mode);

/** Check if the color mode and data_type defines a display bitmap image.
 *
 * \verbatim im.ColorModeIsBitmap(color_mode: number, data_type: number) -> is_bitmap: boolean [in Lua 5] \endverbatim
 * \ingroup colormodeutl */
int imColorModeIsBitmap(int color_mode, int data_type);

/** Max depth is 4+1  (cmyk+alpha)
 * \ingroup colormodeutl */
enum IM_MAXDEPTH = 5;



/** \defgroup datatypeutl Data Type Utilities
 * \par
 * See \ref im_util.h
 * \ingroup util
 * @{
 */

//typedef unsigned char imbyte;
//typedef unsigned short imushort;

ubyte IM_BYTECROP(c_ulong _v)      pure nothrow @nogc @safe              { return cast(ubyte)clamp(_v,    0,  255); }
T  IM_FLOATCROP(T)(T _v)           pure nothrow @nogc @safe if (isFloatingPoint!T)  { return clamp(_v,  0.f,  1.f); }
T    IM_CROPMAX(T)(T _v, T _max)         pure nothrow @nogc @safe if (isNumeric!T)  { return clamp(_v,    0, _max); }
T IM_CROPMINMAX(T)(T _v, T _min, T _max) pure nothrow @nogc @safe if (isNumeric!T)  { return clamp(_v, _min, _max); }

/** @} */

/** Returns the size in bytes of a specified numeric data type.
 *
 * \verbatim im.DataTypeSize(data_type: number) -> size: number [in Lua 5] \endverbatim
 * \ingroup datatypeutl */
int imDataTypeSize(int data_type);

/** Returns the numeric data type name given its identifier.
 *
 * \verbatim im.DataTypeName(data_type: number) -> name: string [in Lua 5] \endverbatim
 * \ingroup datatypeutl */
const(char)* imDataTypeName(int data_type);

/** Returns the maximum value of an integer data type. For floating point returns 0.
 *
 * \verbatim im.DataTypeIntMax(data_type: number) -> int_max: number [in Lua 5] \endverbatim
 * \ingroup datatypeutl */
c_ulong imDataTypeIntMax(int data_type);

/** Returns the minimum value of an integer data type. For floating point returns 0. 
 *
 * \verbatim im.DataTypeIntMin(data_type: number) -> int_min: number [in Lua 5] \endverbatim
 * \ingroup datatypeutl */
c_long imDataTypeIntMin(int data_type);

} // @nogc nothrow


/** \defgroup bin Binary Data Utilities
 * \par
 * See \ref im_util.h
 * \ingroup util */

/** CPU Byte Orders. 
  * \ingroup bin */
enum imByteOrder
{
  IM_LITTLEENDIAN, /**< Little Endian - The most significant byte is on the right end of a word. Used by Intel processors. */
  IM_BIGENDIAN     /**< Big Endian - The most significant byte is on the left end of a word. Used by Motorola processors, also is the network standard byte order. */
}
mixin FreeEnumMembers!imByteOrder;

@nogc nothrow :

/** Returns the current CPU byte order.
 * \ingroup bin */
int imBinCPUByteOrder();

/** Changes the byte order of an array of 2, 4 or 8 byte values.
 * \ingroup bin */
void imBinSwapBytes(void* data, int count, int size);

/** Changes the byte order of an array of 2 byte values.
 * \ingroup bin */
void imBinSwapBytes2(void* data, int count);

/** Inverts the byte order of the 4 byte values 
 * \ingroup bin */
void imBinSwapBytes4(void* data, int count);
            
/** Inverts the byte order of the 8 byte values 
 * \ingroup bin */
void imBinSwapBytes8(void* data, int count);



/** \defgroup compress Data Compression Utilities
 * \par
 * Deflate compression support uses zlib version 1.2.8.     \n
 * http://www.zlib.org/                                     \n
 * Copyright (C) 1995-2013 Jean-loup Gailly and Mark Adler
 * \par
 * LZF compression support uses libLZF version 3.5.       \n
 * http://software.schmorp.de/pkg/liblzf                  \n
 * Copyright (C) 2000-2009 Marc Alexander Lehmann
 * \par
 * LZO compression support uses mini-libLZO version 2.07. \n
 * http://www.oberhumer.com/opensource/lzo/                  \n
 * Copyright (C) 1996-2014 Markus Franz Xaver Johannes Oberhumer \n
 * But its License is GPL, so we kept it in a separate library 
 * called "im_lzo" that is also GPL.
 *
 * See \ref im_util.h
 * \ingroup util */

/** Compresses the data using the ZLIB Deflate compression. \n
 * The destination buffer must be at least 0.1% larger than source_size plus 12 bytes. \n
 * It compresses raw byte data. zip_quality can be 1 to 9. \n
 * Returns the size of the compressed buffer or zero if failed.
 * \ingroup compress */
int imCompressDataZ(const(void)* src_data, int src_size, void* dst_data, int dst_size, int zip_quality);

/** Uncompresses the data compressed with the ZLIB Deflate compression. \n
 * Returns zero if failed.
 * \ingroup compress */
int imCompressDataUnZ(const(void)* src_data, int src_size, void* dst_data, int dst_size);

/** Compresses the data using the libLZF compression. \n
 * Returns the size of the compressed buffer or zero if failed.
 * \ingroup compress */
int imCompressDataLZF(const(void)* src_data, int src_size, void* dst_data, int dst_size);

/** Uncompresses the data compressed with the libLZF compression. \n
 * Returns zero if failed.
 * \ingroup compress */
int imCompressDataUnLZF(const(void)* src_data, int src_size, void* dst_data, int dst_size);

/** Compresses the data using the libLZO compression. (Since 3.9) \n
* Returns the size of the compressed buffer or zero if failed. \n
* Available in a separate library called "im_lzo" which license is GPL.
* \ingroup compress */
int imCompressDataLZO(const(void)* src_data, int src_size, void* dst_data, int dst_size);

/** Uncompresses the data compressed with the libLZO compression. (Since 3.9) \n
* Returns zero if failed. \n
* Available in a separate library called "im_lzo" which license is GPL.
* \ingroup compress */
int imCompressDataUnLZO(const(void)* src_data, int src_size, void* dst_data, int dst_size);

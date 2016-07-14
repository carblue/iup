/** \file
 * \brief Old API
 *
 * See Copyright Notice in im_lib.h
 */
module im.im_old;

version(IM) :

import core.stdc.config : c_long;
import im.im : IM_ERR_ACCESS, IM_ERR_DATA, IM_ERR_COMPRESS;

//version(DigitalMars) version(Windows) { pragma(lib, "im.lib"); } // required anyway

extern(C) :
@nogc nothrow {

enum {IM_BMP, IM_PCX, IM_GIF, IM_TIF, IM_RAS, IM_SGI, IM_JPG, IM_LED, IM_TGA}
enum {IM_NONE = 0x0000, IM_DEFAULT = 0x0100, IM_COMPRESSED = 0x0200}                        

enum IM_ERR_READ  = IM_ERR_ACCESS;
enum IM_ERR_WRITE = IM_ERR_ACCESS;
enum IM_ERR_TYPE  = IM_ERR_DATA;
enum IM_ERR_COMP  = IM_ERR_COMPRESS;

c_long imEncodeColor(ubyte red, ubyte green, ubyte blue);
void imDecodeColor(ubyte* red, ubyte* green, ubyte* blue, c_long palette);
int imFileFormat(char* filename, int* format);
int imImageInfo(char* filename, int* width, int* height, int* type, int* palette_count);
int imLoadRGB(char* filename, ubyte* red, ubyte* green, ubyte* blue);
int imSaveRGB(int width, int height, int format, ubyte* red, ubyte* green, ubyte* blue, char* filename);
int imLoadMap(char* filename, ubyte* map, c_long* palette);
int imSaveMap(int width, int height, int format, ubyte* map, int palette_count, c_long* palette, char* filename);
void imRGB2Map(int width, int height, ubyte* red, ubyte* green, ubyte* blue, ubyte* map, int palette_count, c_long* palette);
void imMap2RGB(int width, int height, ubyte* map, int palette_count, c_long* colors, ubyte* red, ubyte* green, ubyte* blue);
void imRGB2Gray(int width, int height, ubyte* red, ubyte* green, ubyte* blue, ubyte* map, c_long* grays);
void imMap2Gray(int width, int height, ubyte* map, int palette_count, c_long* colors, ubyte* grey_map, c_long* grays);
void imResize(int src_width, int src_height, ubyte* src_map, int dst_width, int dst_height, ubyte* dst_map);
void imStretch(int src_width, int src_height, ubyte* src_map, int dst_width, int dst_height, ubyte* dst_map);

} // @nogc nothrow

alias imCallback = int function(char* filename) nothrow;
int imRegisterCallback(imCallback cb, int cb_id, int format) @nogc nothrow;

enum IM_INTERRUPTED = -1;
enum IM_ALL         = -1;
enum IM_COUNTER_CB  =  0;
alias imFileCounterCallback = int function(char* filename, int percent, int io) nothrow;

enum IM_RESOLUTION_CB  = 1;
alias imResolutionCallback = int function(char* filename, double* xres, double* yres, int* res_unit) nothrow;


enum {IM_RES_NONE, IM_RES_DPI, IM_RES_DPC};

enum IM_GIF_TRANSPARENT_COLOR_CB = 0;
alias imGifTranspIndex = int function(char* filename, ubyte* transp_index) @nogc nothrow;

enum IM_TIF_IMAGE_DESCRIPTION_CB = 0;
alias imTiffImageDesc = int function(char* filename, char* img_desc) @nogc nothrow;

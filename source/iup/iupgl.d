/** \file
 * \brief OpenGL canvas for Iup.
 *
 * See Copyright Notice in "iup.h"
 */

module iup.iupgl;

import iup.iup : Ihandle;

version(DigitalMars) version(Windows) { pragma(lib, "iupgl.lib"); } // libiupgl.so depends on libiup.so, ...
version(DigitalMars) version(Windows) { pragma(lib, "opengl32.lib"); } // link with the "opengl32.lib" library on Windows.

extern(C) @nogc nothrow :

/* Attributes
** To set the appropriate visual (pixel format) the following
** attributes may be specified. Their values should be set
** before the canvas is mapped to the scrren.
** After mapping, changing their values has no effect.
*/
/* IUP_SINGLE (defaut) or IUP_DOUBLE */
enum IUP_BUFFER           = "BUFFER";
/* IUP_NO (defaut) or IUP_YES */
enum IUP_STEREO           = "STEREO";
/* Number of bits if index mode */
enum IUP_BUFFER_SIZE      = "BUFFER_SIZE";
/* Number of red bits */
enum IUP_RED_SIZE         = "RED_SIZE";
/* Number of green bits */
enum IUP_GREEN_SIZE       = "GREEN_SIZE";
/* Number of blue bits */
enum IUP_BLUE_SIZE        = "BLUE_SIZE";
/* Number of alpha bits */
enum IUP_ALPHA_SIZE       = "ALPHA_SIZE";
/* Number of bits in depth buffer */
enum IUP_DEPTH_SIZE       = "DEPTH_SIZE";
/* Number of bits in stencil buffer */
enum IUP_STENCIL_SIZE     = "STENCIL_SIZE";
/* Number of red bits in accum. buffer */
enum IUP_ACCUM_RED_SIZE   = "ACCUM_RED_SIZE";
/* Number of green bits in accum. buffer */
enum IUP_ACCUM_GREEN_SIZE = "ACCUM_GREEN_SIZE";
/* Number of blue bits in accum. buffer */
enum IUP_ACCUM_BLUE_SIZE  = "ACCUM_BLUE_SIZE";
/* Number of alpha bits in accum. buffer */
enum IUP_ACCUM_ALPHA_SIZE = "ACCUM_ALPHA_SIZE";


/* Attribute values */
enum IUP_DOUBLE = "DOUBLE";
enum IUP_SINGLE = "SINGLE";
enum IUP_INDEX  = "INDEX";
enum IUP_RGBA   = "RGBA";
enum IUP_YES    = "YES";
enum IUP_NO     = "NO";

void IupGLCanvasOpen(); /// See_Also: https://webserver2.tecgraf.puc-rio.br/iup/en/ctrl/iupglcanvas.html

Ihandle* IupGLCanvas(const(char)* action);
Ihandle* IupGLBackgroundBox(Ihandle* child);

void IupGLMakeCurrent(Ihandle* ih);
int IupGLIsCurrent(Ihandle* ih);
void IupGLSwapBuffers(Ihandle* ih);
void IupGLPalette(Ihandle* ih, int index, float r, float g, float b);
void IupGLUseFont(Ihandle* ih, int first, int count, int list_base);
void IupGLWait(int gl);

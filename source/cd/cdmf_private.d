/** \file
 * \brief CD Metafile driver private declarations
 *
 * See Copyright Notice in cd.h
 */
module cd.cdmf_private;

version(CD) :

import cd.cd : cdCanvas;

//version(DigitalMars) version(Windows) { pragma(lib, "cd.lib"); } // import cd.cd required anyway, that comes with this pragma

extern(C) @nogc nothrow :

/* public part of the internal cdCtxCanvas */
struct cdCanvasMF 
{
	cdCanvas* canvas;
	char* filename;       
	void* data;           
}

void cdcreatecanvasMF(cdCanvas* canvas, void* data);
void cdinittableMF(cdCanvas* canvas);
void cdkillcanvasMF(cdCanvasMF* mfcanvas);

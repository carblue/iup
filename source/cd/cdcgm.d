/** \file
 * \brief CGM driver
 *
 * See Copyright Notice in cd.h
 */
module cd.cdcgm;

version(CD) :
//version(DigitalMars) { pragma(lib, "cd"); } // required anyway

import cd.cd : cdContext;

extern(C) @nogc nothrow :

cdContext* cdContextCGM();
alias CD_CGM = cdContextCGM;

enum CD_CGMCOUNTERCB = 1;
enum CD_CGMSCLMDECB = 2;
enum CD_CGMVDCEXTCB = 3;
enum CD_CGMBEGPICTCB = 4;
enum CD_CGMBEGPICTBCB = 5;
enum CD_CGMBEGMTFCB = 6;

/* OLD definitions, defined for backward compatibility */
//#define CDPLAY_ABORT CD_ABORT
//#define CDPLAY_GO CD_CONTINUE

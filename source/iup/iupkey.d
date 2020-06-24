/** \file
 * \brief Keyboard Keys definitions.
 *
 * See Copyright Notice in "iup.h"
 */

/*
Attention: Changed when binding to D:
There were no types at all in the underlying C-source file, just a bunch of #define, but some would work with/be/result in int types
In the D binding code, the type of a key is the smallest Char type, that can represent the key's value, either char, wchar or dchar.
Likewise, the key related functions operate on Char types only, even if they are templates
My reasoning is: This reduces mixing keys with other arbitrary integral types 
This won't compile: auto keyA = 65; writeln("keyA is printable: ", iup_isprint(keyA)); // Error: template iup.iupkey.iup_isprint cannot deduce function from argument types !()(int)
This will  compile: char keyB = 66; writeln("keyB is printable: ", iup_isprint(keyB)); // if You insist on using int literal 66 instead of K_B; the compiler is smart enough to implicitely convert 66 to char
*/
module iup.iupkey;

import std.traits : isSomeChar;

/* from 32 to 126, all character sets are equal,
   the key code is the same as the ASCii character code. */
enum : char {
     K_SP          = ' ',   /* 32 (0x20) */
     K_exclam      = '!',   /* 33 */
     K_quotedbl    = '\"',  /* 34 */
     K_numbersign  = '#',   /* 35 */
     K_dollar      = '$',   /* 36 */
     K_percent     = '%',   /* 37 */
     K_ampersand   = '&',   /* 38 */
     K_apostrophe  = '\'',  /* 39 */
     K_parentleft  = '(',   /* 40 */
     K_parentright = ')',   /* 41 */
     K_asterisk    = '*',   /* 42 */
     K_plus        = '+',   /* 43 */
     K_comma       = ',',   /* 44 */
     K_minus       = '-',   /* 45 */
     K_period      = '.',   /* 46 */
     K_slash       = '/',   /* 47 */
     K_0           = '0',   /* 48 (0x30) */
     K_1           = '1',   /* 49 */
     K_2           = '2',   /* 50 */
     K_3           = '3',   /* 51 */
     K_4           = '4',   /* 52 */
     K_5           = '5',   /* 53 */
     K_6           = '6',   /* 54 */
     K_7           = '7',   /* 55 */
     K_8           = '8',   /* 56 */
     K_9           = '9',   /* 57 */
     K_colon       = ':',   /* 58 */
     K_semicolon   = ';',   /* 59 */
     K_less        = '<',   /* 60 */
     K_equal       = '=',   /* 61 */
     K_greater     = '>',   /* 62 */
     K_question    = '?',   /* 63 */
     K_at          = '@',   /* 64 */
     K_A           = 'A',   /* 65 (0x41) */
     K_B           = 'B',   /* 66 */
     K_C           = 'C',   /* 67 */
     K_D           = 'D',   /* 68 */
     K_E           = 'E',   /* 69 */
     K_F           = 'F',   /* 70 */
     K_G           = 'G',   /* 71 */
     K_H           = 'H',   /* 72 */
     K_I           = 'I',   /* 73 */
     K_J           = 'J',   /* 74 */
     K_K           = 'K',   /* 75 */
     K_L           = 'L',   /* 76 */
     K_M           = 'M',   /* 77 */
     K_N           = 'N',   /* 78 */
     K_O           = 'O',   /* 79 */
     K_P           = 'P',   /* 80 */
     K_Q           = 'Q',   /* 81 */
     K_R           = 'R',   /* 82 */
     K_S           = 'S',   /* 83 */
     K_T           = 'T',   /* 84 */
     K_U           = 'U',   /* 85 */
     K_V           = 'V',   /* 86 */
     K_W           = 'W',   /* 87 */
     K_X           = 'X',   /* 88 */
     K_Y           = 'Y',   /* 89 */
     K_Z           = 'Z',   /* 90 */
     K_bracketleft = '[',   /* 91 */
     K_backslash   = '\\',  /* 92 */
     K_bracketright= ']',   /* 93 */
     K_circum      = '^',   /* 94 */
     K_underscore  = '_',   /* 95 */
     K_grave       = '`',   /* 96 */
     K_a           = 'a',   /* 97 (0x61) */
     K_b           = 'b',   /* 98 */
     K_c           = 'c',   /* 99 */
     K_d           = 'd',   /* 100 */
     K_e           = 'e',   /* 101 */
     K_f           = 'f',   /* 102 */
     K_g           = 'g',   /* 103 */
     K_h           = 'h',   /* 104 */
     K_i           = 'i',   /* 105 */
     K_j           = 'j',   /* 106 */
     K_k           = 'k',   /* 107 */
     K_l           = 'l',   /* 108 */
     K_m           = 'm',   /* 109 */
     K_n           = 'n',   /* 110 */
     K_o           = 'o',   /* 111 */
     K_p           = 'p',   /* 112 */
     K_q           = 'q',   /* 113 */
     K_r           = 'r',   /* 114 */
     K_s           = 's',   /* 115 */
     K_t           = 't',   /* 116 */
     K_u           = 'u',   /* 117 */
     K_v           = 'v',   /* 118 */
     K_w           = 'w',   /* 119 */
     K_x           = 'x',   /* 120 */
     K_y           = 'y',   /* 121 */
     K_z           = 'z',   /* 122 */
     K_braceleft   = '{',   /* 123 */
     K_bar         = '|',   /* 124 */
     K_braceright  = '}',   /* 125 */
     K_tilde       = '~',   /* 126 (0x7E) */
}

/* Printable ASCii keys */

bool iup_isprint(T)(T _c) if (isSomeChar!T) { return _c > 31 && _c < 127; }

/* also define the escape sequences that have keys associated */

enum : char {
        K_BS          = '\b',       /* 8 */
        K_TAB         = '\t',       /* 9 */
        K_LF          = '\n',       /* 10 (0x0A) not a real key, is a combination of CR with a modifier, just to document */
        K_CR          = '\r',       /* 13 (0x0D) */
}
/* backward compatible definitions */

enum : char {
        K_quoteleft   = K_grave,
        K_quoteright  = K_apostrophe,
}

/* IUP Extended Key Codes, range start at 128      */

bool iup_isXkey(T)(T _c) if (isSomeChar!T) { return _c >= 128; }

/* These use the same definition as X11 and GDK.
   This also means that any X11 or GDK definition can also be used. */

enum : wchar {
			K_PAUSE    = 0xFF13,
			K_ESC      = 0xFF1B,
			K_HOME     = 0xFF50,
			K_LEFT     = 0xFF51,
			K_UP       = 0xFF52,
			K_RIGHT    = 0xFF53,
			K_DOWN     = 0xFF54,
			K_PGUP     = 0xFF55,
			K_PGDN     = 0xFF56,
			K_END      = 0xFF57,
			K_MIDDLE   = 0xFF0B,
			K_Print    = 0xFF61,
			K_INS      = 0xFF63,
			K_Menu     = 0xFF67,
			K_DEL      = 0xFFFF,
			K_F1       = 0xFFBE,
			K_F2       = 0xFFBF,
			K_F3       = 0xFFC0,
			K_F4       = 0xFFC1,
			K_F5       = 0xFFC2,
			K_F6       = 0xFFC3,
			K_F7       = 0xFFC4,
			K_F8       = 0xFFC5,
			K_F9       = 0xFFC6,
			K_F10      = 0xFFC7,
			K_F11      = 0xFFC8,
			K_F12      = 0xFFC9,
			K_F13      = 0xFFCA,
			K_F14      = 0xFFCB,
			K_F15      = 0xFFCC,
			K_F16      = 0xFFCD,
			K_F17      = 0xFFCE,
			K_F18      = 0xFFCF,
			K_F19      = 0xFFD0,
			K_F20      = 0xFFD1,

			/* no Shift/Ctrl/Alt */
			K_LSHIFT   = 0xFFE1,
			K_RSHIFT   = 0xFFE2,
			K_LCTRL    = 0xFFE3,
			K_RCTRL    = 0xFFE4,
			K_LALT     = 0xFFE9,
			K_RALT     = 0xFFEA,

			K_NUM      = 0xFF7F,
			K_SCROLL   = 0xFF14,
			K_CAPS     = 0xFFE5,

			/* Mac clear button. Value randomly picked trying to avoid clashing with an existing value. */
			K_CLEAR    = 0xFFD2,
			/* Help button if anybody has it. Value randomly picked trying to avoid clashing with an existing value. */
			K_HELP     = 0xFFD3,

			/* Also, these are the same as the Latin-1 definition */

			K_ccedilla  = 0x00E7,
			K_Ccedilla  = 0x00C7,
			K_acute     = 0x00B4,  /* no Shift/Ctrl/Alt */
			K_diaeresis = 0x00A8,
}

/******************************************************/
/* Modifiers use last 4 bits. Since IUP 3.9           */
/* These modifiers definitions are specific to IUP    */
/******************************************************/

bool iup_isShiftXkey()(dchar _c)  { return (_c & 0x1000_0000) != 0; }
bool iup_isCtrlXkey()(dchar _c)   { return (_c & 0x2000_0000) != 0; }
bool iup_isAltXkey()(dchar _c)    { return (_c & 0x4000_0000) != 0; }
bool iup_isSysXkey()(dchar _c)    { return (_c & 0x8000_0000) != 0; }

dchar iup_XkeyBase()(dchar _c)     { return _c & 0x0FFF_FFFF; }
dchar iup_XkeyShift()(dchar _c)    { return _c | 0x1000_0000; }   /* Shift  */
dchar iup_XkeyCtrl()(dchar _c)     { return _c | 0x2000_0000; }   /* Ctrl   */
dchar iup_XkeyAlt()(dchar _c)      { return _c | 0x4000_0000; }   /* Alt    */
dchar iup_XkeySys()(dchar _c)      { return _c | 0x8000_0000; }   /* Sys (Win or Apple) - notice that using "int" will display a negative value */

/* These definitions are here for backward compatibility 
   and to simplify some key combination usage.
   But since IUP 3.9, modifiers can be combined with any key
   and they can be mixed together. */

enum : dchar {
			K_sHOME    = iup_XkeyShift(K_HOME   ),
			K_sUP      = iup_XkeyShift(K_UP     ),
			K_sPGUP    = iup_XkeyShift(K_PGUP   ),
			K_sLEFT    = iup_XkeyShift(K_LEFT   ),
			K_sMIDDLE  = iup_XkeyShift(K_MIDDLE ),
			K_sRIGHT   = iup_XkeyShift(K_RIGHT  ),
			K_sEND     = iup_XkeyShift(K_END    ),
			K_sDOWN    = iup_XkeyShift(K_DOWN   ),
			K_sPGDN    = iup_XkeyShift(K_PGDN   ),
			K_sINS     = iup_XkeyShift(K_INS    ),
			K_sDEL     = iup_XkeyShift(K_DEL    ),
			K_sSP      = iup_XkeyShift(K_SP     ),
			K_sTAB     = iup_XkeyShift(K_TAB    ),
			K_sCR      = iup_XkeyShift(K_CR     ),
			K_sBS      = iup_XkeyShift(K_BS     ),
			K_sPAUSE   = iup_XkeyShift(K_PAUSE  ),
			K_sESC     = iup_XkeyShift(K_ESC    ),
			K_sCLEAR   = iup_XkeyShift(K_CLEAR  ),
			K_sF1      = iup_XkeyShift(K_F1     ),
			K_sF2      = iup_XkeyShift(K_F2     ),
			K_sF3      = iup_XkeyShift(K_F3     ),
			K_sF4      = iup_XkeyShift(K_F4     ),
			K_sF5      = iup_XkeyShift(K_F5     ),
			K_sF6      = iup_XkeyShift(K_F6     ),
			K_sF7      = iup_XkeyShift(K_F7     ),
			K_sF8      = iup_XkeyShift(K_F8     ),
			K_sF9      = iup_XkeyShift(K_F9     ),
			K_sF10     = iup_XkeyShift(K_F10    ),
			K_sF11     = iup_XkeyShift(K_F11    ),
			K_sF12     = iup_XkeyShift(K_F12    ),
			K_sF13     = iup_XkeyShift(K_F13    ),
			K_sF14     = iup_XkeyShift(K_F14    ),
			K_sF15     = iup_XkeyShift(K_F15    ),
			K_sF16     = iup_XkeyShift(K_F16    ),
			K_sF17     = iup_XkeyShift(K_F17    ),
			K_sF18     = iup_XkeyShift(K_F18    ),
			K_sF19     = iup_XkeyShift(K_F19    ),
			K_sF20     = iup_XkeyShift(K_F20    ),
			K_sPrint   = iup_XkeyShift(K_Print  ),
			K_sMenu    = iup_XkeyShift(K_Menu   ),

			K_cHOME    = iup_XkeyCtrl(K_HOME    ),
			K_cUP      = iup_XkeyCtrl(K_UP      ),
			K_cPGUP    = iup_XkeyCtrl(K_PGUP    ),
			K_cLEFT    = iup_XkeyCtrl(K_LEFT    ),
			K_cMIDDLE  = iup_XkeyCtrl(K_MIDDLE  ),
			K_cRIGHT   = iup_XkeyCtrl(K_RIGHT   ),
			K_cEND     = iup_XkeyCtrl(K_END     ),
			K_cDOWN    = iup_XkeyCtrl(K_DOWN    ),
			K_cPGDN    = iup_XkeyCtrl(K_PGDN    ),
			K_cINS     = iup_XkeyCtrl(K_INS     ),
			K_cDEL     = iup_XkeyCtrl(K_DEL     ),
			K_cSP      = iup_XkeyCtrl(K_SP      ),
			K_cTAB     = iup_XkeyCtrl(K_TAB     ),
			K_cCR      = iup_XkeyCtrl(K_CR      ),
			K_cBS      = iup_XkeyCtrl(K_BS      ),
			K_cPAUSE   = iup_XkeyCtrl(K_PAUSE   ),
			K_cESC     = iup_XkeyCtrl(K_ESC     ),
			K_cCLEAR   = iup_XkeyCtrl(K_CLEAR   ),
			K_cCcedilla= iup_XkeyCtrl(K_Ccedilla),
			K_cF1      = iup_XkeyCtrl(K_F1      ),
			K_cF2      = iup_XkeyCtrl(K_F2      ),
			K_cF3      = iup_XkeyCtrl(K_F3      ),
			K_cF4      = iup_XkeyCtrl(K_F4      ),
			K_cF5      = iup_XkeyCtrl(K_F5      ),
			K_cF6      = iup_XkeyCtrl(K_F6      ),
			K_cF7      = iup_XkeyCtrl(K_F7      ),
			K_cF8      = iup_XkeyCtrl(K_F8      ),
			K_cF9      = iup_XkeyCtrl(K_F9      ),
			K_cF10     = iup_XkeyCtrl(K_F10     ),
			K_cF11     = iup_XkeyCtrl(K_F11     ),
			K_cF12     = iup_XkeyCtrl(K_F12     ),
			K_cF13     = iup_XkeyCtrl(K_F13     ),
			K_cF14     = iup_XkeyCtrl(K_F14     ),
			K_cF15     = iup_XkeyCtrl(K_F15     ),
			K_cF16     = iup_XkeyCtrl(K_F16     ),
			K_cF17     = iup_XkeyCtrl(K_F17     ),
			K_cF18     = iup_XkeyCtrl(K_F18     ),
			K_cF19     = iup_XkeyCtrl(K_F19     ),
			K_cF20     = iup_XkeyCtrl(K_F20     ),
			K_cPrint   = iup_XkeyCtrl(K_Print   ),
			K_cMenu    = iup_XkeyCtrl(K_Menu    ),

			K_mHOME    = iup_XkeyAlt(K_HOME    ),
			K_mUP      = iup_XkeyAlt(K_UP      ),
			K_mPGUP    = iup_XkeyAlt(K_PGUP    ),
			K_mLEFT    = iup_XkeyAlt(K_LEFT    ),
			K_mMIDDLE  = iup_XkeyAlt(K_MIDDLE  ),
			K_mRIGHT   = iup_XkeyAlt(K_RIGHT   ),
			K_mEND     = iup_XkeyAlt(K_END     ),
			K_mDOWN    = iup_XkeyAlt(K_DOWN    ),
			K_mPGDN    = iup_XkeyAlt(K_PGDN    ),
			K_mINS     = iup_XkeyAlt(K_INS     ),
			K_mDEL     = iup_XkeyAlt(K_DEL     ),
			K_mSP      = iup_XkeyAlt(K_SP      ),
			K_mTAB     = iup_XkeyAlt(K_TAB     ),
			K_mCR      = iup_XkeyAlt(K_CR      ),
			K_mBS      = iup_XkeyAlt(K_BS      ),
			K_mPAUSE   = iup_XkeyAlt(K_PAUSE   ),
			K_mESC     = iup_XkeyAlt(K_ESC     ),
			K_mCLEAR   = iup_XkeyAlt(K_CLEAR   ),
			K_mCcedilla= iup_XkeyAlt(K_Ccedilla),
			K_mF1      = iup_XkeyAlt(K_F1      ),
			K_mF2      = iup_XkeyAlt(K_F2      ),
			K_mF3      = iup_XkeyAlt(K_F3      ),
			K_mF4      = iup_XkeyAlt(K_F4      ),
			K_mF5      = iup_XkeyAlt(K_F5      ),
			K_mF6      = iup_XkeyAlt(K_F6      ),
			K_mF7      = iup_XkeyAlt(K_F7      ),
			K_mF8      = iup_XkeyAlt(K_F8      ),
			K_mF9      = iup_XkeyAlt(K_F9      ),
			K_mF10     = iup_XkeyAlt(K_F10     ),
			K_mF11     = iup_XkeyAlt(K_F11     ),
			K_mF12     = iup_XkeyAlt(K_F12     ),
			K_mF13     = iup_XkeyAlt(K_F13     ),
			K_mF14     = iup_XkeyAlt(K_F14     ),
			K_mF15     = iup_XkeyAlt(K_F15     ),
			K_mF16     = iup_XkeyAlt(K_F16     ),
			K_mF17     = iup_XkeyAlt(K_F17     ),
			K_mF18     = iup_XkeyAlt(K_F18     ),
			K_mF19     = iup_XkeyAlt(K_F19     ),
			K_mF20     = iup_XkeyAlt(K_F20     ),
			K_mPrint   = iup_XkeyAlt(K_Print   ),
			K_mMenu    = iup_XkeyAlt(K_Menu    ),

			K_yHOME    = iup_XkeySys(K_HOME    ),
			K_yUP      = iup_XkeySys(K_UP      ),
			K_yPGUP    = iup_XkeySys(K_PGUP    ),
			K_yLEFT    = iup_XkeySys(K_LEFT    ),
			K_yMIDDLE  = iup_XkeySys(K_MIDDLE  ),
			K_yRIGHT   = iup_XkeySys(K_RIGHT   ),
			K_yEND     = iup_XkeySys(K_END     ),
			K_yDOWN    = iup_XkeySys(K_DOWN    ),
			K_yPGDN    = iup_XkeySys(K_PGDN    ),
			K_yINS     = iup_XkeySys(K_INS     ),
			K_yDEL     = iup_XkeySys(K_DEL     ),
			K_ySP      = iup_XkeySys(K_SP      ),
			K_yTAB     = iup_XkeySys(K_TAB     ),
			K_yCR      = iup_XkeySys(K_CR      ),
			K_yBS      = iup_XkeySys(K_BS      ),
			K_yPAUSE   = iup_XkeySys(K_PAUSE   ),
			K_yESC     = iup_XkeySys(K_ESC     ),
			K_yCLEAR   = iup_XkeySys(K_CLEAR   ),
			K_yCcedilla= iup_XkeySys(K_Ccedilla),
			K_yF1      = iup_XkeySys(K_F1      ),
			K_yF2      = iup_XkeySys(K_F2      ),
			K_yF3      = iup_XkeySys(K_F3      ),
			K_yF4      = iup_XkeySys(K_F4      ),
			K_yF5      = iup_XkeySys(K_F5      ),
			K_yF6      = iup_XkeySys(K_F6      ),
			K_yF7      = iup_XkeySys(K_F7      ),
			K_yF8      = iup_XkeySys(K_F8      ),
			K_yF9      = iup_XkeySys(K_F9      ),
			K_yF10     = iup_XkeySys(K_F10     ),
			K_yF11     = iup_XkeySys(K_F11     ),
			K_yF12     = iup_XkeySys(K_F12     ),
			K_yF13     = iup_XkeySys(K_F13     ),
			K_yF14     = iup_XkeySys(K_F14     ),
			K_yF15     = iup_XkeySys(K_F15     ),
			K_yF16     = iup_XkeySys(K_F16     ),
			K_yF17     = iup_XkeySys(K_F17     ),
			K_yF18     = iup_XkeySys(K_F18     ),
			K_yF19     = iup_XkeySys(K_F19     ),
			K_yF20     = iup_XkeySys(K_F20     ),
			K_yPrint   = iup_XkeySys(K_Print   ),
			K_yMenu    = iup_XkeySys(K_Menu    ),

			K_sPlus        = iup_XkeyShift(K_plus    ),
			K_sComma       = iup_XkeyShift(K_comma   ),
			K_sMinus       = iup_XkeyShift(K_minus   ),
			K_sPeriod      = iup_XkeyShift(K_period  ),
			K_sSlash       = iup_XkeyShift(K_slash   ),
			K_sAsterisk    = iup_XkeyShift(K_asterisk),

			K_cA    = iup_XkeyCtrl(K_A),
			K_cB    = iup_XkeyCtrl(K_B),
			K_cC    = iup_XkeyCtrl(K_C),
			K_cD    = iup_XkeyCtrl(K_D),
			K_cE    = iup_XkeyCtrl(K_E),
			K_cF    = iup_XkeyCtrl(K_F),
			K_cG    = iup_XkeyCtrl(K_G),
			K_cH    = iup_XkeyCtrl(K_H),
			K_cI    = iup_XkeyCtrl(K_I),
			K_cJ    = iup_XkeyCtrl(K_J),
			K_cK    = iup_XkeyCtrl(K_K),
			K_cL    = iup_XkeyCtrl(K_L),
			K_cM    = iup_XkeyCtrl(K_M),
			K_cN    = iup_XkeyCtrl(K_N),
			K_cO    = iup_XkeyCtrl(K_O),
			K_cP    = iup_XkeyCtrl(K_P),
			K_cQ    = iup_XkeyCtrl(K_Q),
			K_cR    = iup_XkeyCtrl(K_R),
			K_cS    = iup_XkeyCtrl(K_S),
			K_cT    = iup_XkeyCtrl(K_T),
			K_cU    = iup_XkeyCtrl(K_U),
			K_cV    = iup_XkeyCtrl(K_V),
			K_cW    = iup_XkeyCtrl(K_W),
			K_cX    = iup_XkeyCtrl(K_X),
			K_cY    = iup_XkeyCtrl(K_Y),
			K_cZ    = iup_XkeyCtrl(K_Z),
			K_c1    = iup_XkeyCtrl(K_1),
			K_c2    = iup_XkeyCtrl(K_2),
			K_c3    = iup_XkeyCtrl(K_3),
			K_c4    = iup_XkeyCtrl(K_4),
			K_c5    = iup_XkeyCtrl(K_5),
			K_c6    = iup_XkeyCtrl(K_6),
			K_c7    = iup_XkeyCtrl(K_7),
			K_c8    = iup_XkeyCtrl(K_8),
			K_c9    = iup_XkeyCtrl(K_9),
			K_c0    = iup_XkeyCtrl(K_0),
			K_cPlus        = iup_XkeyCtrl(K_plus        ),
			K_cComma       = iup_XkeyCtrl(K_comma       ),
			K_cMinus       = iup_XkeyCtrl(K_minus       ),
			K_cPeriod      = iup_XkeyCtrl(K_period      ),
			K_cSlash       = iup_XkeyCtrl(K_slash       ),
			K_cSemicolon   = iup_XkeyCtrl(K_semicolon   ),
			K_cEqual       = iup_XkeyCtrl(K_equal       ),
			K_cBracketleft = iup_XkeyCtrl(K_bracketleft ),
			K_cBracketright= iup_XkeyCtrl(K_bracketright),
			K_cBackslash   = iup_XkeyCtrl(K_backslash   ),
			K_cAsterisk    = iup_XkeyCtrl(K_asterisk    ),

			K_mA    = iup_XkeyAlt(K_A),
			K_mB    = iup_XkeyAlt(K_B),
			K_mC    = iup_XkeyAlt(K_C),
			K_mD    = iup_XkeyAlt(K_D),
			K_mE    = iup_XkeyAlt(K_E),
			K_mF    = iup_XkeyAlt(K_F),
			K_mG    = iup_XkeyAlt(K_G),
			K_mH    = iup_XkeyAlt(K_H),
			K_mI    = iup_XkeyAlt(K_I),
			K_mJ    = iup_XkeyAlt(K_J),
			K_mK    = iup_XkeyAlt(K_K),
			K_mL    = iup_XkeyAlt(K_L),
			K_mM    = iup_XkeyAlt(K_M),
			K_mN    = iup_XkeyAlt(K_N),
			K_mO    = iup_XkeyAlt(K_O),
			K_mP    = iup_XkeyAlt(K_P),
			K_mQ    = iup_XkeyAlt(K_Q),
			K_mR    = iup_XkeyAlt(K_R),
			K_mS    = iup_XkeyAlt(K_S),
			K_mT    = iup_XkeyAlt(K_T),
			K_mU    = iup_XkeyAlt(K_U),
			K_mV    = iup_XkeyAlt(K_V),
			K_mW    = iup_XkeyAlt(K_W),
			K_mX    = iup_XkeyAlt(K_X),
			K_mY    = iup_XkeyAlt(K_Y),
			K_mZ    = iup_XkeyAlt(K_Z),
			K_m1    = iup_XkeyAlt(K_1),
			K_m2    = iup_XkeyAlt(K_2),
			K_m3    = iup_XkeyAlt(K_3),
			K_m4    = iup_XkeyAlt(K_4),
			K_m5    = iup_XkeyAlt(K_5),
			K_m6    = iup_XkeyAlt(K_6),
			K_m7    = iup_XkeyAlt(K_7),
			K_m8    = iup_XkeyAlt(K_8),
			K_m9    = iup_XkeyAlt(K_9),
			K_m0    = iup_XkeyAlt(K_0),
			K_mPlus        = iup_XkeyAlt(K_plus        ),
			K_mComma       = iup_XkeyAlt(K_comma       ),
			K_mMinus       = iup_XkeyAlt(K_minus       ),
			K_mPeriod      = iup_XkeyAlt(K_period      ),
			K_mSlash       = iup_XkeyAlt(K_slash       ),
			K_mSemicolon   = iup_XkeyAlt(K_semicolon   ),
			K_mEqual       = iup_XkeyAlt(K_equal       ),
			K_mBracketleft = iup_XkeyAlt(K_bracketleft ),
			K_mBracketright= iup_XkeyAlt(K_bracketright),
			K_mBackslash   = iup_XkeyAlt(K_backslash   ),
			K_mAsterisk    = iup_XkeyAlt(K_asterisk    ),

			K_yA    = iup_XkeySys(K_A),
			K_yB    = iup_XkeySys(K_B),
			K_yC    = iup_XkeySys(K_C),
			K_yD    = iup_XkeySys(K_D),
			K_yE    = iup_XkeySys(K_E),
			K_yF    = iup_XkeySys(K_F),
			K_yG    = iup_XkeySys(K_G),
			K_yH    = iup_XkeySys(K_H),
			K_yI    = iup_XkeySys(K_I),
			K_yJ    = iup_XkeySys(K_J),
			K_yK    = iup_XkeySys(K_K),
			K_yL    = iup_XkeySys(K_L),
			K_yM    = iup_XkeySys(K_M),
			K_yN    = iup_XkeySys(K_N),
			K_yO    = iup_XkeySys(K_O),
			K_yP    = iup_XkeySys(K_P),
			K_yQ    = iup_XkeySys(K_Q),
			K_yR    = iup_XkeySys(K_R),
			K_yS    = iup_XkeySys(K_S),
			K_yT    = iup_XkeySys(K_T),
			K_yU    = iup_XkeySys(K_U),
			K_yV    = iup_XkeySys(K_V),
			K_yW    = iup_XkeySys(K_W),
			K_yX    = iup_XkeySys(K_X),
			K_yY    = iup_XkeySys(K_Y),
			K_yZ    = iup_XkeySys(K_Z),
			K_y1    = iup_XkeySys(K_1),
			K_y2    = iup_XkeySys(K_2),
			K_y3    = iup_XkeySys(K_3),
			K_y4    = iup_XkeySys(K_4),
			K_y5    = iup_XkeySys(K_5),
			K_y6    = iup_XkeySys(K_6),
			K_y7    = iup_XkeySys(K_7),
			K_y8    = iup_XkeySys(K_8),
			K_y9    = iup_XkeySys(K_9),
			K_y0    = iup_XkeySys(K_0),
			K_yPlus        = iup_XkeySys(K_plus        ),
			K_yComma       = iup_XkeySys(K_comma       ),
			K_yMinus       = iup_XkeySys(K_minus       ),
			K_yPeriod      = iup_XkeySys(K_period      ),
			K_ySlash       = iup_XkeySys(K_slash       ),
			K_ySemicolon   = iup_XkeySys(K_semicolon   ),
			K_yEqual       = iup_XkeySys(K_equal       ),
			K_yBracketleft = iup_XkeySys(K_bracketleft ),
			K_yBracketright= iup_XkeySys(K_bracketright),
			K_yBackslash   = iup_XkeySys(K_backslash   ),
			K_yAsterisk    = iup_XkeySys(K_asterisk    ),
}

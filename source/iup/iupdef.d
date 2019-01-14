/** \file
 * \brief Callbacks, Attributes and Attribute Values definitions.
 * Avoid using these definitions. Use the strings instead.
 *
 * See Copyright Notice in iup.h
 */

module iup.iupdef;

/* ATTENTION: these are OLD definitions and they are NOT updated anymore since IUP 3.0 */
/* Avoid using them, directly use the strings instead. */

enum IUP_RUN =            "RUN";
enum IUP_ENGLISH =        "ENGLISH";
enum IUP_PORTUGUESE =     "PORTUGUESE";
enum IUP_SBH =            "SBH";
enum IUP_SBV =            "SBV";

/************************************************************************/
/*                            Callbacks                                 */
/************************************************************************/

enum IUP_IDLE_ACTION =    "IDLE_ACTION";

enum IUP_ACTION =         "ACTION";
enum IUP_GETFOCUS_CB =    "GETFOCUS_CB";
enum IUP_KILLFOCUS_CB =   "KILLFOCUS_CB";
enum IUP_K_ANY =          "K_ANY";
enum IUP_KEYPRESS_CB =    "KEYPRESS_CB";
enum IUP_HELP_CB =        "HELP_CB";

enum IUP_SCROLL_CB =      "SCROLL_CB";
enum IUP_RESIZE_CB =      "RESIZE_CB";
enum IUP_MOTION_CB =      "MOTION_CB";
enum IUP_BUTTON_CB =      "BUTTON_CB";
enum IUP_ENTERWINDOW_CB = "ENTERWINDOW_CB";
enum IUP_LEAVEWINDOW_CB = "LEAVEWINDOW_CB";
enum IUP_WHEEL_CB =       "WHEEL_CB";

enum IUP_MASK_CB =        "MASK_CB";
enum IUP_OPEN_CB =        "OPEN_CB";
enum IUP_HIGHLIGHT_CB =   "HIGHLIGHT_CB";
enum IUP_MENUCLOSE_CB =   "MENUCLOSE_CB";

enum IUP_MAP_CB =         "MAP_CB";
enum IUP_CLOSE_CB =       "CLOSE_CB";
enum IUP_SHOW_CB =        "SHOW_CB";

enum IUP_DROPFILES_CB =   "DROPFILES_CB";
enum IUP_WOM_CB =         "WOM_CB";

/************************************************************************/
/*                            Attributes                                */
/************************************************************************/

enum IUP_DIRECTION =      "DIRECTION";
enum IUP_ACTIVE =         "ACTIVE";
enum IUP_BGCOLOR =        "BGCOLOR";
enum IUP_FRAMECOLOR =     "FRAMECOLOR";
enum IUP_FGCOLOR =        "FGCOLOR";
enum IUP_COLOR =          "COLOR";
enum IUP_WID =            "WID";
enum IUP_SIZE =           "SIZE";
enum IUP_RASTERSIZE =     "RASTERSIZE";
enum IUP_TITLE =          "TITLE";
enum IUP_VALUE =          "VALUE";
enum IUP_VISIBLE =        "VISIBLE";
enum IUP_FONT =           "FONT";
enum IUP_TIP =            "TIP";
enum IUP_EXPAND =         "EXPAND";
enum IUP_SEPARATOR =      "SEPARATOR";

enum IUP_HOTSPOT =        "HOTSPOT";
enum IUP_HEIGHT =         "HEIGHT";
enum IUP_WIDTH =          "WIDTH";

enum IUP_KEY =            "KEY";

enum IUP_MULTIPLE =       "MULTIPLE";
enum IUP_DROPDOWN =       "DROPDOWN";
enum IUP_VISIBLE_ITEMS =  "VISIBLE_ITEMS";

enum IUP_MARGIN =         "MARGIN";
enum IUP_GAP =            "GAP";
enum IUP_ALIGNMENT =      "ALIGNMENT";

enum IUP_IMAGE =          "IMAGE";
enum IUP_IMINACTIVE =     "IMINACTIVE";
enum IUP_IMPRESS =        "IMPRESS";
enum IUP_WIN_SAVEBITS =   "WIN_SAVEBITS";

enum IUP_NC =             "NC";
enum IUP_MASK =           "MASK";

enum IUP_APPEND =         "APPEND";
enum IUP_BORDER =         "BORDER";

enum IUP_CARET =          "CARET";
enum IUP_SELECTION =      "SELECTION";
enum IUP_SELECTEDTEXT =   "SELECTEDTEXT";
enum IUP_INSERT =         "INSERT";

enum IUP_CONID =          "CONID";
enum IUP_CURSOR =         "CURSOR";

enum IUP_ICON =           "ICON";
enum IUP_MENUBOX =        "MENUBOX";
enum IUP_MINBOX =         "MINBOX";
enum IUP_MAXBOX =         "MAXBOX";
enum IUP_RESIZE =         "RESIZE";
enum IUP_MENU =           "MENU";
enum IUP_STARTFOCUS =     "STARTFOCUS";
enum IUP_PARENTDIALOG =   "PARENTDIALOG";
enum IUP_SHRINK =         "SHRINK";
enum IUP_DEFAULTENTER =   "DEFAULTENTER";
enum IUP_DEFAULTESC =     "DEFAULTESC";
enum IUP_X =              "X";
enum IUP_Y =              "Y";
enum IUP_TOOLBOX =        "TOOLBOX";
enum IUP_CONTROL =        "CONTROL";
enum IUP_READONLY =       "READONLY";

enum IUP_SCROLLBAR =      "SCROLLBAR";
enum IUP_POSY =           "POSY";
enum IUP_POSX =           "POSX";
enum IUP_DX =             "DX";
enum IUP_DY =             "DY";
enum IUP_XMAX =           "XMAX";
enum IUP_XMIN =           "XMIN";
enum IUP_YMAX =           "YMAX";
enum IUP_YMIN =           "YMIN";

enum IUP_RED =            "255 0 0";
enum IUP_GREEN =          "0 255 0";
enum IUP_BLUE =           "0 0 255";

enum IUP_MIN =            "MIN";
enum IUP_MAX =            "MAX";

enum IUP_TIME =           "TIME";
enum IUP_DRAG =           "DRAG";
enum IUP_DROP =           "DROP";
enum IUP_REPAINT =        "REPAINT";
enum IUP_TOPMOST =        "TOPMOST";
enum IUP_CLIPCHILDREN =   "CLIPCHILDREN";

enum IUP_DIALOGTYPE =     "DIALOGTYPE";
enum IUP_FILE =           "FILE";
enum IUP_MULTIPLEFILES =  "MULTIPLEFILES";
enum IUP_FILTER =         "FILTER";
enum IUP_FILTERUSED =     "FILTERUSED";
enum IUP_FILTERINFO =     "FILTERINFO";
enum IUP_EXTFILTER =      "EXTFILTER";
enum IUP_DIRECTORY =      "DIRECTORY";
enum IUP_ALLOWNEW =       "ALLOWNEW";
enum IUP_NOOVERWRITEPROMPT = "NOOVERWRITEPROMPT";
enum IUP_NOCHANGEDIR =    "NOCHANGEDIR";
enum IUP_FILEEXIST =      "FILEEXIST";
enum IUP_STATUS =         "STATUS";

enum IUP_LOCKLOOP =       "LOCKLOOP";
enum IUP_SYSTEM =         "SYSTEM";
enum IUP_DRIVER =         "DRIVER";
enum IUP_SCREENSIZE =     "SCREENSIZE";
enum IUP_SYSTEMLANGUAGE = "SYSTEMLANGUAGE";
enum IUP_COMPUTERNAME =   "COMPUTERNAME";
enum IUP_USERNAME =       "USERNAME";

enum IUP_OPEN = "OPEN";
enum IUP_SAVE = "SAVE";
enum IUP_DIR =  "DIR";

enum IUP_HORIZONTAL =     "HORIZONTAL";
enum IUP_VERTICAL =       "VERTICAL";

/************************************************************************/
/*                       Attribute Values                               */
/************************************************************************/

enum IUP_YES =       "YES";
enum IUP_NO =        "NO";
enum IUP_ON =        "ON";
enum IUP_OFF =       "OFF";

enum IUP_ACENTER =   "ACENTER";
enum IUP_ALEFT =     "ALEFT";
enum IUP_ARIGHT =    "ARIGHT";
enum IUP_ATOP =      "ATOP";
enum IUP_ABOTTOM =   "ABOTTOM";

enum IUP_NORTH =     "NORTH";
enum IUP_SOUTH =     "SOUTH";
enum IUP_WEST =      "WEST";
enum IUP_EAST =      "EAST";
enum IUP_NE =        "NE";
enum IUP_SE =        "SE";
enum IUP_NW =        "NW";
enum IUP_SW =        "SW";

enum IUP_FULLSCREEN = "FULLSCREEN";
enum IUP_FULL =      "FULL";
enum IUP_HALF =      "HALF";
enum IUP_THIRD =     "THIRD";
enum IUP_QUARTER =   "QUARTER";
enum IUP_EIGHTH =    "EIGHTH";

enum IUP_ARROW =     "ARROW";
enum IUP_BUSY =      "BUSY";
enum IUP_RESIZE_N =  "RESIZE_N";
enum IUP_RESIZE_S =  "RESIZE_S";
enum IUP_RESIZE_E =  "RESIZE_E";
enum IUP_RESIZE_W =  "RESIZE_W";
enum IUP_RESIZE_NE = "RESIZE_NE";
enum IUP_RESIZE_NW = "RESIZE_NW";
enum IUP_RESIZE_SE = "RESIZE_SE";
enum IUP_RESIZE_SW = "RESIZE_SW";
enum IUP_MOVE =      "MOVE";
enum IUP_HAND =      "HAND";
enum IUP_NONE =      "NONE";
enum IUP_IUP =       "IUP";
enum IUP_CROSS =     "CROSS";
enum IUP_PEN =       "PEN";
enum IUP_TEXT =      "TEXT";
enum IUP_RESIZE_C =  "RESIZE_C";
enum IUP_OPENHAND =  "OPENHAND";

/************************************************************************/
/*                           Keys                                       */
/************************************************************************/

enum IUP_K_exclam            = "K_exclam";
enum IUP_K_quotedbl          = "K_quotedbl";
enum IUP_K_numbersign        = "K_numbersign";
enum IUP_K_dollar            = "K_dollar";
enum IUP_K_percent           = "K_percent";
enum IUP_K_ampersand         = "K_ampersand";
enum IUP_K_quoteright        = "K_quoteright";
enum IUP_K_parentleft        = "K_parentleft";
enum IUP_K_parentright       = "K_parentright";
enum IUP_K_asterisk          = "K_asterisk";
enum IUP_K_plus              = "K_plus";
enum IUP_K_comma             = "K_comma";
enum IUP_K_minus             = "K_minus";
enum IUP_K_period            = "K_period";
enum IUP_K_slash             = "K_slash";
enum IUP_K_0                 = "K_0";
enum IUP_K_1                 = "K_1";
enum IUP_K_2                 = "K_2";
enum IUP_K_3                 = "K_3";
enum IUP_K_4                 = "K_4";
enum IUP_K_5                 = "K_5";
enum IUP_K_6                 = "K_6";
enum IUP_K_7                 = "K_7";
enum IUP_K_8                 = "K_8";
enum IUP_K_9                 = "K_9";
enum IUP_K_colon             = "K_colon";
enum IUP_K_semicolon         = "K_semicolon ";
enum IUP_K_less              = "K_less";
enum IUP_K_equal             = "K_equal";
enum IUP_K_greater           = "K_greater";
enum IUP_K_question          = "K_question";
enum IUP_K_at                = "K_at";
enum IUP_K_A                 = "K_A";
enum IUP_K_B                 = "K_B";
enum IUP_K_C                 = "K_C";
enum IUP_K_D                 = "K_D";
enum IUP_K_E                 = "K_E";
enum IUP_K_F                 = "K_F";
enum IUP_K_G                 = "K_G";
enum IUP_K_H                 = "K_H";
enum IUP_K_I                 = "K_I";
enum IUP_K_J                 = "K_J";
enum IUP_K_K                 = "K_K";
enum IUP_K_L                 = "K_L";
enum IUP_K_M                 = "K_M";
enum IUP_K_N                 = "K_N";
enum IUP_K_O                 = "K_O";
enum IUP_K_P                 = "K_P";
enum IUP_K_Q                 = "K_Q";
enum IUP_K_R                 = "K_R";
enum IUP_K_S                 = "K_S";
enum IUP_K_T                 = "K_T";
enum IUP_K_U                 = "K_U";
enum IUP_K_V                 = "K_V";
enum IUP_K_W                 = "K_W";
enum IUP_K_X                 = "K_X";
enum IUP_K_Y                 = "K_Y";
enum IUP_K_Z                 = "K_Z";
enum IUP_K_bracketleft       = "K_bracketleft";
enum IUP_K_backslash         = "K_backslash";
enum IUP_K_bracketright      = "K_bracketright";
enum IUP_K_circum            = "K_circum";
enum IUP_K_underscore        = "K_underscore";
enum IUP_K_quoteleft         = "K_quoteleft";
enum IUP_K_a                 = "K_a";
enum IUP_K_b                 = "K_b";
enum IUP_K_c                 = "K_c";
enum IUP_K_d                 = "K_d";
enum IUP_K_e                 = "K_e";
enum IUP_K_f                 = "K_f";
enum IUP_K_g                 = "K_g";
enum IUP_K_h                 = "K_h";
enum IUP_K_i                 = "K_i";
enum IUP_K_j                 = "K_j";
enum IUP_K_k                 = "K_k";
enum IUP_K_l                 = "K_l";
enum IUP_K_m                 = "K_m";
enum IUP_K_n                 = "K_n";
enum IUP_K_o                 = "K_o";
enum IUP_K_p                 = "K_p";
enum IUP_K_q                 = "K_q";
enum IUP_K_r                 = "K_r";
enum IUP_K_s                 = "K_s";
enum IUP_K_t                 = "K_t";
enum IUP_K_u                 = "K_u";
enum IUP_K_v                 = "K_v";
enum IUP_K_w                 = "K_w";
enum IUP_K_x                 = "K_x";
enum IUP_K_y                 = "K_y";
enum IUP_K_z                 = "K_z";
enum IUP_K_braceleft         = "K_braceleft";
enum IUP_K_bar               = "K_bar";
enum IUP_K_braceright        = "K_braceright";
enum IUP_K_tilde             = "K_tilde";

enum IUP_K_cA       = "K_cA";
enum IUP_K_cB       = "K_cB";
enum IUP_K_cC       = "K_cC";
enum IUP_K_cD       = "K_cD";
enum IUP_K_cE       = "K_cE";
enum IUP_K_cF       = "K_cF";
enum IUP_K_cG       = "K_cG";
enum IUP_K_cJ       = "K_cJ";
enum IUP_K_cK       = "K_cK";
enum IUP_K_cL       = "K_cL";
enum IUP_K_cN       = "K_cN";
enum IUP_K_cO       = "K_cO";
enum IUP_K_cP       = "K_cP";
enum IUP_K_cQ       = "K_cQ";
enum IUP_K_cR       = "K_cR";
enum IUP_K_cS       = "K_cS";
enum IUP_K_cT       = "K_cT";
enum IUP_K_cU       = "K_cU";
enum IUP_K_cV       = "K_cV";
enum IUP_K_cW       = "K_cW";
enum IUP_K_cX       = "K_cX";
enum IUP_K_cY       = "K_cY";
enum IUP_K_cZ       = "K_cZ";
enum IUP_K_mA       = "K_mA";
enum IUP_K_mB       = "K_mB";
enum IUP_K_mC       = "K_mC";
enum IUP_K_mD       = "K_mD";
enum IUP_K_mE       = "K_mE";
enum IUP_K_mF       = "K_mF";
enum IUP_K_mG       = "K_mG";
enum IUP_K_mH       = "K_mH";
enum IUP_K_mI       = "K_mI";
enum IUP_K_mJ       = "K_mJ";
enum IUP_K_mK       = "K_mK";
enum IUP_K_mL       = "K_mL";
enum IUP_K_mM       = "K_mM";
enum IUP_K_mN       = "K_mN";
enum IUP_K_mO       = "K_mO";
enum IUP_K_mP       = "K_mP";
enum IUP_K_mQ       = "K_mQ";
enum IUP_K_mR       = "K_mR";
enum IUP_K_mS       = "K_mS";
enum IUP_K_mT       = "K_mT";
enum IUP_K_mU       = "K_mU";
enum IUP_K_mV       = "K_mV";
enum IUP_K_mW       = "K_mW";
enum IUP_K_mX       = "K_mX";
enum IUP_K_mY       = "K_mY";
enum IUP_K_mZ       = "K_mZ";
enum IUP_K_BS       = "K_BS";
enum IUP_K_TAB      = "K_TAB";
enum IUP_K_CR       = "K_CR";
enum IUP_K_SP       = "K_SP";
enum IUP_K_ESC      = "K_ESC";
enum IUP_K_sCR      = "K_sCR";
enum IUP_K_sTAB     = "K_sTAB";
enum IUP_K_cTAB     = "K_cTAB";
enum IUP_K_mTAB     = "K_mTAB";
enum IUP_K_HOME     = "K_HOME";
enum IUP_K_UP       = "K_UP";
enum IUP_K_PGUP     = "K_PGUP";
enum IUP_K_LEFT     = "K_LEFT";
enum IUP_K_RIGHT    = "K_RIGHT";
enum IUP_K_END      = "K_END";
enum IUP_K_DOWN     = "K_DOWN";
enum IUP_K_PGDN     = "K_PGDN";
enum IUP_K_MIDDLE   = "K_MIDDLE";
enum IUP_K_INS      = "K_INS";
enum IUP_K_DEL      = "K_DEL";
enum IUP_K_sHOME    = "K_sHOME";
enum IUP_K_sUP      = "K_sUP";
enum IUP_K_sPGUP    = "K_sPGUP";
enum IUP_K_sLEFT    = "K_sLEFT";
enum IUP_K_sRIGHT   = "K_sRIGHT";
enum IUP_K_sEND     = "K_sEND";
enum IUP_K_sDOWN    = "K_sDOWN";
enum IUP_K_sPGDN    = "K_sPGDN";
enum IUP_K_cHOME    = "K_cHOME";
enum IUP_K_cPGUP    = "K_cPGUP";
enum IUP_K_cLEFT    = "K_cLEFT";
enum IUP_K_cRIGHT   = "K_cRIGHT";
enum IUP_K_cEND     = "K_cEND";
enum IUP_K_cPGDN    = "K_cPGDN";
enum IUP_K_cUP      = "K_cUP";
enum IUP_K_cDOWN    = "K_cDOWN";
enum IUP_K_cMIDDLE  = "K_cMIDDLE";
enum IUP_K_cINS     = "K_cINS";
enum IUP_K_cDEL     = "K_cDEL";
enum IUP_K_mHOME    = "K_mHOME";
enum IUP_K_mPGUP    = "K_mPGUP";
enum IUP_K_mLEFT    = "K_mLEFT";
enum IUP_K_mRIGHT   = "K_mRIGHT";
enum IUP_K_mEND     = "K_mEND";
enum IUP_K_mPGDN    = "K_mPGDN";
enum IUP_K_mUP      = "K_mUP";
enum IUP_K_mDOWN    = "K_mDOWN";
enum IUP_K_mINS     = "K_mINS";
enum IUP_K_mDEL     = "K_mDEL";
enum IUP_K_F1       = "K_F1";
enum IUP_K_F2       = "K_F2";
enum IUP_K_F3       = "K_F3";
enum IUP_K_F4       = "K_F4";
enum IUP_K_F5       = "K_F5";
enum IUP_K_F6       = "K_F6";
enum IUP_K_F7       = "K_F7";
enum IUP_K_F8       = "K_F8";
enum IUP_K_F9       = "K_F9";
enum IUP_K_F10      = "K_F10";
enum IUP_K_F11      = "K_F11";
enum IUP_K_F12      = "K_F12";
enum IUP_K_sF1      = "K_sF1";
enum IUP_K_sF2      = "K_sF2";
enum IUP_K_sF3      = "K_sF3";
enum IUP_K_sF4      = "K_sF4";
enum IUP_K_sF5      = "K_sF5";
enum IUP_K_sF6      = "K_sF6";
enum IUP_K_sF7      = "K_sF7";
enum IUP_K_sF8      = "K_sF8";
enum IUP_K_sF9      = "K_sF9";
enum IUP_K_sF10     = "K_sF10";
enum IUP_K_sF11     = "K_sF11";
enum IUP_K_sF12     = "K_sF12";
enum IUP_K_cF1      = "K_cF1";
enum IUP_K_cF2      = "K_cF2";
enum IUP_K_cF3      = "K_cF3";
enum IUP_K_cF4      = "K_cF4";
enum IUP_K_cF5      = "K_cF5";
enum IUP_K_cF6      = "K_cF6";
enum IUP_K_cF7      = "K_cF7";
enum IUP_K_cF8      = "K_cF8";
enum IUP_K_cF9      = "K_cF9";
enum IUP_K_cF10     = "K_cF10";
enum IUP_K_cF11     = "K_cF11";
enum IUP_K_cF12     = "K_cF12";
enum IUP_K_mF1      = "K_mF1";
enum IUP_K_mF2      = "K_mF2";
enum IUP_K_mF3      = "K_mF3";
enum IUP_K_mF4      = "K_mF4";
enum IUP_K_mF5      = "K_mF5";
enum IUP_K_mF6      = "K_mF6";
enum IUP_K_mF7      = "K_mF7";
enum IUP_K_mF8      = "K_mF8";
enum IUP_K_mF9      = "K_mF9";
enum IUP_K_mF10     = "K_mF10";
enum IUP_K_m1       = "K_m1";
enum IUP_K_m2       = "K_m2";
enum IUP_K_m3       = "K_m3";
enum IUP_K_m4       = "K_m4";
enum IUP_K_m5       = "K_m5";
enum IUP_K_m6       = "K_m6";
enum IUP_K_m7       = "K_m7";
enum IUP_K_m8       = "K_m8";
enum IUP_K_m9       = "K_m9";
enum IUP_K_m0       = "K_m0";

/************/
/* Colorbar */
/************/

enum IUP_NUM_PARTS  = "NUM_PARTS";
enum IUP_NUM_CELLS  = "NUM_CELLS";
enum IUP_CELL = "CELL";
enum IUP_PREVIEW_SIZE = "PREVIEW_SIZE";
enum IUP_SHOW_PREVIEW = "SHOW_PREVIEW";
enum IUP_SHOW_SECONDARY = "SHOW_SECONDARY";
enum IUP_PRIMARY_CELL = "PRIMARY_CELL";
enum IUP_SECONDARY_CELL = "SECONDARY_CELL";
enum IUP_ORIENTATION  = "ORIENTATION";
enum IUP_SQUARED  = "SQUARED";
enum IUP_SHADOWED  = "SHADOWED";
enum IUP_BUFFERIZE  = "BUFFERIZE";
enum IUP_TRANSPARENCY  = "TRANSPARENCY";
enum IUP_CELL_CB = "CELL_CB";
enum IUP_EXTENDED_CB = "EXTENDED_CB";
enum IUP_SELECT_CB = "SELECT_CB";
enum IUP_SWITCH_CB = "SWITCH_CB";
//enum IUP_VERTICAL    = "VERTICAL";
//enum IUP_HORIZONTAL  = "HORIZONTAL";

/************/
/* Cells    */
/************/

enum IUP_ALL  = "ALL";
enum IUP_BOXED  = "BOXED";
enum IUP_CLIPPED  = "CLIPPED";
enum IUP_TRANSPARENT  = "TRANSPARENT";
enum IUP_NON_SCROLLABLE_LINES  = "NON_SCROLLABLE_LINES";
enum IUP_NON_SCROLLABLE_COLS  = "NON_SCROLLABLE_COLS";
enum IUP_ORIGIN  = "ORIGIN";
enum IUP_NO_COLOR  = "NO_COLOR";
enum IUP_FIRST_LINE  = "FIRST_LINE";
enum IUP_FIRST_COL  = "FIRST_COL";
enum IUP_DOUBLE_BUFFER  = "DOUBLE_BUFFER";
enum IUP_LIMITS  = "LIMITS";
enum IUP_CANVAS  = "CANVAS";
enum IUP_IMAGE_CANVAS  = "IMAGE_CANVAS";
enum IUP_FULL_VISIBLE  = "FULL_VISIBLE";
enum IUP_MOUSECLICK_CB = "MOUSECLICK_CB";
enum IUP_MOUSEMOTION_CB = "MOUSEMOTION_CB";
enum IUP_DRAW_CB = "DRAW_CB";
enum IUP_WIDTH_CB = "WIDTH_CB";
enum IUP_HEIGHT_CB = "HEIGHT_CB";
enum IUP_NLINES_CB = "NLINES_CB";
enum IUP_NCOLS_CB = "NCOLS_CB";
enum IUP_HSPAN_CB = "HSPAN_CB";
enum IUP_VSPAN_CB = "VSPAN_CB";
enum IUP_SCROLLING_CB = "SCROLLING_CB";

/*****************/
/* ColorBrowser  */
/*****************/

enum IUP_RGB = "RGB";
enum IUP_CHANGE_CB = "CHANGE_CB";
enum IUP_DRAG_CB = "DRAG_CB";

/*****************/
/* Val           */
/*****************/

enum ICTL_MOUSEMOVE_CB = "MOUSEMOVE_CB";
enum ICTL_BUTTON_PRESS_CB = "BUTTON_PRESS_CB";
enum ICTL_BUTTON_RELEASE_CB = "BUTTON_RELEASE_CB";
enum ICTL_HORIZONTAL = "HORIZONTAL";
enum ICTL_VERTICAL = "VERTICAL";
enum ICTL_SHOWTICKS = "SHOWTICKS";

/*****************/
/* Tabs          */
/*****************/

enum ICTL_TOP = "TOP";
enum ICTL_BOTTOM = "BOTTOM";
enum ICTL_LEFT = "LEFT";
enum ICTL_RIGHT = "RIGHT";
enum ICTL_TABTYPE = "TABTYPE";
enum ICTL_TABTITLE = "TABTITLE";
enum ICTL_TABSIZE = "TABSIZE";
enum ICTL_TABCHANGE_CB = "TABCHANGE_CB";
enum ICTL_FONT = "FONT";
enum ICTL_FONT_ACTIVE = "FONT_ACTIVE";
enum ICTL_FONT_INACTIVE = "FONT_INACTIVE";

/*****************/
/* Gauge         */
/*****************/

enum ICTL_SHOW_TEXT = "SHOW_TEXT";
enum ICTL_DASHED = "DASHED";
enum ICTL_MARGIN = "MARGIN";
enum ICTL_TEXT = "TEXT";

/*****************/
/* Dial          */
/*****************/

enum ICTL_DENSITY = "DENSITY";
//enum ICTL_HORIZONTAL = "HORIZONTAL";
//enum ICTL_VERTICAL = "VERTICAL";
enum ICTL_CIRCULAR = "CIRCULAR";
enum ICTL_UNIT = "UNIT";

/*****************/
/* Matrix        */
/*****************/

enum IUP_ENTERITEM_CB   = "ENTERITEM_CB";
enum IUP_LEAVEITEM_CB   = "LEAVEITEM_CB";
enum IUP_EDITION_CB     = "EDITION_CB";
enum IUP_CLICK_CB       = "CLICK_CB";
enum IUP_DROP_CB        = "DROP_CB";
enum IUP_DROPSELECT_CB  = "DROPSELECT_CB";
enum IUP_DROPCHECK_CB   = "DROPCHECK_CB";
//enum IUP_SCROLL_CB      = "SCROLL_CB";
enum IUP_VALUE_CB       = "VALUE_CB";
enum IUP_VALUE_EDIT_CB  = "VALUE_EDIT_CB";
enum IUP_FIELD_CB       = "FIELD_CB";
enum IUP_RESIZEMATRIX   = "RESIZEMATRIX";
enum IUP_ADDLIN         = "ADDLIN";
enum IUP_ADDCOL         = "ADDCOL";
enum IUP_DELLIN         = "DELLIN";
enum IUP_DELCOL         = "DELCOL";
enum IUP_NUMLIN         = "NUMLIN";
enum IUP_NUMCOL         = "NUMCOL";
enum IUP_NUMLIN_VISIBLE = "NUMLIN_VISIBLE";
enum IUP_NUMCOL_VISIBLE = "NUMCOL_VISIBLE";
enum IUP_MARKED         = "MARKED";
enum IUP_WIDTHDEF       = "WIDTHDEF";
enum IUP_HEIGHTDEF      = "HEIGHTDEF";
enum IUP_AREA           = "AREA";
enum IUP_MARK_MODE      = "MARK_MODE";
enum IUP_LIN            = "LIN";
enum IUP_COL            = "COL";
enum IUP_LINCOL         = "LINCOL";
//enum IUP_CELL           = "CELL";
enum IUP_EDIT_MODE      = "EDIT_MODE";
enum IUP_FOCUS_CELL     = "FOCUS_CELL";
//enum IUP_ORIGIN         = "ORIGIN";
enum IUP_REDRAW         = "REDRAW";
enum IUP_PREVIOUSVALUE  = "PREVIOUSVALUE";
enum IUP_MOUSEMOVE_CB   = "MOUSEMOVE_CB";

/*****************/
/* Tree          */
/*****************/

enum IUP_ADDLEAF          = "ADDLEAF";
enum IUP_ADDBRANCH        = "ADDBRANCH";
enum IUP_DELNODE          = "DELNODE";
enum IUP_IMAGELEAF        = "IMAGELEAF";
enum IUP_IMAGEBRANCHCOLLAPSED = "IMAGEBRANCHCOLLAPSED";
enum IUP_IMAGEBRANCHEXPANDED  = "IMAGEBRANCHEXPANDED";
enum IUP_IMAGEEXPANDED    = "IMAGEEXPANDED";
enum IUP_KIND             = "KIND";
enum IUP_PARENT           = "PARENT";
enum IUP_DEPTH            = "DEPTH";
//enum IUP_MARKED           = "MARKED";
enum IUP_ADDEXPANDED      = "ADDEXPANDED";
enum IUP_CTRL             = "CTRL";
enum IUP_SHIFT            = "SHIFT";
enum IUP_STATE            = "STATE";
enum IUP_STARTING         = "STARTING";
enum IUP_LEAF             = "LEAF";
enum IUP_BRANCH           = "BRANCH";
enum IUP_SELECTED         = "SELECTED";
enum IUP_CHILDREN         = "CHILDREN";
//enum IUP_MARKED           = "MARKED";
enum IUP_ROOT             = "ROOT";
enum IUP_LAST             = "LAST";
enum IUP_PGUP             = "PGUP";
enum IUP_PGDN             = "PGDN";
enum IUP_NEXT             = "NEXT";
enum IUP_PREVIOUS         = "PREVIOUS";
enum IUP_INVERT           = "INVERT";
enum IUP_BLOCK            = "BLOCK";
enum IUP_CLEARALL         = "CLEARALL";
enum IUP_MARKALL          = "MARKALL";
enum IUP_INVERTALL        = "INVERTALL";
//enum IUP_REDRAW           = "REDRAW";
enum IUP_COLLAPSED        = "COLLAPSED";
enum IUP_EXPANDED         = "EXPANDED";
enum IUP_SELECTION_CB     = "SELECTION_CB";
enum IUP_BRANCHOPEN_CB    = "BRANCHOPEN_CB";
enum IUP_BRANCHCLOSE_CB   = "BRANCHCLOSE_CB";
enum IUP_RIGHTCLICK_CB    = "RIGHTCLICK_CB";
enum IUP_EXECUTELEAF_CB   = "EXECUTELEAF_CB";
enum IUP_RENAMENODE_CB    = "RENAMENODE_CB";
enum IUP_IMGLEAF          = "IMGLEAF";
enum IUP_IMGCOLLAPSED     = "IMGCOLLAPSED";
enum IUP_IMGEXPANDED      = "IMGEXPANDED";
enum IUP_IMGBLANK         = "IMGBLANK";
enum IUP_IMGPAPER         = "IMGPAPER";

// bindings additions
enum IUP_TOGGLECENTERED   = "TOGGLECENTERED";
enum IUP_MULTILINE        = "MULTILINE";
enum IUP_VISIBLELINES     = "VISIBLELINES";
enum IUP_WORDWRAP         = "WORDWRAP";
enum IUP_VISIBLEITEMS     = "VISIBLEITEMS"; // IupList: VISIBLE_ITEMS renamed to VISIBLEITEMS in IupList. Old names still supported
enum IUP_VALUECHANGED_CB  = "VALUECHANGED_CB";
enum IUP_TOGGLEVALUE_CB   = "TOGGLEVALUE_CB";
enum IUP_SHOWTOGGLE       = "SHOWTOGGLE";
enum IUP_PADDING          = "PADDING";
enum IUP_REMOVEITEM       = "REMOVEITEM";
enum IUP_APPENDITEM       = "APPENDITEM";
enum IUP_IMGEMPTY         = "IMGEMPTY";

/** \file
 * \brief Callbacks, Attributes and Attribute Values definitions.    
 * Avoid using these definitions. Use the strings instead.
 *
 * See Copyright Notice in iup.h
 */

module iup.iupdef;

/* Deprecated definitions */
/* Avoid using these definitions. Use the strings instead. */
/* Define __IUPDEF_H to avoid the inclusion of this header */
deprecated("Avoid using these definitions. Use the strings instead.")
{

const IUP_RUN =            "RUN";
const IUP_ENGLISH =        "ENGLISH";
const IUP_PORTUGUESE =     "PORTUGUESE";
const IUP_SBH =            "SBH";
const IUP_SBV =            "SBV";

/************************************************************************/
/*                            Callbacks                                 */
/************************************************************************/

const IUP_DEFAULT_ACTION = "DEFAULT_ACTION";
const IUP_IDLE_ACTION =    "IDLE_ACTION";

const IUP_ACTION =         "ACTION";
const IUP_GETFOCUS_CB =    "GETFOCUS_CB";
const IUP_KILLFOCUS_CB =   "KILLFOCUS_CB";
const IUP_K_ANY =          "K_ANY";
const IUP_KEYPRESS_CB =    "KEYPRESS_CB";
const IUP_HELP_CB =        "HELP_CB";

const IUP_SCROLL_CB =      "SCROLL_CB";
const IUP_RESIZE_CB =      "RESIZE_CB";
const IUP_MOTION_CB =      "MOTION_CB";
const IUP_BUTTON_CB =      "BUTTON_CB";
const IUP_ENTERWINDOW_CB = "ENTERWINDOW_CB";
const IUP_LEAVEWINDOW_CB = "LEAVEWINDOW_CB";
const IUP_WHEEL_CB =       "WHEEL_CB";

const IUP_MASK_CB =        "MASK_CB";
const IUP_OPEN_CB =        "OPEN_CB";
const IUP_HIGHLIGHT_CB =   "HIGHLIGHT_CB";
const IUP_MENUCLOSE_CB =   "MENUCLOSE_CB";

const IUP_MAP_CB =         "MAP_CB";
const IUP_CLOSE_CB =       "CLOSE_CB";
const IUP_SHOW_CB =        "SHOW_CB";

const IUP_DROPFILES_CB =   "DROPFILES_CB";
const IUP_WOM_CB =         "WOM_CB";

/************************************************************************/
/*                            Attributes                                */
/************************************************************************/

const IUP_DIRECTION =      "DIRECTION";
const IUP_ACTIVE =         "ACTIVE";
const IUP_BGCOLOR =        "BGCOLOR";
const IUP_FRAMECOLOR =     "FRAMECOLOR";
const IUP_FGCOLOR =        "FGCOLOR";
const IUP_COLOR =          "COLOR";
const IUP_WID =            "WID";
const IUP_SIZE =           "SIZE";
const IUP_RASTERSIZE =     "RASTERSIZE";
const IUP_TITLE =          "TITLE";
const IUP_VALUE =          "VALUE";
const IUP_VISIBLE =        "VISIBLE";
const IUP_FONT =           "FONT";
const IUP_TIP =            "TIP";
const IUP_EXPAND =         "EXPAND";
const IUP_SEPARATOR =      "SEPARATOR";

const IUP_HOTSPOT =        "HOTSPOT";
const IUP_HEIGHT =         "HEIGHT";
const IUP_WIDTH =          "WIDTH";

const IUP_KEY =            "KEY";

const IUP_MULTIPLE =       "MULTIPLE";
const IUP_DROPDOWN =       "DROPDOWN";
const IUP_VISIBLE_ITEMS =  "VISIBLE_ITEMS";

const IUP_MARGIN =         "MARGIN";
const IUP_GAP =            "GAP";
const IUP_ALIGNMENT =      "ALIGNMENT";

const IUP_IMAGE =          "IMAGE";
const IUP_IMINACTIVE =     "IMINACTIVE";
const IUP_IMPRESS =        "IMPRESS";
const IUP_WIN_SAVEBITS =   "WIN_SAVEBITS";

const IUP_NC =             "NC";
const IUP_MASK =           "MASK";

const IUP_APPEND =         "APPEND";
const IUP_BORDER =         "BORDER";

const IUP_CARET =          "CARET";
const IUP_SELECTION =      "SELECTION";
const IUP_SELECTEDTEXT =   "SELECTEDTEXT";
const IUP_INSERT =         "INSERT";

const IUP_CONID =          "CONID";
const IUP_CURSOR =         "CURSOR";

const IUP_ICON =           "ICON";
const IUP_MENUBOX =        "MENUBOX";
const IUP_MINBOX =         "MINBOX";
const IUP_MAXBOX =         "MAXBOX";
const IUP_RESIZE =         "RESIZE";
const IUP_MENU =           "MENU";
const IUP_STARTFOCUS =     "STARTFOCUS";
const IUP_PARENTDIALOG =   "PARENTDIALOG";
const IUP_SHRINK =         "SHRINK";
const IUP_DEFAULTENTER =   "DEFAULTENTER";
const IUP_DEFAULTESC =     "DEFAULTESC";
const IUP_X =              "X";
const IUP_Y =              "Y";
const IUP_TOOLBOX =        "TOOLBOX";
const IUP_CONTROL =        "CONTROL";
const IUP_READONLY =       "READONLY";

const IUP_SCROLLBAR =      "SCROLLBAR";
const IUP_POSY =           "POSY";
const IUP_POSX =           "POSX";
const IUP_DX =             "DX";
const IUP_DY =             "DY";
const IUP_XMAX =           "XMAX";
const IUP_XMIN =           "XMIN";
const IUP_YMAX =           "YMAX";
const IUP_YMIN =           "YMIN";

const IUP_RED =            "255 0 0";
const IUP_GREEN =          "0 255 0";
const IUP_BLUE =           "0 0 255";

const IUP_MIN =            "MIN";
const IUP_MAX =            "MAX";

const IUP_TIME =           "TIME";
const IUP_DRAG =           "DRAG";
const IUP_DROP =           "DROP";
const IUP_REPAINT =        "REPAINT";
const IUP_TOPMOST =        "TOPMOST";
const IUP_CLIPCHILDREN =   "CLIPCHILDREN";

const IUP_DIALOGTYPE =     "DIALOGTYPE";
const IUP_FILE =           "FILE";
const IUP_MULTIPLEFILES =  "MULTIPLEFILES";
const IUP_FILTER =         "FILTER";
const IUP_FILTERUSED =     "FILTERUSED";
const IUP_FILTERINFO =     "FILTERINFO";
const IUP_EXTFILTER =      "EXTFILTER";
const IUP_DIRECTORY =      "DIRECTORY";
const IUP_ALLOWNEW =       "ALLOWNEW";
const IUP_NOOVERWRITEPROMPT = "NOOVERWRITEPROMPT";
const IUP_NOCHANGEDIR =    "NOCHANGEDIR";
const IUP_FILEEXIST =      "FILEEXIST";
const IUP_STATUS =         "STATUS";

const IUP_LOCKLOOP =       "LOCKLOOP";
const IUP_SYSTEM =         "SYSTEM";
const IUP_DRIVER =         "DRIVER";
const IUP_SCREENSIZE =     "SCREENSIZE";
const IUP_SYSTEMLANGUAGE = "SYSTEMLANGUAGE";
const IUP_COMPUTERNAME =   "COMPUTERNAME";
const IUP_USERNAME =       "USERNAME";

const IUP_OPEN = "OPEN";
const IUP_SAVE = "SAVE";
const IUP_DIR =  "DIR";

const IUP_HORIZONTAL =     "HORIZONTAL";
const IUP_VERTICAL =       "VERTICAL";

/************************************************************************/
/*                       Attribute Values                               */
/************************************************************************/

const IUP_YES =       "YES";
const IUP_NO =        "NO";
const IUP_ON =        "ON";
const IUP_OFF =       "OFF";

const IUP_ACENTER =   "ACENTER";
const IUP_ALEFT =     "ALEFT";
const IUP_ARIGHT =    "ARIGHT";
const IUP_ATOP =      "ATOP";
const IUP_ABOTTOM =   "ABOTTOM";

const IUP_NORTH =     "NORTH";
const IUP_SOUTH =     "SOUTH";
const IUP_WEST =      "WEST";
const IUP_EAST =      "EAST";
const IUP_NE =        "NE";
const IUP_SE =        "SE";
const IUP_NW =        "NW";
const IUP_SW =        "SW";

const IUP_FULLSCREEN = "FULLSCREEN";
const IUP_FULL =      "FULL";
const IUP_HALF =      "HALF";
const IUP_THIRD =     "THIRD";
const IUP_QUARTER =   "QUARTER";
const IUP_EIGHTH =    "EIGHTH";

const IUP_ARROW =     "ARROW";
const IUP_BUSY =      "BUSY";
const IUP_RESIZE_N =  "RESIZE_N";
const IUP_RESIZE_S =  "RESIZE_S";
const IUP_RESIZE_E =  "RESIZE_E";
const IUP_RESIZE_W =  "RESIZE_W";
const IUP_RESIZE_NE = "RESIZE_NE";
const IUP_RESIZE_NW = "RESIZE_NW";
const IUP_RESIZE_SE = "RESIZE_SE";
const IUP_RESIZE_SW = "RESIZE_SW";
const IUP_MOVE =      "MOVE";
const IUP_HAND =      "HAND";
const IUP_NONE =      "NONE";
const IUP_IUP =       "IUP";
const IUP_CROSS =     "CROSS";
const IUP_PEN =       "PEN";
const IUP_TEXT =      "TEXT";
const IUP_RESIZE_C =  "RESIZE_C";
const IUP_OPENHAND =  "OPENHAND";

/*****************/
/* Fonts        */
/*****************/
/+
const IUP_HELVETICA_NORMAL_8   "HELVETICA_NORMAL_8"
const IUP_HELVETICA_ITALIC_8   "HELVETICA_ITALIC_8"
const IUP_HELVETICA_BOLD_8     "HELVETICA_BOLD_8"
const IUP_HELVETICA_NORMAL_10  "HELVETICA_NORMAL_10"
const IUP_HELVETICA_ITALIC_10  "HELVETICA_ITALIC_10"
const IUP_HELVETICA_BOLD_10    "HELVETICA_BOLD_10"
const IUP_HELVETICA_NORMAL_12  "HELVETICA_NORMAL_12"
const IUP_HELVETICA_ITALIC_12  "HELVETICA_ITALIC_12"
const IUP_HELVETICA_BOLD_12    "HELVETICA_BOLD_12"
const IUP_HELVETICA_NORMAL_14  "HELVETICA_NORMAL_14"
const IUP_HELVETICA_ITALIC_14  "HELVETICA_ITALIC_14"
const IUP_HELVETICA_BOLD_14    "HELVETICA_BOLD_14"
const IUP_COURIER_NORMAL_8     "COURIER_NORMAL_8"
const IUP_COURIER_ITALIC_8     "COURIER_ITALIC_8"
const IUP_COURIER_BOLD_8       "COURIER_BOLD_8"
const IUP_COURIER_NORMAL_10    "COURIER_NORMAL_10"
const IUP_COURIER_ITALIC_10    "COURIER_ITALIC_10"
const IUP_COURIER_BOLD_10      "COURIER_BOLD_10"
const IUP_COURIER_NORMAL_12    "COURIER_NORMAL_12"
const IUP_COURIER_ITALIC_12    "COURIER_ITALIC_12"
const IUP_COURIER_BOLD_12      "COURIER_BOLD_12"
const IUP_COURIER_NORMAL_14    "COURIER_NORMAL_14"
const IUP_COURIER_ITALIC_14    "COURIER_ITALIC_14"
const IUP_COURIER_BOLD_14      "COURIER_BOLD_14"
const IUP_TIMES_NORMAL_8       "TIMES_NORMAL_8"
const IUP_TIMES_ITALIC_8       "TIMES_ITALIC_8"
const IUP_TIMES_BOLD_8         "TIMES_BOLD_8"
const IUP_TIMES_NORMAL_10      "TIMES_NORMAL_10"
const IUP_TIMES_ITALIC_10      "TIMES_ITALIC_10"
const IUP_TIMES_BOLD_10        "TIMES_BOLD_10"
const IUP_TIMES_NORMAL_12      "TIMES_NORMAL_12"
const IUP_TIMES_ITALIC_12      "TIMES_ITALIC_12"
const IUP_TIMES_BOLD_12        "TIMES_BOLD_12"
const IUP_TIMES_NORMAL_14      "TIMES_NORMAL_14"
const IUP_TIMES_ITALIC_14      "TIMES_ITALIC_14"
const IUP_TIMES_BOLD_14        "TIMES_BOLD_14"

/************************************************************************/
/*                           Keys                                       */
/************************************************************************/

const IUP_K_exclam            "K_exclam"
const IUP_K_quotedbl          "K_quotedbl"
const IUP_K_numbersign        "K_numbersign"
const IUP_K_dollar            "K_dollar"
const IUP_K_percent           "K_percent"
const IUP_K_ampersand         "K_ampersand"
const IUP_K_quoteright        "K_quoteright"
const IUP_K_parentleft        "K_parentleft"
const IUP_K_parentright       "K_parentright"
const IUP_K_asterisk          "K_asterisk"
const IUP_K_plus              "K_plus"
const IUP_K_comma             "K_comma"
const IUP_K_minus             "K_minus"
const IUP_K_period            "K_period"
const IUP_K_slash             "K_slash"
const IUP_K_0                 "K_0"
const IUP_K_1                 "K_1"
const IUP_K_2                 "K_2"
const IUP_K_3                 "K_3"
const IUP_K_4                 "K_4"
const IUP_K_5                 "K_5"
const IUP_K_6                 "K_6"
const IUP_K_7                 "K_7"
const IUP_K_8                 "K_8"
const IUP_K_9                 "K_9"
const IUP_K_colon             "K_colon"
const IUP_K_semicolon         "K_semicolon "
const IUP_K_less              "K_less"
const IUP_K_equal             "K_equal"
const IUP_K_greater           "K_greater"
const IUP_K_question          "K_question"
const IUP_K_at                "K_at"
const IUP_K_A                 "K_A"
const IUP_K_B                 "K_B"
const IUP_K_C                 "K_C"
const IUP_K_D                 "K_D"
const IUP_K_E                 "K_E"
const IUP_K_F                 "K_F"
const IUP_K_G                 "K_G"
const IUP_K_H                 "K_H"
const IUP_K_I                 "K_I"
const IUP_K_J                 "K_J"
const IUP_K_K                 "K_K"
const IUP_K_L                 "K_L"
const IUP_K_M                 "K_M"
const IUP_K_N                 "K_N"
const IUP_K_O                 "K_O"
const IUP_K_P                 "K_P"
const IUP_K_Q                 "K_Q"
const IUP_K_R                 "K_R"
const IUP_K_S                 "K_S"
const IUP_K_T                 "K_T"
const IUP_K_U                 "K_U"
const IUP_K_V                 "K_V"
const IUP_K_W                 "K_W"
const IUP_K_X                 "K_X"
const IUP_K_Y                 "K_Y"
const IUP_K_Z                 "K_Z"
const IUP_K_bracketleft       "K_bracketleft"
const IUP_K_backslash         "K_backslash"
const IUP_K_bracketright      "K_bracketright"
const IUP_K_circum            "K_circum"
const IUP_K_underscore        "K_underscore"
const IUP_K_quoteleft         "K_quoteleft"
const IUP_K_a                 "K_a"
const IUP_K_b                 "K_b"
const IUP_K_c                 "K_c"
const IUP_K_d                 "K_d"
const IUP_K_e                 "K_e"
const IUP_K_f                 "K_f"
const IUP_K_g                 "K_g"
const IUP_K_h                 "K_h"
const IUP_K_i                 "K_i"
const IUP_K_j                 "K_j"
const IUP_K_k                 "K_k"
const IUP_K_l                 "K_l"
const IUP_K_m                 "K_m"
const IUP_K_n                 "K_n"
const IUP_K_o                 "K_o"
const IUP_K_p                 "K_p"
const IUP_K_q                 "K_q"
const IUP_K_r                 "K_r"
const IUP_K_s                 "K_s"
const IUP_K_t                 "K_t"
const IUP_K_u                 "K_u"
const IUP_K_v                 "K_v"
const IUP_K_w                 "K_w"
const IUP_K_x                 "K_x"
const IUP_K_y                 "K_y"
const IUP_K_z                 "K_z"
const IUP_K_braceleft         "K_braceleft"
const IUP_K_bar               "K_bar"
const IUP_K_braceright        "K_braceright"
const IUP_K_tilde             "K_tilde"

const IUP_K_cA       "K_cA"
const IUP_K_cB       "K_cB"
const IUP_K_cC       "K_cC"
const IUP_K_cD       "K_cD"
const IUP_K_cE       "K_cE"
const IUP_K_cF       "K_cF"
const IUP_K_cG       "K_cG"
const IUP_K_cJ       "K_cJ"
const IUP_K_cK       "K_cK"
const IUP_K_cL       "K_cL"
const IUP_K_cN       "K_cN"
const IUP_K_cO       "K_cO"
const IUP_K_cP       "K_cP"
const IUP_K_cQ       "K_cQ"
const IUP_K_cR       "K_cR"
const IUP_K_cS       "K_cS"
const IUP_K_cT       "K_cT"
const IUP_K_cU       "K_cU"
const IUP_K_cV       "K_cV"
const IUP_K_cW       "K_cW"
const IUP_K_cX       "K_cX"
const IUP_K_cY       "K_cY"
const IUP_K_cZ       "K_cZ"
const IUP_K_mA       "K_mA"
const IUP_K_mB       "K_mB"
const IUP_K_mC       "K_mC"
const IUP_K_mD       "K_mD"
const IUP_K_mE       "K_mE"
const IUP_K_mF       "K_mF"
const IUP_K_mG       "K_mG"
const IUP_K_mH       "K_mH"
const IUP_K_mI       "K_mI"
const IUP_K_mJ       "K_mJ"
const IUP_K_mK       "K_mK"
const IUP_K_mL       "K_mL"
const IUP_K_mM       "K_mM"
const IUP_K_mN       "K_mN"
const IUP_K_mO       "K_mO"
const IUP_K_mP       "K_mP"
const IUP_K_mQ       "K_mQ"
const IUP_K_mR       "K_mR"
const IUP_K_mS       "K_mS"
const IUP_K_mT       "K_mT"
const IUP_K_mU       "K_mU"
const IUP_K_mV       "K_mV"
const IUP_K_mW       "K_mW"
const IUP_K_mX       "K_mX"
const IUP_K_mY       "K_mY"
const IUP_K_mZ       "K_mZ"
const IUP_K_BS       "K_BS"
const IUP_K_TAB      "K_TAB"
const IUP_K_CR       "K_CR"
const IUP_K_SP       "K_SP"
const IUP_K_ESC      "K_ESC"
const IUP_K_sCR      "K_sCR"
const IUP_K_sTAB     "K_sTAB"
const IUP_K_cTAB     "K_cTAB"
const IUP_K_mTAB     "K_mTAB"
const IUP_K_HOME     "K_HOME"
const IUP_K_UP       "K_UP"
const IUP_K_PGUP     "K_PGUP"
const IUP_K_LEFT     "K_LEFT"
const IUP_K_RIGHT    "K_RIGHT"
const IUP_K_END      "K_END"
const IUP_K_DOWN     "K_DOWN"
const IUP_K_PGDN     "K_PGDN"
const IUP_K_MIDDLE   "K_MIDDLE"
const IUP_K_INS      "K_INS"
const IUP_K_DEL      "K_DEL"
const IUP_K_sHOME    "K_sHOME"
const IUP_K_sUP      "K_sUP"
const IUP_K_sPGUP    "K_sPGUP"
const IUP_K_sLEFT    "K_sLEFT"
const IUP_K_sRIGHT   "K_sRIGHT"
const IUP_K_sEND     "K_sEND"
const IUP_K_sDOWN    "K_sDOWN"
const IUP_K_sPGDN    "K_sPGDN"
const IUP_K_cHOME    "K_cHOME"
const IUP_K_cPGUP    "K_cPGUP"
const IUP_K_cLEFT    "K_cLEFT"
const IUP_K_cRIGHT   "K_cRIGHT"
const IUP_K_cEND     "K_cEND"
const IUP_K_cPGDN    "K_cPGDN"
const IUP_K_cUP      "K_cUP"
const IUP_K_cDOWN    "K_cDOWN"
const IUP_K_cMIDDLE  "K_cMIDDLE"
const IUP_K_cINS     "K_cINS"
const IUP_K_cDEL     "K_cDEL"
const IUP_K_mHOME    "K_mHOME"
const IUP_K_mPGUP    "K_mPGUP"
const IUP_K_mLEFT    "K_mLEFT"
const IUP_K_mRIGHT   "K_mRIGHT"
const IUP_K_mEND     "K_mEND"
const IUP_K_mPGDN    "K_mPGDN"
const IUP_K_mUP      "K_mUP"
const IUP_K_mDOWN    "K_mDOWN"
const IUP_K_mINS     "K_mINS"
const IUP_K_mDEL     "K_mDEL"
const IUP_K_F1       "K_F1"
const IUP_K_F2       "K_F2"
const IUP_K_F3       "K_F3"
const IUP_K_F4       "K_F4"
const IUP_K_F5       "K_F5"
const IUP_K_F6       "K_F6"
const IUP_K_F7       "K_F7"
const IUP_K_F8       "K_F8"
const IUP_K_F9       "K_F9"
const IUP_K_F10      "K_F10"
const IUP_K_F11      "K_F11"
const IUP_K_F12      "K_F12"
const IUP_K_sF1      "K_sF1"
const IUP_K_sF2      "K_sF2"
const IUP_K_sF3      "K_sF3"
const IUP_K_sF4      "K_sF4"
const IUP_K_sF5      "K_sF5"
const IUP_K_sF6      "K_sF6"
const IUP_K_sF7      "K_sF7"
const IUP_K_sF8      "K_sF8"
const IUP_K_sF9      "K_sF9"
const IUP_K_sF10     "K_sF10"
const IUP_K_sF11     "K_sF11"
const IUP_K_sF12     "K_sF12"
const IUP_K_cF1      "K_cF1"
const IUP_K_cF2      "K_cF2"
const IUP_K_cF3      "K_cF3"
const IUP_K_cF4      "K_cF4"
const IUP_K_cF5      "K_cF5"
const IUP_K_cF6      "K_cF6"
const IUP_K_cF7      "K_cF7"
const IUP_K_cF8      "K_cF8"
const IUP_K_cF9      "K_cF9"
const IUP_K_cF10     "K_cF10"
const IUP_K_cF11     "K_cF11"
const IUP_K_cF12     "K_cF12"
const IUP_K_mF1      "K_mF1"
const IUP_K_mF2      "K_mF2"
const IUP_K_mF3      "K_mF3"
const IUP_K_mF4      "K_mF4"
const IUP_K_mF5      "K_mF5"
const IUP_K_mF6      "K_mF6"
const IUP_K_mF7      "K_mF7"
const IUP_K_mF8      "K_mF8"
const IUP_K_mF9      "K_mF9"
const IUP_K_mF10     "K_mF10"
const IUP_K_m1       "K_m1"
const IUP_K_m2       "K_m2"
const IUP_K_m3       "K_m3"
const IUP_K_m4       "K_m4"
const IUP_K_m5       "K_m5"
const IUP_K_m6       "K_m6"
const IUP_K_m7       "K_m7"
const IUP_K_m8       "K_m8"
const IUP_K_m9       "K_m9"
const IUP_K_m0       "K_m0"

/************/
/* Colorbar */
/************/

const IUP_NUM_PARTS  "NUM_PARTS"
const IUP_NUM_CELLS "NUM_CELLS"
const IUP_CELL "CELL"
const IUP_PREVIEW_SIZE "PREVIEW_SIZE"
const IUP_SHOW_PREVIEW "SHOW_PREVIEW"
const IUP_SHOW_SECONDARY "SHOW_SECONDARY"
const IUP_PRIMARY_CELL "PRIMARY_CELL"
const IUP_SECONDARY_CELL "SECONDARY_CELL"
const IUP_ORIENTATION  "ORIENTATION"
const IUP_SQUARED  "SQUARED"
const IUP_SHADOWED  "SHADOWED"
const IUP_BUFFERIZE  "BUFFERIZE"
const IUP_TRANSPARENCY  "TRANSPARENCY"
const IUP_CELL_CB "CELL_CB"
const IUP_EXTENDED_CB "EXTENDED_CB"
const IUP_SELECT_CB "SELECT_CB"
const IUP_SWITCH_CB "SWITCH_CB"
const IUP_VERTICAL    "VERTICAL"
const IUP_HORIZONTAL  "HORIZONTAL"

/************/
/* Cells    */
/************/

const IUP_ALL  "ALL"
const IUP_BOXED  "BOXED"
const IUP_CLIPPED  "CLIPPED"
const IUP_TRANSPARENT  "TRANSPARENT"
const IUP_NON_SCROLLABLE_LINES  "NON_SCROLLABLE_LINES"
const IUP_NON_SCROLLABLE_COLS  "NON_SCROLLABLE_COLS"
const IUP_ORIGIN  "ORIGIN"
const IUP_NO_COLOR  "NO_COLOR"
const IUP_FIRST_LINE  "FIRST_LINE"
const IUP_FIRST_COL  "FIRST_COL"
const IUP_DOUBLE_BUFFER  "DOUBLE_BUFFER"
const IUP_LIMITS  "LIMITS"
const IUP_CANVAS  "CANVAS"
const IUP_IMAGE_CANVAS  "IMAGE_CANVAS"
const IUP_FULL_VISIBLE  "FULL_VISIBLE"
const IUP_MOUSECLICK_CB "MOUSECLICK_CB"
const IUP_MOUSEMOTION_CB "MOUSEMOTION_CB"
const IUP_DRAW_CB "DRAW_CB"
const IUP_WIDTH_CB "WIDTH_CB"
const IUP_HEIGHT_CB "HEIGHT_CB"
const IUP_NLINES_CB "NLINES_CB"
const IUP_NCOLS_CB "NCOLS_CB"
const IUP_HSPAN_CB "HSPAN_CB"
const IUP_VSPAN_CB "VSPAN_CB"
const IUP_SCROLLING_CB "SCROLLING_CB"

/*****************/
/* ColorBrowser  */
/*****************/

const IUP_RGB "RGB"
const IUP_CHANGE_CB "CHANGE_CB"
const IUP_DRAG_CB "DRAG_CB"

/*****************/
/* Val           */
/*****************/

const ICTL_MOUSEMOVE_CB "MOUSEMOVE_CB"
const ICTL_BUTTON_PRESS_CB "BUTTON_PRESS_CB"
const ICTL_BUTTON_RELEASE_CB "BUTTON_RELEASE_CB"
const ICTL_HORIZONTAL "HORIZONTAL"
const ICTL_VERTICAL "VERTICAL"
const ICTL_SHOWTICKS "SHOWTICKS"

/*****************/
/* Tabs          */
/*****************/

const ICTL_TOP "TOP"
const ICTL_BOTTOM "BOTTOM"
const ICTL_LEFT "LEFT"
const ICTL_RIGHT "RIGHT"
const ICTL_TABTYPE "TABTYPE"
const ICTL_TABTITLE "TABTITLE"
const ICTL_TABSIZE "TABSIZE"
const ICTL_TABCHANGE_CB "TABCHANGE_CB"
const ICTL_FONT "FONT"
const ICTL_FONT_ACTIVE "FONT_ACTIVE"
const ICTL_FONT_INACTIVE "FONT_INACTIVE"

/*****************/
/* Gauge         */
/*****************/

const ICTL_SHOW_TEXT "SHOW_TEXT"
const ICTL_DASHED "DASHED"
const ICTL_MARGIN "MARGIN"
const ICTL_TEXT "TEXT"

/*****************/
/* Dial          */
/*****************/

const ICTL_DENSITY "DENSITY"
const ICTL_HORIZONTAL "HORIZONTAL"
const ICTL_VERTICAL "VERTICAL"
const ICTL_CIRCULAR "CIRCULAR"
const ICTL_UNIT "UNIT"

/*****************/
/* Matrix        */
/*****************/

const IUP_ENTERITEM_CB   "ENTERITEM_CB"
const IUP_LEAVEITEM_CB   "LEAVEITEM_CB"
const IUP_EDITION_CB     "EDITION_CB"
const IUP_CLICK_CB       "CLICK_CB"
const IUP_DROP_CB        "DROP_CB"
const IUP_DROPSELECT_CB  "DROPSELECT_CB"
const IUP_DROPCHECK_CB   "DROPCHECK_CB"
const IUP_SCROLL_CB      "SCROLL_CB"
const IUP_VALUE_CB       "VALUE_CB"
const IUP_VALUE_EDIT_CB  "VALUE_EDIT_CB"
const IUP_FIELD_CB       "FIELD_CB"
const IUP_RESIZEMATRIX   "RESIZEMATRIX"
const IUP_ADDLIN         "ADDLIN"
const IUP_ADDCOL         "ADDCOL"
const IUP_DELLIN         "DELLIN"
const IUP_DELCOL         "DELCOL"
const IUP_NUMLIN         "NUMLIN"
const IUP_NUMCOL         "NUMCOL"
const IUP_NUMLIN_VISIBLE "NUMLIN_VISIBLE"
const IUP_NUMCOL_VISIBLE "NUMCOL_VISIBLE"
const IUP_MARKED         "MARKED"
const IUP_WIDTHDEF       "WIDTHDEF"
const IUP_HEIGHTDEF      "HEIGHTDEF"
const IUP_AREA           "AREA"
const IUP_MARK_MODE      "MARK_MODE"
const IUP_LIN            "LIN"
const IUP_COL            "COL"
const IUP_LINCOL         "LINCOL"
const IUP_CELL           "CELL"
const IUP_EDIT_MODE      "EDIT_MODE"
const IUP_FOCUS_CELL     "FOCUS_CELL"
const IUP_ORIGIN         "ORIGIN"
const IUP_REDRAW         "REDRAW"
const IUP_PREVIOUSVALUE  "PREVIOUSVALUE"
const IUP_MOUSEMOVE_CB   "MOUSEMOVE_CB"

/*****************/
/* Tree          */
/*****************/

const IUP_ADDLEAF          "ADDLEAF"
const IUP_ADDBRANCH        "ADDBRANCH"
const IUP_DELNODE          "DELNODE"
const IUP_IMAGELEAF        "IMAGELEAF"
const IUP_IMAGEBRANCHCOLLAPSED "IMAGEBRANCHCOLLAPSED"
const IUP_IMAGEBRANCHEXPANDED  "IMAGEBRANCHEXPANDED"
const IUP_IMAGEEXPANDED     "IMAGEEXPANDED"
const IUP_KIND             "KIND"
const IUP_PARENT           "PARENT"
const IUP_DEPTH            "DEPTH"
const IUP_MARKED           "MARKED"
const IUP_ADDEXPANDED      "ADDEXPANDED"
const IUP_CTRL             "CTRL"
const IUP_SHIFT            "SHIFT"
const IUP_STATE            "STATE"
const IUP_STARTING         "STARTING"
const IUP_LEAF             "LEAF"
const IUP_BRANCH           "BRANCH"
const IUP_SELECTED         "SELECTED"
const IUP_CHILDREN         "CHILDREN"
const IUP_MARKED           "MARKED"
const IUP_ROOT             "ROOT"
const IUP_LAST             "LAST"
const IUP_PGUP             "PGUP"
const IUP_PGDN             "PGDN"
const IUP_NEXT             "NEXT"
const IUP_PREVIOUS         "PREVIOUS"
const IUP_INVERT           "INVERT"
const IUP_BLOCK            "BLOCK"
const IUP_CLEARALL         "CLEARALL"
const IUP_MARKALL          "MARKALL"
const IUP_INVERTALL        "INVERTALL"
const IUP_REDRAW           "REDRAW"
const IUP_COLLAPSED        "COLLAPSED"
const IUP_EXPANDED         "EXPANDED"
const IUP_SELECTION_CB "SELECTION_CB"
const IUP_BRANCHOPEN_CB    "BRANCHOPEN_CB"
const IUP_BRANCHCLOSE_CB   "BRANCHCLOSE_CB"
const IUP_RIGHTCLICK_CB    "RIGHTCLICK_CB"
const IUP_EXECUTELEAF_CB   "EXECUTELEAF_CB"
const IUP_RENAMENODE_CB    "RENAMENODE_CB"
const IUP_IMGLEAF             "IMGLEAF"
const IUP_IMGCOLLAPSED        "IMGCOLLAPSED"
const IUP_IMGEXPANDED         "IMGEXPANDED"
const IUP_IMGBLANK            "IMGBLANK"
const IUP_IMGPAPER            "IMGPAPER"+/
}

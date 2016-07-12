# iup

D language: A "Deimos"-like binding to IUP, CD (and IM).

IUP, a Portable graphical User Interface toolkit, current source code version 3.19.1,  http://webserver2.tecgraf.puc-rio.br/iup/<br>
CD, a 2D Graphics Library, current source code version 5.10,  http://webserver2.tecgraf.puc-rio.br/cd/<br>
IM, an Imaging Toolkit, current source code version 3.11,  http://webserver2.tecgraf.puc-rio.br/im/<br>

After installing IUP and CD (some controls mentioned in IUP doc's "Gallery/Additional Controls" require binaries from toolkit CD; and an optional installation of IM, though I recommend installing this too, as e.g. loading an image from file will require it), using the script install from a prebuilt '...Libraries' binary, I recommend to download 'Tools Executables', run iuptest and pick some test cases like Sample, Tabs... for a live impression of IUP's look and feel. 
https://sourceforge.net/projects/iup/files/3.19.1/Tools%20Executables/

For simple GUI applications, the binding to IUP is all You need (it covers the "Gallery/Additional Controls" as well); the dub.json file reflects this situation with a (minimal) set of basic IUP and CD libraries required anyway (for compile-time linking with .so/.dll).

Assuming, You have installed IUP + CD + IM, the binding to IUP still makes available only part of the full functionality of this trio, though.
It's not possible to describe in few words, when You need bindings to CD and/or IM as well; this is thoroughly explained in Tecgraf' docs with each control.
For convenience, a D-binding to CD and (soon to come) IM, is/will be included here as well (but didn't undergo testing so far):<br>

There is a dub.json file provisionally named toberenameddub.json, which reflects a setting to the other extreme, using all IUP, CD and IM binding code and all binary libs (even those, the mentioned depend on) for Linux, kernel 4.4. It may be "crack a nut with a sledgehammer" to link to all shared objects but will do in the first place, until You familiarize and adjust to Your needs by stripping from that:<br>
Dlang version identifier CD "includes" the CD binding code, in case You are going to do "more" on canvases.<br>
Dlang version identifier CD_NO_OLD_INTERFACE may be set additionally, to exclude from the CD-binding the old CD interface.<br>
Dlang version identifier IM "includes" the IM binding code, in case You are going to do "more" on images.<br>
Of course, any of CD or IM version identifier may only be set if the coresponding installation is done as well

A remark on linking to IUP, CD (, IM) binaries: The modularity of the IUP, CD (, IM) toolkit is nice, each toolkit even splits into several library binaries, but what you win on the swings you lose on the roundabouts: It may be tricky in some corner cases to get right the tailored set of "required" libraries depending on the features used; maybe You'll need the documentation for that (controls head section in the guide  with 'Initialization and Usage').
The set of libraries/features available also may depend on OS and even on a kernel version.<br>
For DMD, there is a pragma, that should select libs for linkage depending on which binding source file(s) got imported with a dedicated pragma declaration. Nice theory, but AFAIK not suited for Linux and on Windows (tested on Win32) I couldn't make use of it either. Thus currently I'm left with listing (supplementary/other than the 'basic') libs in my app's dub.json, but the pragma(lib, "library") helps to know which one(s);
Linux: Place all .so required in section "libs-posix" (strip leading 'lib' and trailing '.so'). 
Windows: Place all required import libraries .lib in architecture-specific sections, e.g. "sourceFiles-windows-x86-dmd" for a Win32 build with DMD (no stripping of import lib names;<br>You will have to create on Your own the import libraries for a Win32 build with DMD due to Digital Mars linker OPTLINK (and the format OMF used; look at lib/windows-x86-dmd/README for a howto)

Section "lflags-posix": ["-L/path/to/extracted/folder/cd-5.10_Linux44_64_lib_OR_WHATEVER/ftgl/lib/Linux44_64"]<br>
If You get unresolved references to 'ftglGetFontMaxWidth' and 'ftglSetNearestFilter', e.g. when using IupPlotOpen(), then You have to adapt section "lflags-posix" to point to the valid directory, where the CD-package's libftgl.so is located, because the systems libftgl.so is not sufficient.

The sections "copyFiles-windows..." are for a dub feature I currently use to pick from all .dll (I placed next to the import libraries i.e. not in a 'standard' .dll location) only those, that are the minimum to be deployed for this special build. Remove this if You don't need/like it.

Some C-examples are translated to D code, look at dir examples/C or examples/tutorial (make shure, the D files have access right execute and You have rdmd) and run e.g. ./list2.d

Have fun with IUP from D


# iup

D language: A "Deimos"-like binding to IUP, CD (and IM).

IUP, a Portable graphical User Interface toolkit, current source code version 3.19.1,  http://webserver2.tecgraf.puc-rio.br/iup/<br>
CD, a 2D Graphics Library, current source code version 5.10,  http://webserver2.tecgraf.puc-rio.br/cd/<br>
IM, an Imaging Toolkit, current source code version 3.11,  http://webserver2.tecgraf.puc-rio.br/im/<br>

After installing IUP and CD (some controls mentioned in IUP doc's "Gallery/Additional Controls" require binaries from toolkit CD; and an optional installation of IM, though I recommend installing this too if handling images/icons is a topic, as e.g. loading an image from file will require it), using the script install from a prebuilt '...Libraries' binary, I recommend to download 'Tools Executables', run iuptest and pick some test cases like Sample, Tabs... for a live impression of IUP's look and feel. 
https://sourceforge.net/projects/iup/files/3.19.1/Tools%20Executables/

For simple GUI applications, the binding to IUP is all You need (it covers the "Gallery/Additional Controls" as well); the dub.json file reflects this situation with a set of basic IUP and CD libraries required anyway (for compile-time linking with .so/.dll). Thus, in Your app's dub.json there will be no more related to the binding than "dependencies".

Assuming, You have installed IUP + CD + IM, the binding to IUP doesn't give access to most of the functions from CD and IM binaries, though.
It's not possible to describe in few words, when the bindings to CD and/or IM are required; this is thoroughly explained in Tecgraf' docs (and with each control).
For convenience, a D-binding to CD and (soon to come) IM, is/will be included here as well (but didn't undergo testing so far):<br>

There is a dub.json file provisionally named toberenameddub.json, which reflects a setting to the other extreme, linking all IUP, CD and IM binary libs except libiupweb.so (even those, others depend on) for Linux, kernel 4.4. It may be "crack a nut with a sledgehammer" to link to all shared objects but will do in the first place, until You familiarize and adjust to Your needs by stripping from that. On Linux I stripped iupweb (web browser control) from "libs-posix", as it presumes installation of additional software (web content engine). Add again if required:<br>
Dlang version identifier CD enables the CD binding code, in case You are going to do "more" on canvases. Without version=CD, all of the files for the D-binding to CD are empty.<br>
Dlang version identifier CD_NO_OLD_INTERFACE may be set additionally, to exclude from the CD-binding the old CD interface.<br>
Dlang version identifier IM enables the IM binding code, in case You are going to do "more" on images.<br>
The version identifiers (if any) are to be specified in the app's dub.json and get passed to the binding.

A remark on linking to IUP, CD, IM binaries: The modularity of the IUP, CD, IM toolkit is nice, each toolkit even splits into several library binaries, but what you win on the swings you lose on the roundabouts: It may be tricky in some corner cases to get right the tailored set of "required" libraries depending on the features used (there is no automatism as of now); maybe You'll need the documentation for that (controls head section in the guide  with 'Initialization and Usage').
The set of libraries/features available also may depend on OS, on a kernel version, on additional software available.<br>
For DMD, there is a pragma, that should select libs for linkage depending on which binding source file(s) got imported by Your app's source code. Nice theory, but AFAIK not suited for Linux and on Windows (tested on Win32) I couldn't make use of it either. Thus currently I'm left with listing (supplementary/other than the 'basic') libs in my app's dub.json, but the pragma(lib, "library") helps to know which one(s).<br>
Linux: Place all .so required in section "libs-posix" (strip leading 'lib' and trailing '.so'). 
Windows: Place all required import libraries .lib in architecture-specific sections, e.g. "sourceFiles-windows-x86-dmd" for a Win32 build with DMD (no stripping of import lib names;<br>You will have to create on Your own the import libraries for a Win32 build with DMD due to Digital Mars linker OPTLINK (and the format OMF used; look at lib/windows-x86-dmd/README for a howto).
The locations, where the binding expects to find the import libraries for Windows are lib/windows-x86-dmd and/or lib/windows-x86_64. The folders include a README with more infos.

Section "lflags-posix-x86_64": ["-L$HOME/.dub/packages/iup-0.0.1/lib/posix-x86_64", "-rpath=$HOME/.dub/packages/iup-0.0.1/lib/posix-x86_64"],<br>
Without this, it is very likely, that You'll get unresolved references to 'ftglGetFontMaxWidth' and 'ftglSetNearestFilter', e.g. when using IupPlotOpen(), because the systems libftgl.so is not sufficient. Copy the libftgl.so from the IUP or CD library package to the matching folder lib/posix-x86_64 or lib/posix-x86; thus it will be used instead of the system's one.

Some C-examples are translated to D code, look at dir examples/C or examples/tutorial (make shure, the D files have access right execute and You have rdmd) and run e.g. ./list2.d

Have fun with IUP from D


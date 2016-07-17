# iup

D language: A "Deimos"-like binding to IUP, CD and IM.

IUP, a Portable graphical User Interface toolkit, current source code version 3.19.1,  http://webserver2.tecgraf.puc-rio.br/iup/<br>
CD, a 2D Graphics Library, current source code version 5.10,  http://webserver2.tecgraf.puc-rio.br/cd/<br>
IM, an Imaging Toolkit, current source code version 3.11,  http://webserver2.tecgraf.puc-rio.br/im/<br>

After installing IUP and CD (some controls mentioned in IUP doc's "Gallery/Additional Controls" require binaries from toolkit CD; and an optional installation of IM, though I recommend installing this too if handling images/icons is a topic, as e.g. loading an image from file will require it), using the script install from a prebuilt '...Libraries' binary, I recommend to download 'Tools Executables', run iuptest and pick some test cases like Sample, Tabs... for a live impression of IUP's look and feel. https://sourceforge.net/projects/iup/files/3.19.1/Tools%20Executables/

Among other features, this GUI toolkit purely focuses on User Interface (no burden of additional classes/structs for strings, containers ...) and has an abstract layout concept (no positioning of controls by coordinates, no dependency on screen resolution, but the window size will depend on the systems setting for the text size).<br>

For simple GUI applications, the binding to IUP is all You need (it covers the "Gallery/Additional Controls" as well); the dub.json file reflects this situation with a set of basic IUP and CD binaries required anyway (for compile-time linking with .so/.dll). Thus, in these app's dub.json there will be no more related to the binding than "dependencies".

Assuming, You have installed IUP + CD + IM, the binding to IUP doesn't give access to most of the functions from CD and IM binaries, though.
It's not possible to describe in few words, when the bindings to CD and/or IM are required; this is thoroughly explained in Tecgraf' docs (and with each control).
For convenience, a D-binding to CD and (soon to be completed) IM, is included here as well (but didn't undergo intensive testing so far):<br>

There is a dub.json file provisionally named toberenameddub.json, which reflects a setting to the other extreme, linking all IUP, CD and IM binary libs (except libiupweb.so on Linux; even those, others depend on; IM: the single-threaded libim_process.so/im_process.dll is choosen). It may be "crack a nut with a sledgehammer" to link to all shared objects but will do in the first place, until You familiarize and adjust to Your needs by stripping from that. On Linux I stripped iupweb (web browser control) from "libs-posix", as it presumes installation of additional software (web content engine). Add again if required:<br>
Dlang version identifier IUP doesn't exist; it's implicit.<br>
Dlang version identifier CD enables the CD binding code, in case You are going to do "more" on canvases. Without version=CD, all of the files for the D-binding to CD toolkit are empty.<br>
Dlang version identifier CD_NO_OLD_INTERFACE may be set additionally, to exclude from the CD-binding the old CD interface.<br>
Dlang version identifier IM enables the IM binding code, in case You are going to do "more" on images.<br>
The version identifiers (if any) are to be specified in the app's dub.json and get passed to the binding.

A remark on linking to IUP, CD, IM binaries: The modularity of the IUP, CD, IM toolkit is nice, each toolkit even splits into several library binaries, but what you win on the swings you lose on the roundabouts: It may be tricky in some corner cases to get right the tailored set of "required" libraries depending on the controls/features used (there is no automatism as of now); maybe You'll need the documentation for that (controls head section in the guide  with 'Initialization and Usage').
The set of libraries/features available also may depend on OS, on a kernel version, on additional software available.<br>
For DMD, there is a pragma, that should select libs for linkage depending on which binding source file(s) got imported by Your app's source code. Nice theory, but AFAIK not suited for Linux and on Windows (tested on Win32) I couldn't make use of it either. Thus currently I'm left with listing (supplementary/other than the 'basic') libs in my app's dub.json, but the pragma(lib, "library") helps to know which one(s).<br>
Linux: Place all .so required in section "libs-posix" (strip leading 'lib' and trailing '.so'). 
Windows: Place all required import libraries .lib in architecture-specific sections, e.g. "sourceFiles-windows-x86-dmd" for a Win32 build with DMD (no stripping of import lib names.<br>
You will have to create on Your own the import libraries for a Win32 build with DMD (default -m32; I didn't check about -m32mscoff) due to Digital Mars linker OPTLINK (and the format OMF used; look at lib/windows-x86-dmd/README for a howto). The import libraries for a Win64 build are within Tecgraf's distributions.
The locations, where the binding expects to find the import libraries for Windows are lib/windows-x86-dmd and/or lib/windows-x86_64. The folders include a README with more infos.

Section "lflags-posix-x86_64": ["-L$HOME/.dub/packages/iup-0.0.1/lib/posix-x86_64", "-rpath=$HOME/.dub/packages/iup-0.0.1/lib/posix-x86_64"],<br>
Without this on Linux, it is very likely, that You'll get unresolved references to 'ftglGetFontMaxWidth' and 'ftglSetNearestFilter', e.g. when using IupPlotOpen(), because the system's libftgl.so is not sufficient. Copy the libftgl.so from the IUP or CD library package to the matching folder lib/posix-x86_64 or lib/posix-x86; thus it will be used instead of the system's one.

Some C-examples are translated to D code, look at dir examples/C or examples/tutorial (make shure, the D files have access right execute and You have rdmd) and run e.g. ./list2.d (They are suitable for Linux users and must be slightly adapted for Windows user (README)).

The, I call it, "IupSetStrAttribute-Or-Not-Rule" (newbies in IUP like me might fall ito this trap):<br>
One worthily to mention disadvantage of any C (C++) language based binding is dealing with the C peculiarities and the D language garbage collection (GC) peculiarity.<br>
You'll be dealing a lot with conversions to C's null-terminated strings (and pointers generally; predominantly we are outside of @safe): Watch out that those strings passed to IUP as function parameters, will be copied in IUP where neccessary (remind the GC !!).<br>
The function IupSetStrAttribute will definitely be Your friend: "IupSetStrAttribute .... The given string value will be duplicated internally."<br>
The automatic/implicite conversion of D string literals to const(char)* including the \0 terminating byte is very helpfull; IupSetAttribute is sufficient for global const items then.<br>
Carefully read the documentation section about the IupSetAttribute...-family (which is roughly the same as pointed to here).<br>
Thoroughly test that You haven't overlooked obeying the "IupSetStrAttribute-Or-Not-Rule", i.e. passed away local (stack) pointers or anything potentially collected by the GC (heap), that is still in use by a C binary!!! Think about to call GC.collect() for test's sake. Segfaults having this real cause are hard to track down otherwise.<br>
Only experts won't ever be hit by a segfault (assuming, I did the binding code right and IUP, CD, IM are free of bugs), as dealing with IUP, CD, IM is very much about dealing with pointers.
Please create an "Issue" or "Pull Request" at https://github.com/carblue/iup, if You found a bug in these bindings.

About the D-bindings, C, C++, D, wrappers:<br>
The binding requires callbacks in D to have nothrow attribute (and C linkage of course): The compiler will remind You, in case You used D functions that may throw, without a surrounding try..catch block.<br>
Maybe this will change partially (to be relaxed refering to C++ backuped functions) with progress in https://dlang.org/spec/cpp_interface.html#exception-handling.

Most of the headers deal with C only; all are equaly named D files now.<br>
The C files relating to Lua are omitted.<br>
The structure of C files was retained for easy comparison (i.a. for easy dealing with upcoming new releases of IUP, CD and IM).<br>
Those #define "function", that where meant to be used by the user only, are D linkage functions/templates now, others have C linkage?.

The mixed C/C++ files also kept their names, some functions have C++ linkage as required to call into the binaries.
C++ items with no relation to IUP, CD and IM binaries are (going to be) D items now.

A few files are currently missing, some from IM and those dealing only (like C++ wrappers) or much with C++, inheritance, needing my thorough investigation and experience about their usage and correct way to bind/replace/omit, and are work in progress.<br>
Missing files, that probably will get translated (as opposed to those being deliberately omitted), originating from:
iup_plus.h<br>
iup_class_cbs.hpp<br>
cd_canvas.hpp  (almost forwarding only; think about omitting)<br>
cd_plus.h<br>
cd_private.h (not meant to be used ?; think about omitting)<br>
im_complex.h  C++ template<class T>class imComplex; check replacement by std.complex<br>
im_math_op.h<br> (template) function definitions meant for C++ usage; D can do better, especially in generalzation 
im_math.h<br>    (template) function definitions meant for C++ usage;
im_binfile.h<br>
im_file.h<br>  C struct is base of inheritance in  im_format.h:21:class imFileFormatBase: public _imFile<br>
im_format.h<br>
im_plus.h<br>

Omitted files: iuplua*.h, cdlua*.h, imlua.h

Files with new names are listed explicitely here:
iup_plus.h -> iup_plusD.d<br>
	iup_plus.h is C++ only and defines C++ wrapper classes. They are gone together with their namespaces and are equivalent D wrapper classes now, hence the change in file name. Occasionally there are new functions added like IupOpenD. Functions, that do only forward calls (originally in a C++ namespace iup) with new Iup-prefix-stripped function names, are commented out (////  If You, other than me, like them, it's easy to bring them in again).<br>
iup_plusD will be worth a try; it's going to free from much of C's null-terminated strings handling.


Have fun with IUP from D


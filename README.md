# iup

D language: A "Deimos"-like binding for IUP, CD and IM 

IUP, a Portable graphical User Interface toolkit, last source code version 3.20 supported,  http://webserver2.tecgraf.puc-rio.br/iup/<br>
CD, a 2D Graphics Library, next-to-last source code version 5.10 supported,  http://webserver2.tecgraf.puc-rio.br/cd/<br>
IM, an Imaging Toolkit, last source code version 3.12 supported,  http://webserver2.tecgraf.puc-rio.br/im/

After installing IUP, CD and IM, using the script install from a prebuilt '...Libraries' binary, I recommend to download 'Tools Executables', run iuptest and pick some test cases like Sample, Tabs, Expander, Plot... for a live impression of IUP's look and feel. https://sourceforge.net/projects/iup/files/3.20/Tools%20Executables/

Among other features, this GUI toolkit purely focuses on User Interface (no burden of additional classes/structs for strings, containers ...) and has an abstract layout concept (no positioning of controls by X/Y coordinates required, can be independent from screen resolution, but the window size will then depend on the systems setting for the text size).<br>

Current state:<br>
The "C-ish" interface/"Deimos"-like binding  is ready for IUP, CD and virtually for IM.<br>
The "D-ish" interface/wrappers (to be supplied by files iup/iup_plusD.d, cd/cd_plusD.d and im/im_plusD.d) is not yet available/work in progress.<br>

The D wrappers are evolving from original C++ wrappers (files iup_plus.h, cd_plus.h and im_plus.h).

Commonalities and differences of "C-ish" and "D-ish" interface:<br>
Without any D Language version identifier, both interfaces can make available functionality from all IUP binaries and one CD binary (libcd.so/cd.dll). For full CD functionality, set version identifier CD, for full IM functionality, set version identifier IM, though not required for simple GUI applications.<br>
Using the "C-ish" interface, import the translated header files as You would #include in C.<br>

[concerning upcoming wrappers:<br>
Using the "D-ish" interface , there is only one file to import: iup.iup_plusD, but some IUP functionality has to be "switched ON" explicitely if required, in order not to introduce more binary dependencies than used, i.e. it applies to all controls that have implemented their functionality in dedicated binaries: The set of available version specifiers for switching "ON" may be looked up in toberenameddub.json, which is an all-in dub.json alternative.

Designing a D interface is a matter of taste, individual preferences too. Theses are some of my preferences:<br>
- No supplementary functions, that merely forward calls.
- Dealing with C's null terminated strings as rare as possible.<br>
- Being save towards IupSetAttribute <-> IupSetStrAttribute (absolutely essential reading in the IUP documentation !).<br>
- Supersede calling IupGetHandle.<br>
- Allow subtype polymorphism.<br>

Next to what iup_plus.h provided anyway, to achieve my goals, iup_plusD.d has an associative array, global variable Handle[string] AA; in conjunction with new constructors it is meant to virtually replace using IUP'S administration of names (IupSetHandle/IupGetHandle); names are keys to AA now, supplied during construction for those entities, I want to access lateron beyond their scope; Handle is the base class of all classes in iup_plusD.d.<br>
]

The bindings require callback functions to have nothrow attribute.<br>

The accompanying dub.json cares for a basic/minimum set of binaries for IUP usage (libiup.so/iup.dll, libiupcontrols.so/iupcontrols.dll and usage of a replacement libftgl.so on Linux; the all-in toberenameddub.json being the other extreme). This requires, that files concerned (libftgl.so on Linux or import libraries on Windows) are placed within folder /lib substructure. There are README files for more information. Depending on what features are used by an application, more binaries may be required, to be specified in the apps dub.json, together with version identifieres (if applicable; they get passed to the binding) and a /lib folder for an application on Windows.

Some C-examples are translated to D code, look at dir examples/C or examples/tutorial (make shure, the D files have access right execute and You have rdmd) and run e.g. ./list2.d (They are suitable for Linux users and must be slightly adapted by Windows user (README)).

Have fun with IUP from D


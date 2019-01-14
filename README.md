[![Build Status](https://travis-ci.org/carblue/iup.svg?branch=master)](https://travis-ci.org/carblue/iup)

# iup

D language: A "Deimos"-like binding for IUP, CD and IM

IUP, a Portable graphical User Interface toolkit, version 3.26 supported (released 2019-01-07),  http://webserver2.tecgraf.puc-rio.br/iup/<br>
CD, a 2D Graphics Library, version 5.11.1 supported (released 2017-07-01),  http://webserver2.tecgraf.puc-rio.br/cd/<br>
IM, an Imaging Toolkit, version 3.12 supported (released 2016-09-30),  http://webserver2.tecgraf.puc-rio.br/im/

CD and/or IM may be dispensable, depending on GUI-controls to be used.<br>
After installing IUP, CD and IM, using the script 'install' from a prebuilt '...Libraries' binary, I recommend to download IUP's 'Tools Executables', run it's iuptest and pick some test cases like Sample, Tabs, Expander, Plot... for a live impression of IUP's look and feel. https://sourceforge.net/projects/iup/files/3.26/Tools%20Executables/

Among other features, this GUI toolkit purely focuses on User Interface (no burden of additional classes/structs for strings, containers ...) and has an abstract layout concept (no positioning of controls by X/Y coordinates required, can be independent from screen resolution, but the window size will then depend on the systems setting for the text size).<br>

Current state:<br>
The "C-ish" interface/"Deimos"-like binding  is ready for IUP, CD and virtually for IM.<br>
The "D-ish" interface/wrappers (to be supplied by files iup/iup_plusD.d, cd/cd_plusD.d and im/im_plusD.d) are [WIP] work in progress.<br>
iup/iup_plusD.d is supplied (mostly it "follows" iup_plus.h design) and will evolve while I'm using and testing more controls.
While usally my wrapper APIs in other projects don't expose pointers, that's different here: Module iup_plusD is meant to be used in conjunction with iup's deimos modules, thus it's a kind of semi-wrapper. Maybe later there will be full-fledged OO wrappers.<br>
In order to ease access to (some relevant) named controls from D, there is a global associatice array: Handle[string] AA; requirements to use fromStringz, toStringz are drastically reduced.
Example tree.d shows some mixed usage (intentially not replacing all functions, that may (often preferably) come from iup_plusD.d); cd examples/C && ./tree.d

The bindings require callback functions to have nothrow attribute.<br>

The accompanying dub.json cares for a basic/minimum set of binaries for IUP usage (libiup.so/iup.dll, libiupcontrols.so/iupcontrols.dll and usage of a replacement libftgl.so on Linux; the all-in toberenameddub.json being the other extreme). This requires, that files concerned (libftgl.so on Linux or import libraries on Windows) are placed within folder /lib substructure. There are README files for more information. Depending on what features are used by an application, more binaries may be required, to be specified in the app's dub.json.

Some C-examples have been translated to D code: cd to directory examples/C or examples/tutorial (make shure, the D files have access right 'execute' and You have rdmd) and run e.g. ./list2.d (The examples use cmdfile, applicable as is for Linux), to be adjusted for Windows).

Have fun with IUP from D


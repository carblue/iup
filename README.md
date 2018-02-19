[![Build Status](https://travis-ci.org/carblue/iup.svg?branch=master)](https://travis-ci.org/carblue/iup)

# iup

D language: A "Deimos"-like binding for IUP, CD and IM

IUP, a Portable graphical User Interface toolkit, source code version 3.24 supported (released 2018-01-22),  http://webserver2.tecgraf.puc-rio.br/iup/<br>
CD, a 2D Graphics Library, source code version 5.11.1 supported (released 2017-07-01),  http://webserver2.tecgraf.puc-rio.br/cd/<br>
IM, an Imaging Toolkit, source code version 3.12 supported (released 2016-09-30),  http://webserver2.tecgraf.puc-rio.br/im/

CD and/or IM may be dispensable, depending on GUI-controls to be used.<br>
After installing IUP, CD and IM, using the script install from a prebuilt '...Libraries' binary, I recommend to download IUP's 'Tools Executables', run it's iuptest and pick some test cases like Sample, Tabs, Expander, Plot... for a live impression of IUP's look and feel. https://sourceforge.net/projects/iup/files/3.24/Tools%20Executables/

Among other features, this GUI toolkit purely focuses on User Interface (no burden of additional classes/structs for strings, containers ...) and has an abstract layout concept (no positioning of controls by X/Y coordinates required, can be independent from screen resolution, but the window size will then depend on the systems setting for the text size).<br>

Current state:<br>
The "C-ish" interface/"Deimos"-like binding  is ready for IUP, CD and virtually for IM.<br>
The "D-ish" interface/wrappers (to be supplied by files iup/iup_plusD.d, cd/cd_plusD.d and im/im_plusD.d) is not yet available/work in progress.<br>

The bindings require callback functions to have nothrow attribute.<br>

The accompanying dub.json cares for a basic/minimum set of binaries for IUP usage (libiup.so/iup.dll, libiupcontrols.so/iupcontrols.dll and usage of a replacement libftgl.so on Linux; the all-in toberenameddub.json being the other extreme). This requires, that files concerned (libftgl.so on Linux or import libraries on Windows) are placed within folder /lib substructure. There are README files for more information. Depending on what features are used by an application, more binaries may be required, to be specified in the apps dub.json.

Some C-examples have been translated to D code: cd to directory examples/C or examples/tutorial (make shure, the D files have access right 'execute' and You have rdmd) and run e.g. ./list2.d (The examples use cmdfile, applicable as is for Linux).

Have fun with IUP from D


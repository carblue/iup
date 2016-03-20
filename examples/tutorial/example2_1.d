#!/usr/bin/rdmd -I../../source/
import std.string : toStringz;
import core.stdc.stdlib : EXIT_SUCCESS;
import iup.iup;

int main(string[] args) { // C: int main(int argc, char **argv)
	char*[] args_carray;
	foreach (s; args)
		args_carray ~= cast(char*) s.toStringz; 
	
	int argc = cast(int) args.length;
	char** argv = args_carray.ptr;

  IupOpen(&argc, &argv);
  
  IupMessage("Hello World 1", "Hello world from IUP.");
  
  IupClose();
  return EXIT_SUCCESS;
}

Each directory contain defined a set of test units for the specified
release variant.The content of the test units sould be disjunct, thus 
have to be performed from the lowest upt to the stringest release level.

The test is just one part of a wider build system based on the classical
Makefiles and requires GNUMake.

A tree structure is processed by recursive calls of sub makes, thus for
now a parallel make with '-j' parameter should be avaoided, even though
it may work.

The environemnt is set by the Makefile of the topmost directory, but when
calling a lower level sub-tree may have to be set manually. 

Following environment variables are required to be set. The general rule 
applies, that each resulting directory-path prefix variable has to be 
terminated by a path seperator - in POSIX a slash '/'.

-> BLD_ROOT - points to topmost directory,
  

Split-off from UnifiedSessionsManager
see: http://sourceforge.net/projects/utalm/

Beta release, should work. 
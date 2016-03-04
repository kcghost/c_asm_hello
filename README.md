c_asm_hello
===========
A neat example program that runs some assembly code inside some C code.

Requirements
------------
The program is made to build and run on x86-64 machines.
Additionally, you will need the utilities `make`,`gcc`,`ld`,`nasm`, and `xxd`.

Details
-------
The makefile compiles two separate executables, `main` and `hello`.
`hello.asm` is compiled differently depending on whether it is to be included into `main` or run as the standalone executable `hello`.
The makefile demonstrates compiling and linking NASM assembly code that exports `_start`, as well as generating a flat form binary.
Automatic prerequisites (.d files) are generated using [the suggested recipe](https://www.gnu.org/software/make/manual/html_node/Automatic-Prerequisites.html) with a slight change; The `-MG` [option](https://gcc.gnu.org/onlinedocs/gcc-4.4.1/gcc/Preprocessor-Options.html) was added so gcc that gcc treats missing includes as generated files.
In this case `main.c` includes `hello.bin.xxd`, which is the flat form binary of `hello.asm` run through xxd to generate a char array.
`main` copies that char array into execuatable memory and executes it as a function.

The makefile makes heavy use of [pattern rules](https://www.gnu.org/software/make/manual/html_node/Pattern-Rules.html) to transform each piece in a generic fashion.
Some of the rules are usually implicitly defined, but it is useful to include them for the sake of clarity and completeness. In fact `make -rR`(no builtins) can be used to build.

Building and Running
--------------------
Just use `make`. To test both standalone assembly and C programs, use `make test`.

License and References
----------------------
[The Unlicense](http://unlicense.org/). This project is truly free, and public domain.

I got the basis for the C code from [this stackoverflow answer](http://stackoverflow.com/questions/9960721/how-to-get-c-code-to-execute-hex-bytecode/9964472#9964472) and I got an assembly trick for reading the instruction pointer from [this other stackoverflow answer.](http://stackoverflow.com/questions/599968/reading-program-counter-directly/599982#599982)
Other references include: 
[the Linux 64 bit system call table](http://blog.rchapman.org/post/36801038863/linux-system-call-table-for-x86-64), 
[the NASM Manual](http://www.nasm.us/doc/), 
[the GNU Make Manual](http://www.gnu.org/software/make/manual/make.html), and
[the GCC Documentation](https://gcc.gnu.org/onlinedocs/)
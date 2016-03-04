NASM      ?= nasm
NASMFLAGS ?=
XXD       ?= xxd
CC        ?= gcc
CFLAGS    ?=
CPPFLAGS  ?=
LDFLAGS   ?=
LOADLIBES ?=
LDLIBS    ?=
LD        ?= ld

sources = main.c

.PHONY : all test clean

all : main hello

test : all
	@echo "Running main..."
	@./main
	@echo "Running hello..."
	@./hello

-include $(sources:.c=.d)

% : %.o
	# Link object that exports 'main' _start is provided by stdlib
	$(CC) $(LDFLAGS) $< $(LOADLIBES) $(LDLIBS) -o $@

%.o : %.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $<

%.d : %.c
	@set -e; rm -f $@; \
	$(CC) -M -MG $(CPPFLAGS) $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$

%.xxd : %
	$(XXD) -i $< $@

%.bin : %.asm
	$(NASM) $(NASMFLAGS) -f bin $< -o $@

% : %.o_start
	# Link object that exports '_start'.
	$(LD) $(LDFLAGS) $< -o $@

%.o_start : %.asm
	$(NASM) $(NASMFLAGS) -f elf64 -dSTANDALONE $< -o $@

clean :
	rm -rf *.bin
	rm -rf *.xxd
	rm -rf *.o
	rm -rf *.d
	rm -rf *.o_start
	rm -rf main
	rm -rf hello

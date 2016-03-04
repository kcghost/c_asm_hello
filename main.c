#include <sys/mman.h>
#include <string.h>
#include <stdio.h>

int main(int argc, char** argv) {
	#include "hello.bin.xxd"
	void* buf;

	// Copy code to executable buffer
	buf = mmap(0, hello_bin_len, PROT_READ|PROT_WRITE|PROT_EXEC,
		MAP_PRIVATE|MAP_ANON, -1, 0);
	memcpy(buf, hello_bin, hello_bin_len);

	// Run code
	printf("About to run assembly code...\n");
	((void (*) (void))buf)();
	printf("Sucessfully ran assembly code.\n");

	return 0;
}

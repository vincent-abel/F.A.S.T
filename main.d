// D Language first test

import std.stdio;
import std.file;
import std.string;

void main(string[] argv)
{
	auto argc = argv.length-1;
	if (argc>=1){
		argc=0;
		while (++argc<argv.length){
		if (exists(argv[argc]))
		{
			File file = File(argv[argc],"r");

			while (!file.eof()) {
				string line = strip(file.readln());
				writeln("read line -> |", line);
			}
		}
		else
			write("Warning : The file \"",argv[argc],"\" is either non-existent or you don't have credentials\n");
		}
	}
}

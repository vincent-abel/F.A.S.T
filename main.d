// D Language first test

import std.stdio;
import std.file;
import std.string;
import parser;
import core.sys.posix.unistd;

void main(string[] argv)
{
	if (isatty(0)) {
		auto argc = argv.length-1;
		if (argc>=1){
			argc=0;
			while (++argc<argv.length){
			if (exists(argv[argc]))
			{
				File file = File(argv[argc],"r");
	
				while (!file.eof()) {
//					string line = strip(file.readln());
					parse(strip(file.readln()));
//					writeln("read line -> |", line);
				}
			}
			else
				write("Warning : The file \"",argv[argc],"\" is either non-existent or you don't have credentials\n");
			}
		}
	}
	else {
		write(isatty(0));
		string line;
		while ((line = readln()) !is null)
			parse(strip(line));
	}
}

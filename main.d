// D Language first test

import std.stdio;

void main(string[] argv)
{
	auto argc = argv.length-1;
	write(argc);
	string line;
        while ((line = readln()) !is null)
        write(line);
}

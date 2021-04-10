// D Language first test

import std.stdio;


void show_test(int a)
{
	writeln("Hello, World!");
	writefln("Ceci est un test: %d", a);
	
}

void main()
{
	auto b=10;
	show_test(b);
}

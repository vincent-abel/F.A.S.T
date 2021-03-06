// Parser Module

module utils.parser;

import utils;
import std.stdio;
import std.string;
import std.file;
import std.regex;

void showFile(string current, string file)
{
	writeln("File : ", current, "\n------------\n<<<", file, ">>>\n------------");
}
/// runFile on the files inputed
void runFile(string current)
{
	string file = cast(string) read(current, (File(current, "r")).size);
	Scanner scanner = new Scanner(file);
}

/// runInline to summmon an interpreter
void runInline()
{
	for (;;)
	{
		write("> ");
		string line = strip(readln());
		if (!line)
			return;
		if (matchAll("quit", line))
			return;
		run(line);
	}
}

/// run general
void run(string line)
{
	writeln("read line -> |", line, "|");
}

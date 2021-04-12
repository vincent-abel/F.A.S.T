// Should be parser module

module utils.parser;

import utils.tokens;
import utils.scanner;
import std.stdio;
import std.string;
import std.file;
import std.regex;

/// runFile on the files inputed
void runFile(string current) {
			string file = cast(string)read(current,(File(current, "r")).size);
	        writeln("File : ",current,"\n--------------\n<<<", file,">>>\n--------------");
}

/// runInline to summmon an interpreter
void runInline() {
	for (;;) {
		write("> ");
		string line = strip(readln());
		if (!line) return;
		if (matchAll("quit",line)) return;
		run(line);
	}
}

/// run general
void run(string line) {
	Scanner scanner = new Scanner(line);

	Tokens tokens = scanner.scanToken();

	writeln("read line -> |", line,"|");
}
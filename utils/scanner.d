// Scanner Module

module utils.scanner;

import std.stdio;
import std.string;
import std.regex;

/// runFile on the files inputed
void runFile(string current) {

	        writeln("read line -> |", current,"|");
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
	writeln("read line -> |", line,"|");
}

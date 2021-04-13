// Scanner Module

module utils.scanner;

import utils;

import std.stdio;
import std.string;
import std.file;
import std.regex;

/// Scanner Class
class Scanner {
	/// source is storing the whole file
	string source;

	/// trivial constructor for Scanner Class
	this(string source) {
		this.source = source;
	}

	/// Implementation of scanToken, returning tokens.
	Lexer scanToken(string str)
	{
		Lexer lexer = new Lexer(cast(char *)str);
		write("ScanScan");
		return lexer;
	}
}
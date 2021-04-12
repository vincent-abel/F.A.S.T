// Scanner Module

module utils.scanner;

import utils.tokens;

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
	Tokens scanToken()
	{
		Tokens sth = new Tokens();
		write("ScanScan");
		return sth;
	}
}
// Scanner Module

module utils.scanner;

import utils;

import std.stdio;
import std.string;
import std.file;
import std.regex;
import std.conv;
import std.ascii;

/// Scanner Class
class Scanner {
	/// source is storing the whole file
	string source;
	/// index inside the source
	int index;
	/// will keep the line
	int line;
	/// Storing all the tokens here
	Tokens[] ltoken;

	/// trivial constructor for Scanner Class
	this(string source) {
		this.source = source;
		this.index = 0;
		this.scan();
	}

	/// peek get the next char if possible
	char peek(string source, int offset) {
		return source[this.index+offset];
	}

	void skip_to_newline() {
		while(source[this.index] != '\n') {
			this.index +=1;
		}
	}

	void next() {
		while (this.index < source.length) {
			string value;
			while (isAlphaNum(source[index])) {
			value ~= this.source[index];
			this.index++;
			}
			this.index++;
			if (value != "") {
				this.ltoken = this.ltoken ~ init_token(value);
			}
			return;
		}
		return;
	}
	/// Implementation of scan.
	void scan() {

		while (this.index < source.length)
		{
			switch(source[this.index]) {
				case '/': {
					if (peek(source,1) == '/') {
						this.skip_to_newline(); 
						
					}

				}
				
				default: {
					this.next();
				//write(source[this.index++]);
				}
			}
//			write("|",source[this.index],"|");
		}
	write(this.ltoken);
	}
}
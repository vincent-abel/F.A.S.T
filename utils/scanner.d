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
		int i= this.index;
		if (i+offset < source.length)
			return source[i+offset];
		return 0;
	}

	void skip_to_newline() {
		while(source[this.index] != '\n') {
			this.index +=1;
		}
	}
	/// implementation of next token 
	//// Contains the flagged part to skip not usefull non alphanum
	void next() {
		bool flag=0;
		while (this.index < source.length) {
			string value;
			while (!isAlphaNum(source[index]))
			{
				flag=true;
				this.index++;
			} if (flag) return;
			while (isAlphaNum(source[index])) {
				value ~= this.source[index];
				this.index++;
			}
			if (value != "") {
				this.ltoken = this.ltoken ~ init_token(value);
			}
			return;
		}
		return;
	}

	void nextUnary() {
		string value;
		if (this.index < this.source.length) {
			value ~= this.source[this.index];
			
			this.ltoken = this.ltoken ~ init_token(value);
			
			this.index = this.index + 1;
		}
	}

	void nextDouble() {
		string value;

		value ~= this.source[this.index];
		this.index++;
		value ~= this.source[this.index];
		this.index++;
		this.ltoken = this.ltoken ~ init_token(value);

		return;
	}
	void nextTriple() {
		string value;
		value ~= this.source[this.index];
		this.index++;
		value ~= this.source[this.index];
		this.index++;
		value ~= this.source[this.index];
		this.index++;
		this.ltoken = this.ltoken ~ init_token(value);

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
					} else if (peek(source,1) == '=') {
						this.nextDouble();
					} else this.nextUnary();
					break;
				}
				case '=': {
					if (peek(source,1) == '=') {
						this.nextDouble();
					} else { 
						this.nextUnary();
					}
					break;
				}
				case '(': {this.nextUnary();break;}
				case ')': {this.nextUnary();break;}
				case '{': {this.nextUnary();break;}
				case '}': {this.nextUnary();break;}
				case '[': {this.nextUnary();break;}
				case ']': {this.nextUnary();break;}
				case ';': {this.nextUnary();break;}
				case ',': {this.nextUnary();break;}
				case ' ': {this.index++;break;}
				case '.': {this.nextUnary();break;}
				case '+': {
					if (peek(source,1) == '+') {
						this.nextDouble();
					} else if (peek(source,1) == '=') {
						this.nextDouble();
					} else this.nextUnary();
					break;
				}
				case '-': {
					if (peek(source,1) == '-') {
						this.nextDouble();
					} else this.nextUnary();
					break;
				}
				case '*': {this.nextUnary();break;}
				case '%':{
					if (peek(source,1) == '=') {
						this.nextDouble();
					} else this.nextUnary();
					break;
				}
				case '^': {
					if (peek(source,1) == '=') {
						this.nextDouble();
					} else this.nextUnary();
					break;
				}
				case '~': {this.nextUnary();break;}
				case '<': {
					if (peek(source,1) == '=') {
						this.nextDouble();
					} else if (peek(source,1) == '<') {
						if  (peek(source,2) == '=') {
						this.nextTriple();
						} else this.nextDouble();
					}
					else this.nextUnary();
					break;
				}
				case '>': {
					if (peek(source,1) == '=') {
						this.nextDouble();
					} else if (peek(source,1) == '>') {
						if  (peek(source,2) == '=') {
						this.nextTriple();
						} else this.nextDouble();
					}
					else this.nextUnary();
					break;
				}
				case '!': {
					if (peek(source,1) == '=') {
						this.nextDouble();
					} else this.nextUnary();
					break;
				}
				case '&': {
					if (peek(source,1) == '&') {
						this.nextDouble();
					} else if (peek(source,1) == '=') {
						this.nextDouble();
					} else this.nextUnary();
					break;
				}
				case '|': {
					if (peek(source,1) == '|') {
						this.nextDouble();
					} else if (peek(source,1) == '=') {
						this.nextDouble();
					} else this.nextUnary();
					break;
				}
				case '?': {this.nextUnary();break;}
				case ':': {this.nextUnary();break;}
				case '\n': {this.index++;break;}
				case '\r': {this.index++;break;}
				case '\t': {this.index++;break;}
				default: {
					this.next();
					break;
				//write(source[this.index++]);
				}
			}
//			write("|",source[this.index],"|");
		}
//	write(this.ltoken);
	}
}
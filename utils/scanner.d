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
class Scanner
{
	/// source is storing the whole file
	string source;
	/// index inside the source
	int index;
	/// will keep the line
	int line = 1;
	/// Storing all the tokens here
	Tokens[] ltoken;

	/// trivial constructor for Scanner Class
	this(string source)
	{
		this.source = source;
		this.index = 0;
		this.scan();
	}

	/// peek get the next char if possible
	char peek(string source, int offset)
	{
		if (this.index + offset < source.length)
			return source[index + offset];
		return 0;
	}

	void error(int line, string message)
	{
		writeln("Line ", line, " :", message);
	}

	void skip_to_newline()
	{
		while (source[this.index] != '\n')
		{
			this.index += 1;
		}
	}
	/// implementation of next token 
	//// Contains the flagged part to skip not usefull non alphanum
	void next()
	{
		bool flag = 0;
		bool digit = 0;
		while (this.index < source.length)
		{
			string value;
			while (isDigit(source[index]) || (digit && source[index]=='.' && isDigit(peek(source,1))))
			{
				digit = true;
				value ~= this.source[index];
				this.index++;
			} 
			if (digit)
			{
				this.ltoken = this.ltoken ~ init_token(value);
				return;
			}

			while (!isAlphaNum(source[index]) && source[index] != '_')
			{
				flag = true;
				this.index++;
			}
			if (flag)
				return;
			while (isAlphaNum(source[index]) || source[index] == '_')
			{
				value ~= this.source[index];
				this.index++;
			}
			if (value != "")
			{
				this.ltoken = this.ltoken ~ init_token(value);
				return;
			}

			return;
		}
		return;
	}

	void nextUnary()
	{
		string value;
		if (this.index < this.source.length)
		{
			value ~= this.source[this.index];

			this.ltoken = this.ltoken ~ init_token(value);

			this.index = this.index + 1;
		}
	}

	void nextDouble()
	{
		string value;

		value ~= this.source[this.index];
		this.index++;
		value ~= this.source[this.index];
		this.index++;
		this.ltoken = this.ltoken ~ init_token(value);

		return;
	}

	void nextTriple()
	{
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

	void nextLiteral()
	{
		string value;
		if (this.index < source.length)
		{
			value ~= source[index++];
			while (this.index < source.length)
			{
				if (this.index - 1 != 0 && peek(source, -1) != '\\')
				{
					if (this.source[index] == value[0] && value != "")
					{
						value ~= this.source[index];
						this.ltoken = this.ltoken ~ init_token(value);
						this.index++;
						return;
					}
				}
				value ~= this.source[index];
				this.index++;
			}
			if (this.index == source.length)
				this.error(line, "No matching '\"' found ");
			return;
		}
	}
	/// Implementation of scan.
	void scan()
	{
		string value;
		value ~= '\0';
		while (this.index < source.length)
		{
			switch (source[this.index])
			{
			case '/':
				{
					if (peek(source, 1) == '/')
					{
						this.skip_to_newline();
					}
					else if (peek(source, 1) == '=')
					{
						this.nextDouble();
					}
					else
						this.nextUnary();
					break;
				}
			case '=':
				{
					if (peek(source, 1) == '=')
					{
						this.nextDouble();
					}
					else
					{
						this.nextUnary();
					}
					break;
				}
			case '(':
				{
					this.nextUnary();
					break;
				}
			case ')':
				{
					this.nextUnary();
					break;
				}
			case '{':
				{
					this.nextUnary();
					break;
				}
			case '}':
				{
					this.nextUnary();
					break;
				}
			case '[':
				{
					this.nextUnary();
					break;
				}
			case ']':
				{
					this.nextUnary();
					break;
				}
			case ';':
				{
					this.nextUnary();
					break;
				}
			case ',':
				{
					this.nextUnary();
					break;
				}
			case ' ':
				{
					this.index++;
					break;
				}
			case '.':
				{
					this.nextUnary();
					break;
				}
			case '+':
				{
					if (peek(source, 1) == '+')
					{
						this.nextDouble();
					}
					else if (peek(source, 1) == '=')
					{
						this.nextDouble();
					}
					else
						this.nextUnary();
					break;
				}
			case '-':
				{
					if (peek(source, 1) == '-')
					{
						this.nextDouble();
					}
					else
						this.nextUnary();
					break;
				}
			case '*':
				{
					this.nextUnary();
					break;
				}
			case '%':
				{
					if (peek(source, 1) == '=')
					{
						this.nextDouble();
					}
					else
						this.nextUnary();
					break;
				}
			case '^':
				{
					if (peek(source, 1) == '=')
					{
						this.nextDouble();
					}
					else
						this.nextUnary();
					break;
				}
			case '~':
				{
					this.nextUnary();
					break;
				}
			case '<':
				{
					if (peek(source, 1) == '=')
					{
						this.nextDouble();
					}
					else if (peek(source, 1) == '<')
					{
						if (peek(source, 2) == '=')
						{
							this.nextTriple();
						}
						else
							this.nextDouble();
					}
					else
						this.nextUnary();
					break;
				}
			case '>':
				{
					if (peek(source, 1) == '=')
					{
						this.nextDouble();
					}
					else if (peek(source, 1) == '>')
					{
						if (peek(source, 2) == '=')
						{
							this.nextTriple();
						}
						else
							this.nextDouble();
					}
					else
						this.nextUnary();
					break;
				}
			case '!':
				{
					if (peek(source, 1) == '=')
					{
						this.nextDouble();
					}
					else
						this.nextUnary();
					break;
				}
			case '&':
				{
					if (peek(source, 1) == '&')
					{
						this.nextDouble();
					}
					else if (peek(source, 1) == '=')
					{
						this.nextDouble();
					}
					else
						this.nextUnary();
					break;
				}
			case '|':
				{
					if (peek(source, 1) == '|')
					{
						this.nextDouble();
					}
					else if (peek(source, 1) == '=')
					{
						this.nextDouble();
					}
					else
						this.nextUnary();
					break;
				}
			case '?':
				{
					this.nextUnary();
					break;
				}
			case ':':
				{
					this.nextUnary();
					break;
				}
			case '\n':
				{
					line++;
					this.index++;
					break;
				}
			case '\r':
				{
					this.index++;
					break;
				}
			case '\t':
				{
					this.index++;
					break;
				}
			case '"':
				{
					if (this.index - 1 != 0)
					{
						if (peek(source, -1) != '\\')
						{
							this.nextLiteral();

						}
					}
				}
			default:
				{
					this.next();
					break;
					//write(source[this.index++]);
				}
			}
			//			write("|",source[this.index],"|");
		}
		init_token(value);
		//	write(this.ltoken);
	}
}

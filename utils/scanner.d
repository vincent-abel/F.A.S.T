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
	void next(int type)
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
				this.ltoken = this.ltoken ~ init_token(value,tk_type.NUMERIC);
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
				this.ltoken = this.ltoken ~ init_token(value,tk_type.IDENTIFIERS);
				return;
			}

			return;
		}
		return;
	}

	void nextUnary(int type)
	{
		string value;
		if (this.index < this.source.length)
		{
			value ~= this.source[this.index];

			this.ltoken = this.ltoken ~ init_token(value,type);

			this.index = this.index + 1;
		}
	}

	void nextDouble(int type)
	{
		string value;

		value ~= this.source[this.index];
		this.index++;
		value ~= this.source[this.index];
		this.index++;
		this.ltoken = this.ltoken ~ init_token(value);

		return;
	}

	void nextTriple(int type)
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

	void nextLiteral(int type)
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
						this.nextDouble(tk_type.TOKEN_DIVASSIGN);
					}
					else
						this.nextUnary(tk_type.TOKEN_SLASH);
					break;
				}
			case '=':
				{
					if (peek(source, 1) == '=')
					{
						this.nextDouble(tk_type.TOKEN_EQUALS);
					}
					else
					{
						this.nextUnary(tk_type.TOKEN_ASSIGN);
					}
					break;
				}
			case '(':
				{
					this.nextUnary(tk_type.TOKEN_LPAREN);
					break;
				}
			case ')':
				{
					this.nextUnary(tk_type.TOKEN_RPAREN);
					break;
				}
			case '{':
				{
					this.nextUnary(tk_type.TOKEN_LBRACE);
					break;
				}
			case '}':
				{
					this.nextUnary(tk_type.TOKEN_RBRACE);
					break;
				}
			case '[':
				{
					this.nextUnary(tk_type.TOKEN_LBRACK);
					break;
				}
			case ']':
				{
					this.nextUnary(tk_type.TOKEN_RBRACK);
					break;
				}
			case ';':
				{
					this.nextUnary(tk_type.TOKEN_SEMI);
					break;
				}
			case ',':
				{
					this.nextUnary(tk_type.TOKEN_COMMA);
					break;
				}
			case ' ':
				{
					this.index++;
					break;
				}
			case '.':
				{
					this.nextUnary(tk_type.TOKEN_DOT);
					break;
				}
			case '+':
				{
					if (peek(source, 1) == '+')
					{
						this.nextDouble(tk_type.TOKEN_INCREMENT);
					}
					else if (peek(source, 1) == '=')
					{
						this.nextDouble(tk_type.TOKEN_ADDASSIGN);
					}
					else
						this.nextUnary(tk_type.TOKEN_ADD);
					break;
				}
			case '-':
				{
					if (peek(source, 1) == '-')
					{
						this.nextDouble(tk_type.TOKEN_DECREMENT);
					}
					else
						this.nextUnary(tk_type.TOKEN_MINUS);
					break;
				}
			case '*':
				{
					this.nextUnary(tk_type.TOKEN_MULT);
					break;
				}
			case '%':
				{
					if (peek(source, 1) == '=')
					{
						this.nextDouble(tk_type.TOKEN_MODASSIGN);
					}
					else
						this.nextUnary(tk_type.TOKEN_MODULO);
					break;
				}
			case '^':
				{
					if (peek(source, 1) == '=')
					{
						this.nextDouble(tk_type.TOKEN_BITXOR);
					}
					else
						this.nextUnary(tk_type.TOKEN_POWER);
					break;
				}
			case '~':
				{
					this.nextUnary(tk_type.TOKEN_BITFLIP);
					break;
				}
			case '<':
				{
					if (peek(source, 1) == '=')
					{
						this.nextDouble(tk_type.TOKEN_LTOEQ);
					}
					else if (peek(source, 1) == '<')
					{
						if (peek(source, 2) == '=')
						{
							this.nextTriple(tk_type.TOKEN_LSHIFT);
						}
						else
							this.nextDouble(tk_type.TOKEN_LBITFLIP);
					}
					else
						this.nextUnary(tk_type.TOKEN_LT);
					break;
				}
			case '>':
				{
					if (peek(source, 1) == '=')
					{
						this.nextDouble(tk_type.TOKEN_GTOEQ);
					}
					else if (peek(source, 1) == '>')
					{
						if (peek(source, 2) == '=')
						{
							this.nextTriple(tk_type.TOKEN_RSHIFT);
						}
						else
							this.nextDouble(tk_type.TOKEN_RBITFLIP);
					}
					else
						this.nextUnary(tk_type.TOKEN_GT);
					break;
				}
			case '!':
				{
					if (peek(source, 1) == '=')
					{
						this.nextDouble(tk_type.TOKEN_NEQUAL);
					}
					else
						this.nextUnary(tk_type.TOKEN_NOT);
					break;
				}
			case '&':
				{
					if (peek(source, 1) == '&')
					{
						this.nextDouble(tk_type.TOKEN_AND);
					}
					else if (peek(source, 1) == '=')
					{
						this.nextDouble(tk_type.TOKEN_BITAND);
					}
					else
						this.nextUnary(tk_type.TOKEN_RETADDR);
					break;
				}
			case '|':
				{
					if (peek(source, 1) == '|')
					{
						this.nextDouble(tk_type.TOKEN_OR);
					}
					else if (peek(source, 1) == '=')
					{
						this.nextDouble(tk_type.TOKEN_BITOR);
					}
					else
						this.nextUnary(tk_type.TOKEN_PIPE);
					break;
				}
			case '?':
				{
					this.nextUnary(tk_type.TOKEN_QUESMARK);
					break;
				}
			case ':':
				{
					this.nextUnary(tk_type.TOKEN_COLON);
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
							this.nextLiteral(tk_type.TOKEN_LITERAL);

						}
					}
				}
			default:
				{
					this.next(0);
					break;
					//write(source[this.index++]);
				}
			}
			//			write("|",source[this.index],"|");
		}
		init_token(value,tk_type.EOF);
		//	write(this.ltoken);
	}
}

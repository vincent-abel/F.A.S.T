// Tokens Module, containing the tokens structs and functions

module utils.tokens;

import std.stdio;
import std.conv;

/// a little enum to keep track of all token types
enum tktype {
    TOKEN_ID,
    TOKEN_EQUALS,
    TOKEN_LPAREN,
    TOKEN_RPAREN,
    TOKEN_LBRACE,
    TOKEN_RBRACE,
    TOKEN_LBRACK,
    TOKEN_RBRACK,
    TOKEN_COLON,
    TOKEN_COMMA,
    TOKEN_LT,
    TOKEN_GT,
    TOKEN_DOT,
    TOKEN_GTOEQ,
    TOKEN_LTOEQ,
    TOKEN_INT,
    TOKEN_SEMI,
    TOKEN_DIVASSIGN,
    TOKEN_ASSIGN,
    TOKEN_INCREMENT,
    TOKEN_DECREMENT,
    TOKEN_ADD,
    TOKEN_MINUS,
    TOKEN_MULT,
    TOKEN_ADDASSIGN,
    TOKEN_MODASSIGN,
    TOKEN_MODULO,
    TOKEN_BITOR,
    TOKEN_POWER,
    TOKEN_BITFLIP,
    TOKEN_LSHIFT,
    TOKEN_LBITFLIP,
    TOKEN_RSHIFT,
    TOKEN_RBITFLIP,
    TOKEN_NEQUAL,
    TOKEN_NOT,
    TOKEN_AND,
    TOKEN_BITAND,
    TOKEN_RETADDR,
    TOKEN_OR,
    TOKEN_BITXOR,
    TOKEN_PIPE,
    TOKEN_QUESMARK,
    TOKEN_SLASH,
    TOKEN_LITERAL,
    IDENTIFIERS,
    NUMERIC,
    STRING,
    KEYWORD,
    EOF,
}
/// Definition of the Tokens
struct Tokens {
    /// Tokens value
    string value;
    /// Tokens type
    int type;

}


/// Tokens init_token(string value)
/// deprecated
deprecated Tokens init_token(string value)
{
    Tokens token = Tokens();
    token.value ~= value;
    writeln(token," ",token.type);
    return token;
}
/// Tokens init_token(string value, int type)
/// Init a token with value and type.
Tokens init_token(string value, int type)
{
    Tokens token = Tokens();
    token.value ~= value;
    token.type = type;    
    writeln(token," ",token.type);
    return token;
}
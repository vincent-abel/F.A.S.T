// Tokens Module, containing the tokens class
import std.stdio;

struct Tokens {
    string value;
	enum type : int{
        TOKEN_ID,
        TOEKN_EQUALS,
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
        TOKEN_GTOEQ,
        TOKEN_LTOEQ,
        TOKEN_INT,
        TOKEN_SEMI,
    }

}

Tokens init_token(string value)
{
    Tokens token = Tokens();
    token.value = value;
    writeln(token);
    return token;
}
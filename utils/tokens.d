// Tokens Module, containing the tokens class

typedef struct Tokens {
    char *value;
	enum type {
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
    };


}
Tokens *init_token(char *value, int type)
{
    Tokens token = Tokens();
    token.value = value;
    token.type = type;

    return token;
}
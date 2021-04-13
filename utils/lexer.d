module utils.lexer;

import std.string;
import std.conv;
import std.ascii;
import utils;

class Lexer {
    char *src;
    size_t size;
    char    c;
    int     i;

    this(char *src) {
        this.src = src;
        this.i = 0;
        this.size = (to!string(src)).length;
        this.c = src[this.i];

    }



}

    Lexer init_lexer(char *src) {
        Lexer lexer = new Lexer(src);
        return lexer;
    }

    void lexer_advance(Lexer lexer){
        if (lexer.i < lexer.size && lexer.c != '\0') {
            lexer.i += 1;
            lexer.c = lexer.src[lexer.i];
        }
    }

    void lexer_skip_whitespace(Lexer lexer) {
        while (lexer.c == 13 || lexer.c == 10 || lexer.c == ' ' || lexer.c == '\t')
            lexer_advance(lexer);
    }

    Tokens lexer_parse_id(Lexer lexer)
    {
        char *value;
        while (isAlphaNum(lexer.c)) {
            value = cast(char *)(lexer.c,0);
            lexer_advance(lexer);
        }
        return init_token(value, 0);
    }

    Tokens lexer_advance_with(Lexer lexer, Tokens token) {
        lexer_advance(lexer);
        return token;
    }

    Tokens lexer_next_token(Lexer lexer) {
        while (lexer.c != '\0') {
            if (isAlphaNum(lexer.c))
                return lexer_advance_with(lexer, lexer_parse_id(lexer));
        }
        return new Tokens();
    }
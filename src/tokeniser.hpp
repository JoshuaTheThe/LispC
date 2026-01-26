#ifndef TOKENISER_HPP
#define TOKENISER_HPP

#include <iostream>
#include <fstream>
#include <vector>
#include <array>
#include <string>
#include <string_view>

class Tokeniser
{
public:
        enum TokenType
        {
                TYPE_NONE, /* Error // EOF */
                TYPE_NUMBER,
                TYPE_STRING,
                TYPE_IDENTIFIER,
                TYPE_LPAREN,
                TYPE_RPAREN,
                TYPE_KEYWORD,
        };

        struct Token
        {
                TokenType Type = Tokeniser::TYPE_NONE;
                std::string Identifier = "";
                int64_t Integer = 0;
        };

private:
        const std::array<std::string, 26> Keywords =
            {
                "fn", "if", "declare", "struct", "set", "sete", "element", "add", "sub", "mul", "div", "mod", "eq", "neq", "lt", "gt", "lte", "gte", "deref", "setderef", "and", "or", "xor", "not", "alloca", "extern"
            };
        std::string_view Input;
        std::vector<Token> Output;
        size_t Position;
public:
        ~Tokeniser() = default;
        Tokeniser(std::string_view Input);
        Tokeniser::Token Tokenise(void);
        std::vector<Tokeniser::Token> Fetch(void);
        bool IsWhiteSpace(char X);
        char Advance(void);
        Tokeniser::Token TokeniseNumber(char X);
        Tokeniser::Token TokeniseIdentifier(char X);
        Tokeniser::Token TokeniseString(char X);
};

#endif

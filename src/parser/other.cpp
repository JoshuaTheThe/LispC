#include "parser.hpp"

Tokeniser::Token Parser::Peek(void)
{
        if (Position < Tokens.size())
                return Tokens[Position];
        return Tokeniser::Token{};
}

Tokeniser::Token Parser::Consume(void)
{
        if (Position < Tokens.size())
                return Tokens[Position++];
        return Tokeniser::Token{};
}

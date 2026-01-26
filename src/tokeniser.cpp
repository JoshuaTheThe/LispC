#include "tokeniser.hpp"

bool Tokeniser::IsWhiteSpace(char X)
{
        return (X == ' ') || (X == '\t') || (X == '\n') || (X == '\r');
}

char Tokeniser::Advance(void)
{
        return this->Input[this->Position++];
}

Tokeniser::Token Tokeniser::TokeniseNumber(char X)
{
        Tokeniser::Token Token{.Type = Tokeniser::TYPE_NUMBER, .Integer = 0};
        while (X >= '0' && X <= '9' && this->Position <= this->Input.size())
        {
                Token.Integer = Token.Integer * 10 + X - '0';
                X = this->Advance();
        }

        this->Position -= 1;
        return Token;
}

Tokeniser::Token Tokeniser::TokeniseIdentifier(char X)
{
        Tokeniser::Token Token{.Type = Tokeniser::TYPE_IDENTIFIER, .Integer = 0};
        while (((X >= 'A' && X <= 'Z') || (X >= 'a' && X <= 'z') || X == '_' || X == '-') && this->Position <= this->Input.size())
        {
                if  (X == '-')
                {
                        X = '_';
                }
                std::string Y{X};
                Token.Identifier.append(Y);
                X = this->Advance();
        }

        for (auto &k : this->Keywords)
        {
                if (Token.Identifier == k)
                {
                        Token.Type = Tokeniser::TYPE_KEYWORD;
                }
        }

        this->Position -= 1;
        return Token;
}

Tokeniser::Token Tokeniser::TokeniseString(char X)
{
        Tokeniser::Token Token;
        Token.Type = Tokeniser::TYPE_STRING;

        while (this->Position < this->Input.size())
        {
                char C = this->Advance();

                if (C == '"')
                        break;

                if (C == '\\')
                {
                        if (this->Position >= this->Input.size())
                                break;

                        char Esc = this->Advance();
                        switch (Esc)
                        {
                        case 'n':
                                Token.Identifier += '\n';
                                break;
                        case 't':
                                Token.Identifier += '\t';
                                break;
                        case '"':
                                Token.Identifier += '\"';
                                break;
                        case '\\':
                                Token.Identifier += '\\';
                                break;
                        default:
                                Token.Identifier += Esc;
                                break;
                        }
                }
                else
                {
                        Token.Identifier += C;
                }
        }

        return Token;
}

Tokeniser::Token Tokeniser::Tokenise(void)
{
        Tokeniser::Token Token;
        char X;
        do
        {
                X = this->Advance();
        } while (this->IsWhiteSpace(X) && this->Position < this->Input.size());

        switch (X)
        {
        case '(':
                Token.Type = Tokeniser::TYPE_LPAREN;
                break;
        case ')':
                Token.Type = Tokeniser::TYPE_RPAREN;
                break;
        case '"':
                Token.Type = Tokeniser::TYPE_STRING;
                return TokeniseString(X);
        default:
                break;
        }

        if (X >= '0' && X <= '9')
        {
                Token = this->TokeniseNumber(X);
        }
        else if ((X >= 'A' && X <= 'Z') || (X >= 'a' && X <= 'z') || X == '_')
        {
                Token = this->TokeniseIdentifier(X);
        }

        return Token;
}

Tokeniser::Tokeniser(std::string_view Input)
{
        this->Position = 0;
        this->Input = Input;
        this->Output.clear();
        // std::cout << this->Input.size() << std::endl;
        while (this->Position < this->Input.size())
                this->Output.push_back(this->Tokenise());
}

std::vector<Tokeniser::Token> Tokeniser::Fetch(void)
{
        return this->Output;
}

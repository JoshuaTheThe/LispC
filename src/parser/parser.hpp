#ifndef PARSER_H
#define PARSER_H

#include <iostream>
#include <fstream>
#include <vector>
#include <array>
#include <string>
#include <string_view>
#include "../tokeniser.hpp"

class AST
{
public:
        enum ASTType
        {
                AST_FUNCTION,
                AST_BODY,
                AST_NUMBER,
                AST_IDENTIFIER,
                AST_CALL,
                AST_SET,
                AST_DECLARE,
                AST_IF,
                AST_STRING,
                AST_EXTERN,
        };

private:
        ASTType Type;
        std::string Identifier;
        int64_t Number;
        std::vector<AST *> Children;

public:
        std::vector<std::string> FunctionArguments; /* Only used when defining a function */
        AST(ASTType type) : Type(type), Number(0) {}
        AST(int64_t num) : Type(AST_NUMBER), Number(num) {}
        AST(const std::string &id, ASTType type) : Type(type), Identifier(id) {}

        void AddChild(AST *child) { Children.push_back(child); }
        const std::vector<AST *> &GetChildren() const { return Children; }
        ASTType GetType() const { return Type; }
        const std::string &GetIdentifier() const { return Identifier; }
        int64_t GetNumber() const { return Number; }

        ~AST()
        {
                for (AST *child : Children)
                {
                        delete child;
                }
        }
};

class Parser
{
        std::vector<Tokeniser::Token> Tokens;
        size_t Position;

public:
        Parser(const std::vector<Tokeniser::Token> &tokens) : Tokens(tokens), Position(0) {}

        AST *ParseExpression(void);
        AST *ParsePrimary(void);
        AST *ParseFunction(void);
        AST *ParseIf(void);
        AST *ParseExtern(void);
        Tokeniser::Token Peek(void);
        Tokeniser::Token Consume(void);
};

#endif

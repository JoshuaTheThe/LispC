#include "parser.hpp"

AST *Parser::ParseFunction(void)
{
        Tokeniser::Token tok = Consume();
        AST *fnNode = new AST(Peek().Identifier, AST::AST_FUNCTION);

        if (Peek().Type == Tokeniser::TYPE_IDENTIFIER)
        {
                Tokeniser::Token nameTok = Consume();
        }
        else
        {
                std::cerr << "Error: function missing name!" << std::endl;
                return nullptr;
        }

        fnNode->FunctionArguments.clear();
        while (Peek().Type == Tokeniser::TYPE_IDENTIFIER)
        {
                fnNode->FunctionArguments.push_back(Consume().Identifier);
        }

        while (Peek().Type != Tokeniser::TYPE_RPAREN && Peek().Type != Tokeniser::TYPE_NONE)
        {
                fnNode->AddChild(ParseExpression());
        }

        return fnNode;
}

AST *Parser::ParseExtern(void)
{
        Tokeniser::Token tok = Consume();
        AST *fnNode = new AST(Peek().Identifier, AST::AST_EXTERN);

        if (Peek().Type == Tokeniser::TYPE_IDENTIFIER)
        {
                Tokeniser::Token nameTok = Consume();
        }
        else
        {
                std::cerr << "Error: function missing name!" << std::endl;
                return nullptr;
        }

        fnNode->FunctionArguments.clear();
        while (Peek().Type == Tokeniser::TYPE_IDENTIFIER)
        {
                fnNode->FunctionArguments.push_back(Consume().Identifier);
        }

        return fnNode;
}

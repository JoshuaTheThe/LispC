#include "parser.hpp"

AST *Parser::ParseIf(void)
{
        Consume();

        AST *ifNode = new AST(AST::AST_IF);
        ifNode->AddChild(ParseExpression());
        ifNode->AddChild(ParseExpression());

        if (Peek().Type != Tokeniser::TYPE_RPAREN && Peek().Type != Tokeniser::TYPE_NONE)
        {
                ifNode->AddChild(ParseExpression());
        }

        return ifNode;
}

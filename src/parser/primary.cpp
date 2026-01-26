#include "parser.hpp"

AST *Parser::ParseStruct(void)
{
        Tokeniser::Token tok = Consume();
        AST *fnNode = new AST(Peek().Identifier, AST::AST_STRUCT);

        if (Peek().Type == Tokeniser::TYPE_IDENTIFIER)
        {
                Tokeniser::Token nameTok = Consume();
        }
        else
        {
                std::cerr << "Error: structure missing name!" << std::endl;
                return nullptr;
        }

        fnNode->FunctionArguments.clear();
        while (Peek().Type == Tokeniser::TYPE_IDENTIFIER)
        {
                /* Reused field */
                fnNode->FunctionArguments.push_back(Consume().Identifier);
        }

        return fnNode;
}

AST *Parser::ParsePrimary(void)
{
        Tokeniser::Token tok = Peek();

        if (tok.Type == Tokeniser::TYPE_NUMBER)
        {
                Consume();
                return new AST(tok.Integer);
        }
        else if (tok.Type == Tokeniser::TYPE_IDENTIFIER)
        {
                Consume();
                return new AST(tok.Identifier, AST::AST_IDENTIFIER);
        }
        else if (tok.Type == Tokeniser::TYPE_STRING)
        {
                Consume();
                return new AST(tok.Identifier, AST::AST_STRING);
        }
        else if (tok.Type == Tokeniser::TYPE_LPAREN)
        {
                Consume();
                Tokeniser::Token first = Peek();
                AST *node = nullptr;

                if (first.Type == Tokeniser::TYPE_KEYWORD)
                {
                        if (first.Identifier == "fn")
                        {
                                node = ParseFunction();
                        }
                        else if (first.Identifier == "if")
                        {
                                node = ParseIf();
                        }
                        else if (first.Identifier == "extern")
                        {
                                node = ParseExtern();
                        }
                        else if (first.Identifier == "struct")
                        {
                                node = ParseStruct();
                        }
                        else if (first.Identifier == "declare")
                        {
                                Consume();
                                auto name = Consume();
                                if (name.Type != Tokeniser::TYPE_IDENTIFIER)
                                {
                                        std::cerr << "Error: Syntax error" << std::endl;
                                }
                                node = new AST(name.Identifier, AST::AST_DECLARE);
                        }
                        else if (first.Identifier == "set")
                        {
                                Consume();
                                auto name = Consume();
                                if (name.Type != Tokeniser::TYPE_IDENTIFIER)
                                {
                                        std::cerr << "Error: Syntax error" << std::endl;
                                }
                                node = new AST(name.Identifier, AST::AST_SET);
                                if (Peek().Type != Tokeniser::TYPE_RPAREN && Peek().Type != Tokeniser::TYPE_NONE)
                                {
                                        node->AddChild(ParseExpression());
                                }
                        }
                        else
                        {
                                Tokeniser::Token tok = Consume();
                                node = new AST(tok.Identifier, AST::AST_CALL);
                                while (Peek().Type != Tokeniser::TYPE_RPAREN && Peek().Type != Tokeniser::TYPE_NONE)
                                {
                                        node->AddChild(ParseExpression());
                                }
                        }
                }
                else if (first.Type == Tokeniser::TYPE_IDENTIFIER)
                {
                        Tokeniser::Token tok = Consume();
                        node = new AST(tok.Identifier, AST::AST_CALL);
                        while (Peek().Type != Tokeniser::TYPE_RPAREN && Peek().Type != Tokeniser::TYPE_NONE)
                        {
                                node->AddChild(ParseExpression());
                        }
                }
                else
                {
                        node = new AST(AST::AST_BODY);
                        while (Peek().Type != Tokeniser::TYPE_RPAREN && Peek().Type != Tokeniser::TYPE_NONE)
                        {
                                node->AddChild(ParseExpression());
                        }
                }

                if (Peek().Type == Tokeniser::TYPE_RPAREN)
                {
                        Consume();
                }
                else
                {
                        std::cerr << "Error: expected ')'!" << std::endl;
                }

                return node;
        }

        std::cerr << "Error: unexpected token in ParsePrimary!" << std::endl;
        return nullptr;
}

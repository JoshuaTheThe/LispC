#include "parser.hpp"

AST *Parser::ParseExpression(void)
{
        return ParsePrimary();
}

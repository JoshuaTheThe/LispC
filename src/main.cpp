#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <array>
#include <string>
#include "tokeniser.hpp"
#include "parser/parser.hpp"
#include "codegen/codegen.hpp"

#include <iostream>
#include <string>

void display(AST *tree, size_t depth = 0)
{
        if (!tree)
                return;

        std::cerr << std::string(depth * 2, ' ');

        switch (tree->GetType())
        {
        case AST::AST_NUMBER:
                std::cerr << "Number: " << tree->GetNumber() << "\n";
                break;

        case AST::AST_IDENTIFIER:
                std::cerr << "Identifier: " << tree->GetIdentifier() << "\n";
                break;

        case AST::AST_FUNCTION:
        {
                std::string name = tree->GetIdentifier().empty() ? "<anonymous>" : tree->GetIdentifier();
                std::cerr << "Function: " << name << " (" << tree->GetChildren().size() << " children)\n";
                break;
        }

        case AST::AST_IF:
                std::cerr << "If (" << tree->GetChildren().size() << " children)\n";
                break;
        
        case AST::AST_BODY:
                std::cerr << "Grouped Expressions: (" << tree->GetChildren().size() << " members)\n";
                break;

        case AST::AST_CALL:
                std::cerr << "Function call to " << tree->GetIdentifier() << " (" << tree->GetChildren().size() << " arguments)\n";
                break;

        default:
                std::cerr << "Unknown AST node\n";
                break;
        }

        for (AST *child : tree->GetChildren())
        {
                display(child, depth + 1);
        }
}

int main(int argc, char **argv)
{
        if (argc < 2)
        {
                std::cerr << "Usage: " << argv[0] << " <file.lisp>\n";
                return 1;
        }

        std::ifstream file(argv[1]);
        if (!file)
        {
                std::cerr << "Error: could not open file " << argv[1] << "\n";
                return 1;
        }

        std::stringstream buffer;
        buffer << file.rdbuf();
        std::string code = buffer.str();

        std::string_view sv(code);
        Tokeniser tok(sv);
        auto tokens = tok.Fetch();

        Parser p(tokens);
        AST *tree = p.ParseExpression();

        display(tree, 0);

        CodeGenerator codegen = CodeGenerator();
        codegen.Generate(tree);
        std::cout << "\tsection .text" << std::endl;

        for (auto &line : codegen.GetLines())
        {
                std::cout << line << std::endl;
        }

        std::cout << "\tsection .rodata" << std::endl;

        size_t i = 1;
        for (auto &line : codegen.GetStrings())
        {
                std::cout << "_string_" << std::to_string(i) << ":" << std::endl;
                for (auto &x : line)
                {
                        std::cout << "\tdb " << std::to_string((int)x) << std::endl;
                }
                std::cout << "\tdb 0" << std::endl;
                i++;
        }

        delete tree;
        return 0;
}

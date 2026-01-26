#include "codegen.hpp"

void CodeGenerator::GenerateIf(AST *tree)
{
        if (tree->GetChildren().size() < 2)
        {
                std::cerr << "Error: missing conditional or then statement(s)" << std::endl;
        }

        /* Condition */
        size_t skipLabel = lines.size();
        Generate(tree->GetChildren()[0]);
        size_t elseLabel = lines.size();
        this->lines.push_back("\tpop eax");
        this->lines.push_back("\ttest eax, eax");
        this->lines.push_back("\tjz " + stack.top().FunctionName + ".m" + std::to_string(elseLabel));

        /* Then */
        Generate(tree->GetChildren()[1]);
        this->lines.push_back("\tjmp " + stack.top().FunctionName + ".m" + std::to_string(skipLabel));

        /* Else */
        this->lines.push_back(stack.top().FunctionName + ".m" + std::to_string(elseLabel) + ":");
        if (tree->GetChildren().size() > 2)
        {
                Generate(tree->GetChildren()[2]);
        }

        this->lines.push_back(stack.top().FunctionName + ".m" + std::to_string(skipLabel) + ":");
}

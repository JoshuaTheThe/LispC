#include "codegen.hpp"

void CodeGenerator::GenerateIf(AST *tree)
{
        if (tree->GetChildren().size() < 2)
                std::cerr << "Error: missing conditional or then statement(s)" << std::endl;

        size_t elseLabel = NewLabel();
        size_t endLabel = NewLabel();

        Generate(tree->GetChildren()[0]);
        lines.push_back("\tpop eax");
        lines.push_back("\ttest eax, eax");
        lines.push_back("\tjz " + stack.top().FunctionName + ".m" + std::to_string(elseLabel));

        Generate(tree->GetChildren()[1]);
        lines.push_back("\tjmp " + stack.top().FunctionName + ".m" + std::to_string(endLabel));

        lines.push_back(stack.top().FunctionName + ".m" + std::to_string(elseLabel) + ":");
        if (tree->GetChildren().size() > 2)
                Generate(tree->GetChildren()[2]);

        lines.push_back(stack.top().FunctionName + ".m" + std::to_string(endLabel) + ":");
}

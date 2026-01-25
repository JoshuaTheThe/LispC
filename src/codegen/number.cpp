#include "codegen.hpp"

void CodeGenerator::GenerateNumber(AST *tree)
{
        std::string num = std::to_string(tree->GetNumber());
        this->lines.push_back("\tpush " + num);
}

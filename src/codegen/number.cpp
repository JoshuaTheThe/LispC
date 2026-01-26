#include "codegen.hpp"

void CodeGenerator::GenerateNumber(AST *tree)
{
        Type type;
        type.TypeType = Type::TYPE_INTEGER;
        type.as.Integer = tree->GetNumber();
        typestack.push(type);
        std::string num = std::to_string(tree->GetNumber());
        this->lines.push_back("\tpush " + num);
}

#include "codegen.hpp"

void CodeGenerator::GenerateReference(AST *tree, bool isdecl=false)
{
        Variable variable("\\", 0);
        for (auto &var : stack.top().vars)
        {
                if (var.VarName == tree->GetIdentifier())
                {
                        variable = var;
                        break;
                }
        }

        if (variable.VarName == "\\" && !isdecl)
        {
                std::cerr << "Error: Undefined reference to symbol '" << tree->GetIdentifier() << "'" << std::endl;
                return;
        }

        if (!isdecl)
                this->lines.push_back("\tpush dword [ebp+" + std::to_string(variable.EbpOffset) + "]");
}

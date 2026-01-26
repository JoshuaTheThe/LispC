#include "codegen.hpp"

void CodeGenerator::GenerateStructureReference(AST *tree)
{
        Structure *struc = nullptr;

        for (auto &str : structures)
        {
                if (str.name == tree->GetIdentifier())
                {
                        struc = &str;
                        break;
                }
        }

        if (struc == nullptr)
        {
                std::cerr << "Error: Undefined reference to symbol '" << tree->GetIdentifier() << "'" << std::endl;
                return;
        }

        Type type;
        type.TypeType = Type::TYPE_STRUCT;
        type.as.Struc = struc;
        typestack.push(type);
        this->lines.push_back("\tsub esp, " + std::to_string(struc->elements.size() * 4));
        this->lines.push_back("\tpush esp");
}

void CodeGenerator::GenerateReference(AST *tree, bool isdecl = false)
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
                GenerateStructureReference(tree);
                return;
        }

        Type type;
        type = variable.type;
        type.as.Integer = -1;
        typestack.push(type);

        if (!isdecl)
                this->lines.push_back("\tpush dword [ebp+" + std::to_string(variable.EbpOffset) + "]");
}

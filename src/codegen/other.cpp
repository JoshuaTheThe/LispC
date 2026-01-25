#include "codegen.hpp"

std::vector<std::string> CodeGenerator::GetLines(void)
{
        return lines;
}

std::vector<std::string> CodeGenerator::GetStrings(void)
{
        return strings;
}

void CodeGenerator::GenerateString(AST *tree)
{
        strings.push_back(tree->GetIdentifier());
        this->lines.push_back("\tpush _string_" + std::to_string(strings.size()));
}

void CodeGenerator::Generate(AST *tree)
{
        switch (tree->GetType())
        {
        case AST::AST_STRUCT:
                Structure Struc;
                Struc.name = tree->GetIdentifier();
                Struc.elements = tree->FunctionArguments; /* reused field */
                structures.push_back(Struc);
                break;
        case AST::AST_FUNCTION:
                GenerateFunction(tree);
                break;
        case AST::AST_BODY:
                for (auto &line : tree->GetChildren())
                {
                        Generate(line);
                }
                break;
        case AST::AST_NUMBER:
                GenerateNumber(tree);
                break;
       case AST::AST_STRING:
                GenerateString(tree);
                break;
        case AST::AST_IDENTIFIER:
                GenerateReference(tree, false);
                break;
        case AST::AST_CALL:
                GenerateCall(tree);
                break;
        case AST::AST_IF:
                GenerateIf(tree);
                break;
        case AST::AST_EXTERN:
        {
                this->lines.push_back("\textern " + tree->GetIdentifier());
                break;
        }
        case AST::AST_SET:
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

                if (variable.VarName == "\\")
                {
                        std::cerr << "Error: Undefined reference to symbol '" << tree->GetIdentifier() << "'" << std::endl;
                        return;
                }

                for (auto &x : tree->GetChildren())
                        Generate(x);
                this->lines.push_back("\tpop dword [ebp+" + std::to_string(variable.EbpOffset) + "]");
                break;
        }
        case AST::AST_DECLARE:
        {
                int ebp = stack.top().ebpOffset;
                Variable var = Variable(tree->GetIdentifier(), ebp);
                stack.top().ebpOffset -= sizeof(int32_t);
                stack.top().vars.push_back(var);
                this->lines.push_back("\tsub esp, 4");
                break;
        }
        }
}

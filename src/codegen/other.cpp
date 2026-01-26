#include <algorithm>
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
        Type type;
        type.TypeType = Type::TYPE_INTEGER;
        type.as.Integer = 1;
        typestack.push(type);
        strings.push_back(tree->GetIdentifier());
        this->lines.push_back("\tpush _string_" + std::to_string(strings.size()));
}

CodeGenerator::Variable *CodeGenerator::FindVar(AST *tree)
{
        Variable *variable = nullptr;
        for (auto &var : stack.top().vars)
        {
                if (var.VarName == tree->GetIdentifier())
                {
                        variable = &var;
                        break;
                }
        }

        if (variable == nullptr)
        {
                std::cerr << "Error: Undefined reference to symbol '" << tree->GetIdentifier() << "'" << std::endl;
                return nullptr;
        }

        return variable;
}

CodeGenerator::Structure *CodeGenerator::FindStruc(AST *tree)
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
                std::cerr << "Error: Undefined reference to type '" << tree->GetIdentifier() << "'" << std::endl;
                return nullptr;
        }

        return struc;
}

void CodeGenerator::Generate(AST *tree)
{
        switch (tree->GetType())
        {
        case AST::AST_STRUCT:
        {
                Structure Struct;
                Struct.name = tree->GetIdentifier();
                Struct.elements = tree->FunctionArguments; /* reused field */
                structures.push_back(Struct);
                break;
        }
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
        case AST::AST_ELEM:
        {
                Variable *variable = FindVar(tree);
                if (!variable || variable->type.TypeType != Type::TYPE_STRUCT)
                {
                        std::cerr << "Error: Cannot get element of integer" << std::endl;
                        return;
                }

                Structure *struc = variable->type.as.Struc;

                long Offset = 0;
                for (size_t i = 0; i < struc->elements.size(); i++)
                {
                        if (struc->elements[i] == tree->FunctionArguments[0])
                                break;
                        Offset += 4;
                }
                this->lines.push_back("\tpush dword [ebp+" + std::to_string(variable->EbpOffset) + "]");
                this->lines.push_back("\tpop ebx");
                this->lines.push_back("\tadd ebx, " + std::to_string(Offset));
                this->lines.push_back("\tpush dword [ebx]");

                Type type;
                type.TypeType = Type::TYPE_INTEGER;
                type.as.Integer = -1;
                typestack.push(type);
                break;
        }
        case AST::AST_SETE:
        {
                Variable *variable = FindVar(tree);
                if (!variable || variable->type.TypeType != Type::TYPE_STRUCT)
                {
                        std::cerr << "Error: Cannot set element of integer" << std::endl;
                        return;
                }

                for (auto &x : tree->GetChildren())
                        Generate(x);

                typestack.pop();

                Structure *struc = variable->type.as.Struc;

                long Offset = 0;
                for (size_t i = 0; i < struc->elements.size(); i++)
                {
                        if (struc->elements[i] == tree->FunctionArguments[0])
                                break;
                        Offset += 4;
                }

                this->lines.push_back("\tpop ebx");
                this->lines.push_back("\tpush dword [ebp+" + std::to_string(variable->EbpOffset) + "]");
                this->lines.push_back("\tpop eax");
                this->lines.push_back("\tadd eax, " + std::to_string(Offset));
                this->lines.push_back("\tmov [eax], ebx");
                break;
        }

        case AST::AST_SET:
        {
                Variable *variable = FindVar(tree);
                for (auto &x : tree->GetChildren())
                        Generate(x);
                variable->type = typestack.top();
                typestack.pop();
                this->lines.push_back("\tpop dword [ebp+" + std::to_string(variable->EbpOffset) + "]");
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

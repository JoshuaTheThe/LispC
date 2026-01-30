#include "codegen.hpp"

#define _POP_EBX_EAX                                \
        do                                          \
        {                                           \
                this->lines.push_back("\tpop eax"); \
                this->lines.push_back("\tpop ebx"); \
                this->left = typestack.top();       \
                this->typestack.pop();              \
                this->right = typestack.top();      \
                this->typestack.pop();              \
                                                    \
        } while (0)

void CodeGenerator::GenerateCall(AST *tree)
{
        const std::string &Function = tree->GetIdentifier();
        const size_t argc = tree->GetChildren().size();

        for (auto it = tree->GetChildren().rbegin();
             it != tree->GetChildren().rend();
             ++it)
        {
                Generate(*it);
        }

        if (Function == "add" && argc == 2)
        {
                _POP_EBX_EAX;
                this->lines.push_back("\tadd eax, ebx");
                this->lines.push_back("\tpush eax");
        }
        else if (Function == "sub" && argc == 2)
        {
                _POP_EBX_EAX;
                this->lines.push_back("\tsub eax, ebx");
                this->lines.push_back("\tpush eax");
        }
        else if (Function == "mul" && argc == 2)
        {
                _POP_EBX_EAX;
                this->lines.push_back("\tmul ebx");
                this->lines.push_back("\tpush eax");
        }
        else if (Function == "div" && argc == 2)
        {
                _POP_EBX_EAX;
                this->lines.push_back("\tcdq");
                this->lines.push_back("\tdiv ebx");
                this->lines.push_back("\tpush eax");
        }
        else if (Function == "mod" && argc == 2)
        {
                _POP_EBX_EAX;
                this->lines.push_back("\tcdq");
                this->lines.push_back("\tdiv ebx");
                this->lines.push_back("\tpush edx");
        }
        else if (Function == "and" && argc == 2)
        {
                _POP_EBX_EAX;
                this->lines.push_back("\tand eax, ebx");
                this->lines.push_back("\tpush eax");
        }
        else if (Function == "or" && argc == 2)
        {
                _POP_EBX_EAX;
                this->lines.push_back("\tor eax, ebx");
                this->lines.push_back("\tpush eax");
        }
        else if (Function == "xor" && argc == 2)
        {
                _POP_EBX_EAX;
                this->lines.push_back("\txor eax, ebx");
                this->lines.push_back("\tpush eax");
        }
        else if (Function == "not" && argc == 1)
        {
                this->lines.push_back("\tpop eax");
                this->lines.push_back("\txor eax, -1");
                this->lines.push_back("\tpush eax");
        }
        else if (Function == "eq" && argc == 2)
        {
                _POP_EBX_EAX;
                this->lines.push_back("\tcmp eax, ebx");
                this->lines.push_back("\tsete al");
                this->lines.push_back("\tmovzx eax, al");
                this->lines.push_back("\tpush eax");
        }
        else if (Function == "neq" && argc == 2)
        {
                _POP_EBX_EAX;
                this->lines.push_back("\tcmp eax, ebx");
                this->lines.push_back("\tsetne al");
                this->lines.push_back("\tmovzx eax, al");
                this->lines.push_back("\tpush eax");
        }
        else if (Function == "lt" && argc == 2)
        {
                _POP_EBX_EAX;
                this->lines.push_back("\tcmp eax, ebx");
                this->lines.push_back("\tsetl al");
                this->lines.push_back("\tmovzx eax, al");
                this->lines.push_back("\tpush eax");
        }
        else if (Function == "gt" && argc == 2)
        {
                _POP_EBX_EAX;
                this->lines.push_back("\tcmp eax, ebx");
                this->lines.push_back("\tsetg al");
                this->lines.push_back("\tmovzx eax, al");
                this->lines.push_back("\tpush eax");
        }
        else if (Function == "lte" && argc == 2)
        {
                _POP_EBX_EAX;
                this->lines.push_back("\tcmp eax, ebx");
                this->lines.push_back("\tsetle al");
                this->lines.push_back("\tmovzx eax, al");
                this->lines.push_back("\tpush eax");
        }
        else if (Function == "gte" && argc == 2)
        {
                _POP_EBX_EAX;
                this->lines.push_back("\tcmp eax, ebx");
                this->lines.push_back("\tsetge al");
                this->lines.push_back("\tmovzx eax, al");
                this->lines.push_back("\tpush eax");
        }
        else if (Function == "deref" && argc == 1)
        {
                this->lines.push_back("\tpop eax");
                this->lines.push_back("\tpush dword [eax]");
        }
        else if (Function == "set_deref" && argc == 2)
        {
                _POP_EBX_EAX;
                this->lines.push_back("\tmov [eax], ebx");
        }
        else if (Function == "alloca" && argc == 1)
        {
                this->lines.push_back("\tpop eax");
                this->lines.push_back("\tsub esp, eax");
                this->lines.push_back("\tpush esp");
        }
        else if (Function == "element" && argc == 2)
        {
                this->left = typestack.top();
                if (this->left.TypeType == Type::TYPE_INTEGER)
                {
                        this->typestack.pop();
                        this->lines.push_back("\tpop edx");
                        this->lines.push_back("\tpop ebx");
                        this->lines.push_back("\tadd ebx, edx");
                        this->lines.push_back("\tpush dword [ebx]");
                }

                Type type;
                type.TypeType = Type::TYPE_INTEGER;
                type.as.Integer = -1;
                typestack.push(type);
        }
        else if (Function == "set_element" && argc == 3)
        {
                this->left = typestack.top();
                if (this->left.TypeType == Type::TYPE_INTEGER)
                {
                        this->typestack.pop();
                        this->typestack.pop();
                        this->typestack.pop();
                        this->lines.push_back("\tpop edx");
                        this->lines.push_back("\tpop ebx");
                        this->lines.push_back("\tadd ebx, edx");
                        this->lines.push_back("\tpop dword [ebx]");
                }

                Type type;
                type.TypeType = Type::TYPE_INTEGER;
                type.as.Integer = -1;
                typestack.push(type);
        }
        else
        {
                this->lines.push_back("\tcall " + Function);
                this->lines.push_back("\tadd esp, " + std::to_string(4 * argc));
                this->lines.push_back("\tpush eax");
                Type type;
                type.TypeType = Type::TYPE_INTEGER;
                type.as.Integer = -1;
                typestack.push(type);
        }
}

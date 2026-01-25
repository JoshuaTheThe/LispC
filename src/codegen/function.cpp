#include "codegen.hpp"

void CodeGenerator::GenerateFunction(AST *tree)
{
        Info info;
        info.FunctionName = tree->GetIdentifier();

        for (auto &x : functions)
        {
                if (x.Name == info.FunctionName)
                {
                        std::cerr << "Error: duplicate function name, '" << x.Name << "'" << std::endl;
                        return;
                }
        }

        Function fn;
        fn.argcount = tree->FunctionArguments.size();
        fn.Name = info.FunctionName;
        functions.push_back(fn);
        
        size_t skipLabel = lines.size();
        this->lines.push_back("\tjmp "+info.FunctionName+".m" + std::to_string(skipLabel));
        this->lines.push_back("\tglobal " + info.FunctionName);
        this->lines.push_back(info.FunctionName + ":");
        this->lines.push_back("\tpush ebp");
        this->lines.push_back("\tmov ebp, esp");
        info.ebpOffset = 4 + (4 * tree->FunctionArguments.size());
        for (auto &argument : tree->FunctionArguments)
        {
                Variable var = Variable(argument, info.ebpOffset);
                info.ebpOffset -= 4;
                info.vars.push_back(var);
        }

        info.ebpOffset = -4;
        stack.push(info);
        for (auto &line : tree->GetChildren())
        {
                Generate(line);
        }
        stack.pop();
        this->lines.push_back("\tpop eax");
        this->lines.push_back("\tmov esp, ebp");
        this->lines.push_back("\tpop ebp");
        this->lines.push_back("\tret");
        this->lines.push_back(info.FunctionName+".m" + std::to_string(skipLabel) + ":");
}

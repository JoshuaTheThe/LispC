#ifndef CODEGEN_H
#define CODEGEN_H

/**
 * Code Generator
 */

#include <iostream>
#include <fstream>
#include <vector>
#include <array>
#include <string>
#include <string_view>
#include <stack>
#include "../parser/parser.hpp"

class CodeGenerator
{
private:
        struct Variable
        {
                std::string VarName;
                int EbpOffset;

                Variable(const std::string Name, const int Offset)
                {
                        VarName = Name;
                        EbpOffset = Offset;
                }
        };

        struct Function
        {
                std::string Name;
                size_t argcount;
        };

        struct Info
        {
                std::string FunctionName;
                std::vector<Variable> vars;
                int ebpOffset;
        };

        std::vector<std::string> lines;
        std::vector<Function> functions;
        std::vector<std::string> strings;

        std::stack<Info> stack;
public:
        void GenerateFunction(AST *Tree);
        void GenerateBody(AST *Tree);
        void GenerateNumber(AST *Tree);
        void GenerateReference(AST *Tree, bool isdecl);
        void GenerateCall(AST *Tree);
        void GenerateIf(AST *Tree);
        void GenerateString(AST *Tree);
        void Generate(AST *Tree);
        std::vector<std::string> GetLines(void);
        std::vector<std::string> GetStrings(void);
};

#endif

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
        struct Structure
        {
                std::string name;
                std::vector<std::string> elements;
        };

        struct Type
        {
                // lol
                enum
                {
                        TYPE_INTEGER,
                        TYPE_STRUCT,
                } TypeType;
                union
                {
                        int Integer;
                        Structure *Struc;
                } as;

                Type(void)
                {
                        TypeType = TYPE_INTEGER;
                        as.Integer = 0;
                }
        };

        struct Variable
        {
                std::string VarName;
                int EbpOffset;
                Type type;

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
                Type type;
        };

        struct Info
        {
                std::string FunctionName;
                std::vector<Variable> vars;
                int ebpOffset;
        };

        std::vector<std::string> lines;
        std::vector<std::string> strings;
        std::vector<Function> functions;
        std::vector<Structure> structures;

        std::stack<Info> stack;
        std::stack<Type> typestack;

        Type left, right;

public:
        void GenerateFunction(AST *Tree);
        void GenerateBody(AST *Tree);
        void GenerateNumber(AST *Tree);
        void GenerateReference(AST *Tree, bool isdecl);
        void GenerateCall(AST *Tree);
        void GenerateIf(AST *Tree);
        void GenerateString(AST *Tree);
        void GenerateStructureReference(AST *tree);
        void Generate(AST *Tree);
        Structure *FindStruc(AST *tree);
        Variable *FindVar(AST *tree);
        std::vector<std::string> GetLines(void);
        std::vector<std::string> GetStrings(void);
};

#endif

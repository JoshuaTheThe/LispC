mkdir -p bin

# Main Tokeniser
g++ src/main.cpp -c -o bin/main.o -g
g++ src/tokeniser.cpp -c -o bin/tokeniser.o -g
# Parser
g++ src/parser/expression.cpp -c -o bin/expression.o -g
g++ src/parser/other.cpp -c -o bin/other.o -g
g++ src/parser/primary.cpp -c -o bin/primary.o -g
g++ src/parser/function.cpp -c -o bin/function.o -g
g++ src/parser/conditional.cpp -c -o bin/conditional.o -g
# Code Generator
g++ src/codegen/function.cpp -c -o bin/function_gen.o -g
g++ src/codegen/other.cpp -c -o bin/other_gen.o -g
g++ src/codegen/number.cpp -c -o bin/number_gen.o -g
g++ src/codegen/reference.cpp -c -o bin/reference_gen.o -g
g++ src/codegen/call.cpp -c -o bin/call_gen.o -g
g++ src/codegen/conditional.cpp -c -o bin/conditional_gen.o -g

g++ bin/main.o bin/tokeniser.o bin/expression.o bin/primary.o bin/function.o bin/other.o bin/conditional.o bin/function_gen.o bin/other_gen.o bin/number_gen.o bin/reference_gen.o bin/call_gen.o bin/conditional_gen.o -o bin/lispc

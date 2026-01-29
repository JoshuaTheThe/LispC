./bin/lispc tests/$1.lisp > $1.s
nasm $1.s -o $1.o -f elf32
cc $1.o -o $1 -m32
./$1
echo $?

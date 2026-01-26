./bin/lispc tests/2.lisp > test.s
nasm test.s -o test.o -felf32
cc test.o -o test -m32
./test
echo $?

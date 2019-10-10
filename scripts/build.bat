rmdir /S /Q ..\build
mkdir ..\build
64tass -C -B --m65c02 -L ..\build\hello.sym -o ..\build\HELLO.PRG ..\src\hello.asm

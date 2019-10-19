import shutil
import os

shutil.rmtree('../build', ignore_errors=True)
os.mkdir('../build')

os.system('64tass -C -B --m65c02 -L ../build/hello.sym -o ../build/HELLO.PRG ../src/main.asm')

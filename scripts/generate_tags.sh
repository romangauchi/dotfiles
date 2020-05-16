#!/bin/bash

mkdir -p ~/.vim/tags
cd ~/.vim/tags

options="-R --sort=yes --c++-kinds=+p --fields=+iaS --extras=+q --language-force=C++ -f"

# ctags ${options} gl         /usr/include/GL/                                # for OpenGL
# ctags ${options} sdl        /usr/include/SDL/                               # for SDL
# ctags ${options} qt4        /usr/include/qt4/                               # for QT4
ctags ${options} cpp        /usr/lib/gcc/x86_64-pc-linux-gnu/9.3.0/include/ # for gcc (7.4.0)
# ctags ${options} cpp        /usr/lib/gcc/x86_64-pc-linux-gnu/7.4.0/include/ # for gcc (7.4.0)
# ctags ${options} systemc    /opt/systemc/systemc-2.3.3/gcc-7.4.0/           # for SystemC/TLM-2 (2.3.3)
# ctags ${options} scv        /opt/scv/scv-2.0.1/systemc-2.3.3/gcc-7.4.0/     # for SCV (2.0.1)


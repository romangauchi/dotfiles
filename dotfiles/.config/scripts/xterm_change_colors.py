#!/bin/env python

import sys, os, re

if len(sys.argv) != 2:
    print("usage: %s <theme-file>" % sys.argv[0]); sys.exit(1)

with open(sys.argv[1]) as fp:
    colors = [""]*16; fgbg = [""]*2
    for line in fp.readlines():
        m = re.match(r'export\s+COLOR_([\d]{2})="?\#([^" ]{6})"? ', line)
        if m:
            colors[int(m.group(1)) - 1 ] = m.group(2)
        m = re.match(r'export\s+BACKGROUND_COLOR="?\#([^" ]{6})"? ', line)
        if m:
            fgbg[1] = m.group(1)
        m = re.match(r'export\s+FOREGROUND_COLOR="?\#([^" ]{6})"? ', line)
        if m:
            fgbg[0] = m.group(1)
    if "" in colors or "" in fgbg:
        print("Error: wrong theme file? missing color values"); sys.exit(2)

with open(os.path.expanduser("~")+"/.Xresources", 'r+') as fp:
    idx = 0; lines = fp.readlines()
    fp.seek(0)
    for line in lines:
        new_line = line
        m = re.match(r'^(#define\s+C_foreground\s+#)[a-fA-F0-9]{6}(.*)$', line)
        if m:
            new_line = m.group(1)+fgbg[0]+m.group(2)+'\n'
        m = re.match(r'^(#define\s+C_background\s+#)[a-fA-F0-9]{6}(.*)$', line)
        if m:
            new_line = m.group(1)+fgbg[1]+m.group(2)+'\n'
        m = re.match(r'^(#define\s+C_[^\s]+\s+#)[a-fA-F0-9]{6}(.*)$', line)
        if m and idx < 16:
            new_line = m.group(1)+colors[idx]+m.group(2)+'\n'; idx+=1
        fp.write(new_line)

os.system("xrdb -merge ~/.Xresources")

import os
import random
import math
import time
from typing import List

### a wallpappers auto switcher script

WALLPAPER_DIR = '/home/ph/Pictures/wallpapers'

def reduce_files(_fp: str):
    fps = [_fp]
    ret: List[str] = []
    while len(fps) > 0:
        fp = fps.pop()
        if os.path.isdir(fp):
            for f in os.listdir(fp):
                fps.append(os.path.join(fp, f))
        else:
            ret.append(fp)
    return ret


def guest(list: List[str], item: str | None):
    idx = math.floor(random.random() * len(list))
    if item and list[idx] == item:
        if idx + 1 >= len(list):
            return list[0]
        else:
            return list[idx + 1]
    else:
       return list[idx]
        
def syscall(cmd: str):
    print(cmd)
    os.system(cmd)
        

def main():
    try:
        syscall("swww init")
    except:
        pass
    files = reduce_files(WALLPAPER_DIR)
    file: str | None = None

    while True:
        file = guest(files, file)
        # os.system(f"swww img {file}")
        syscall(f"swww img --transition-type wipe --transition-angle 30 --transition-step 90 {file}")
        time.sleep(3 * 60)
        

if __name__ == "__main__":
    main()

import os
import random
import math
import time
from typing import List
### a wallpappers auto switcher script

WALLPAPER_DIR = '/home/ph/Pictures/wallpapers'
SLEEP_TIME = 3 * 60
SWITCH_CMDS = [
        "swww img --transition-type wipe --transition-angle 30 --transition-step 90",
        "swww img --transition-type left",
        "swww img --transition-type any",
        ]

def find_imgs(_fp: str):
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


def choice(counts: List[str], current: str | None):
    if len(counts) == 1:
        return counts[0]
    return random.choice(list(filter(lambda x: x == current, counts))) if current else random.choice(counts)

def syscall(cmd: str):
    print(cmd)
    os.system(cmd)


def main():
    try:
        syscall("swww init")
    except:
        pass
    files = find_imgs(WALLPAPER_DIR)
    if len(files) == 0:
        return

    file: str | None = None

    while True:
        file = choice(files, file)
        cmd = choice(SWITCH_CMDS, None)
        # os.system(f"swww img {file}")
        try:
            syscall(f"{cmd} {file}")
        except:
            files = find_imgs(WALLPAPER_DIR)
        time.sleep(SLEEP_TIME)


if __name__ == "__main__":
    main()

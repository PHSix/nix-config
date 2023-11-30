import os
import random
import time
from typing import List
# a wallpappers auto switcher script

WALLPAPER_DIR = os.path.expanduser('~/.wallpapers')
SLEEP_TIME = 3 * 60
SWITCH_CMDS = [
    "swww img --transition-type wipe --transition-angle 30 --transition-step 90",
    "swww img --transition-type left",
    "swww img --transition-type any",
]


def find_imgs(dir: str):
    files = [dir]
    ret: List[str] = []
    while len(files) > 0:
        file = files.pop()
        if os.path.exists(file) and os.path.isdir(file):
            for f in os.listdir(file):
                files.append(os.path.join(file, f))
        else:
            ret.append(file)
    return ret


def choice(l: List[str], c: str | None):
    if len(l) == 1:
        return l[0]
    return random.choice(list(filter(lambda x: x != c, l)))


def syscall(cmd: str):
    print(cmd) # log output
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

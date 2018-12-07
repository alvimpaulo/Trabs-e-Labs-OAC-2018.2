import os
import re
import subprocess

for file in os.listdir("./bmp/"):
    #print(re.sub('(( +)|(-+)|(x+))+', '_', file))
    fileClean = re.sub('\.bmp', '', file)
    subprocess.run(["./bmp2oac/bmp2oac.exe", f"./bmp/{fileClean}"])
import os

for file in os.listdir("./"):
    with open(f"./{file}", 'r') as f:
        with open("sourcezao.s", "a+") as dest:
            fileContents = f.read()
            print(fileContents)
            dest.write(fileContents)
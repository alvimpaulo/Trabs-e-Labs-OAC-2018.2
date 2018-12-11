import os

for file in os.listdir("./source/"):
    with open(f"./source/{file}", "w+") as f:
        
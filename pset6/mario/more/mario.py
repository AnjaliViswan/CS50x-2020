

# USER INPUT
from cs50 import get_int
p = get_int("Height: ")
while (p < 1 or p > 8):
    p = int(input("Height: "))
    
# PRINTING....
for i in range(p):
    print((" " * (p-i-1)) + ("#" * (i+1)) + ("  ") + ("#" * (i+1)))

# ADD MORE COMMENTS
# I LOVE COMMENTS!
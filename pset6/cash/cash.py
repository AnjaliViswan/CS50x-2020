
# Definitions
# Prompt...

from cs50 import get_float

d = get_float("Change: ")
while d < 0:
    d = get_float("Change: ")

c = round(d * 100)
g = 0
    
# Function
while c:
    if c >= 25:  # Quarters
        c -= 25
        g += 1
    elif (c >= 10):  # Dimes
        c -= 10
        g += 1
    elif (c >= 5):  # Nickels
        c -= 5
        g += 1
    elif (c >= 1):  # Pennies
        c -= 1
        g += 1

# Printing...
print("Number of Coins: " + str(g))

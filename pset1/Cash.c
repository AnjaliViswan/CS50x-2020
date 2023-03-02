#include <stdio.h>
#include <cs50.h>
#include <math.h>

int main(void)
{
//Definitions
    int g;
    float d;
//Prompt...
    do
    {
        d = get_float("Change: ");
    }
    while (d < 0);
    int c = round(d * 100);
    g = 0;
    
//Function
    while (c)  //CHECKS:
    {
        if (c >= 25)      //Quarters
        {
            c -= 25;
            g += 1;
        }
        else if (c >= 10) //Dimes
        {
            c -= 10;
            g += 1;
        }
        else if (c >= 5)  //Nickels
        {
            c -= 5;
            g += 1;
        }
        else if (c >= 1)  //Pennies
        {
            c -= 1;
            g += 1;
        }
    }

//Printing...
    printf("Number of Coins: %d\n", g);
}
#include <cs50.h>
#include <stdio.h>

int main(void)
{
    //Prompt
    int h;
    do
    {
        h = get_int("Height:\n");
    }
    while (h < 1 || h > 8);

    //Printing...
    for (int i = h; i > 0 ; --i)
    {
        for (int k = i; k > 1; --k)
        {
            printf(" ");
        }

        for (int j = i; j <= h; j++)
        {
            printf("#");
        }
        printf("  ");
        for (int f = i; f <= h; f++)
        {
            printf("#");
        }
        
        
        printf("\n");
    }
}//to do mario2, print a space before new line, then add one more for loops with the for conditions but with opposit printing symbols.
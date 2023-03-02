#include <cs50.h>
#include <stdio.h>

int main (void)
{

    int n = get_int("Start size: \n");

    while(n<9)
    {
        n = get_int("Start size: \n");
    }


    int end = get_int("End Size: \n");

    while(end < n)
    {
        end = get_int("End Size: \n");
    }
    
    int years = 0;
    int sN = n;
    int sE = n;
    
    while(sN <= sE)
    {
        sN = sN + (n/3);
        sE = sE - (n/4);
        years++;
    }

    printf("Start Size: %i\n", n);
    printf("End Size: %i\n", end);
    printf("Years: %i\n", years);


}
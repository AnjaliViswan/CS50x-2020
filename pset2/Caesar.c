#include <stdio.h>
#include <cs50.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include <ctype.h>

int main(int argc, string argv[])
{

    if (argc != 2)
    {
        printf(" Proper Usage: ./ceasar key\n"); //reprompting if NO KEY
        return 1;
    }


    int chrc = strlen(argv[1]); //number of char in the key
    string p = argv[1];         // setting a variable to the key; p is the string of key
    for (int i = 0; i <= chrc; i++)
    {
        if isalpha(p[i]) //checking each char in the key
        {
            printf(" Proper Usage: ./ceasar key\n"); //reprompting NON NUMERIC
            return 1;
        }
    }

    int k = atoi(argv[1]); //turning a string into an integer; k is the #key
    if (k < 0) // checking for negatives
    {
        printf(" Proper Usage: ./ceasar key\n"); //reprompting if NEGATIVE NUM
        return 1;
    }
//END OF CHECKS

    string pt = get_string("Plaintext: "); //get plaintext; pt is a string of the plaintext

    chrc = strlen(pt); // chrc now equals the # of charcters of the plain text

//PRINTING...
    printf("ciphertext: ");
    for (int i = 0; i < chrc; i++) // goes through the whole plain text array
    {
        int y = (pt[i] + k); // y equals the text + key

        if (isupper(pt[i]) && isalpha(pt[i])) //if upper case letter...
        {
            if (y > 90) // if the cipher is > Z...
            {
                y = ((pt[i] + k) - 26); // go back 26 characters in ASCII
                printf("%c", y); //Print wrapped letter
            }
            else //otherwise...
            {
                printf("%c", (pt[i] + k)); //print letter
            }
        }
        if (islower(pt[i]) && isalpha(pt[i])) //if upper case letter...
        {
            if (y > 122) // if letter is over 'z'...
            {
                y = ((pt[i] + k) - 26); // go back 26 characters in ASCII
                printf("%c", y); //Print wrapped letter
            }
            else //otherwise...
            {
                printf("%c", y); // Print letter
            }
        }
        if (isblank(pt[i]) || ispunct(pt[i]))
        {
            printf("%c", pt[i]);
        }
    }
    printf("\n");
}

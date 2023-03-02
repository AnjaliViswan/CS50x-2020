#include <cs50.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <math.h>

int main(void)
{
    float letters, sentences, words;
//prompt
    string p = get_string("Text: ");
   
    int chrc = strlen(p);
  
// letters

    letters = 0;
    for (int i = 0; i <= chrc; i++)
   
    {
        if isalpha(p[i]) 
        {
            letters += 1;
        }
       
    }

// words
    words = 1;
    bool flag = false;
    for (int i = 0 ; i <= chrc ; i++)
    {
      
        if (isalpha(p[i]))
        {
            flag = false;
        }
      
        if (isspace(p[i]) && flag == false)
        {
            flag = true;
            words += 1;
        }
    }
// sentences
    sentences = 0;
   
    for (int i = 0; i <= chrc; i++)
    {
        if (p[i] == '.' || p[i] == '!' || p[i] == '?')
        {
            sentences += 1;
        }
    }
// math and index values
    float L = (letters / words * 100);
   
    float S = (words / sentences);
    S = (100 / S);
   
    int index = round(0.0588 * L - 0.296 * S - 15.8);
// grading...
    if (index > 16)
    {
        printf("Grade 16+\n");
      
    }
    else if (index < 1)
    {
        printf("Before Grade 1\n");
    }
    else
    {
      
        printf("Grade %d\n", index);
    }
   
//#letters divided by #words x 100 = avg letters per 100 words
//#words/#sentences = avg #words per sentence, 100/that, = sentences per 100 words

}

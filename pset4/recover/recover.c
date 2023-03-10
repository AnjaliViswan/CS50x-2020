#include <stdio.h>
#include <stdlib.h>
#include <cs50.h>
#include <stdint.h>

typedef uint8_t BYTE;
//peepeepoopoo
//comments curses!

#define BLOCK_SIZE 512
#define FILE_NAME_SIZE 8
bool is_start_new_jpeg(BYTE buffer[]);
int main(int argc, char *argv[])
{
    //TROUBLESHOOTING USER INPUT
    if (argc != 2)
    {
        printf("Usage: ./recover img\n");
        return 1;
    }
    FILE *infile = fopen(argv[1], "r");
    if (infile == NULL)
    {
        printf("File not found");
        return 1;
    }
    //START READING
    BYTE buffer[BLOCK_SIZE];
    int file_index = 0;
    bool have_found_first_jpg = false;
    FILE *outfile;
    while (fread(buffer, BLOCK_SIZE, 1, infile))
    {
        if (is_start_new_jpeg(buffer))
        {
            if (!have_found_first_jpg)
            {
                have_found_first_jpg = true;
            }
            
            else
            {
                fclose(outfile);
            }
            char filename[FILE_NAME_SIZE];
            sprintf(filename, "%03i.jpg", file_index++);
            outfile = fopen(filename, "w");
            //TROUBLESHOOT
            if (outfile == NULL)
            {
                return 1;
            }
            
            fwrite(buffer, BLOCK_SIZE, 1, outfile);
            
        }
        else if (have_found_first_jpg)
        {
            // keep it up!
            fwrite(buffer, BLOCK_SIZE, 1, outfile);
        }
        
    }
    //CLOSE FILES
    fclose(outfile);
    fclose(infile);
    

}
bool is_start_new_jpeg(BYTE buffer[])
{
    return  buffer[0] == 0xff && buffer[1] == 0xd8 && buffer[2] == 0xff && (buffer[3] & 0xf0);
    
}
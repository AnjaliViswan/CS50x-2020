
# prompt
from cs50 import get_string


s = get_string("Text: ").strip()
   
words, letters, sentences = 0, 0, 0
  
# letters
for i in range(len(s)):
    if (i == 0 and s[i] != ' ') or (i != len(s) - 1 and s[i] == ' ' and s[i + 1] != ' '):
        words += 1
    if s[i].isalpha():
        letters += 1
    if s[i] == '.' or s[i] == '?' or s[i] == '!':
        sentences += 1
        
L = letters / words * 100
S = sentences / words * 100
index = round(0.0588 * L - 0.296 * S - 15.8)
if index < 1:
    print("Before Grade 1")
elif index >= 16:
    print("Grade 16+")
else:
    print(f"Grade {index}")

# letters divided by #words x 100 = avg letters per 100 words
# words/#sentences = avg #words per sentence, 100/that, = sentences per 100 words

#! /bin/zsh

# Not totally sure what they're looking for with this exercise. I added a check
# using the `index` function which doesn't do much on its own, but it seems
# to be all the functionality they're asking for and I can't imagine what else to do.

awk '
BEGIN { RS = ""; FS = "\n" }
      {
        if (index($0, "!!#") != 0) {
          printf("File contains the delimiter in record %s. Please remove or replace and try again.", NR)
          exit 1
        }

        printf("%s!!#", x[split($1, x, " ")])
        for (i = 1; i <= NF; i++)
            printf("%s%s", $i, I < NF ? "!!#" : "\n")
      }
' $* |
sort |
awk '
BEGIN { FS = "!!#" }
      {
        for (i = 2; i <= NF; i++)
            printf("%s\n", $i)
        printf("\n")
      }
'

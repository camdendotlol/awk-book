#! /usr/bin/awk -f

NR == 1 { nfld = NF
          for (i = 1; i <= NF; i++)
            numcol[i] = isint($i)
        }
        # Exercise 1
        { if (length($0) > 0) {
          { for (i = 1; i <= NF; i++) {
            if (numcol[i])
              sum[i] += $i
          }}
        }
}
END { for (i = 1; i <= nfld; i++) {
        if (numcol[i])
          printf("%i", sum[i])
        else
          printf("--")
        printf(i < nfld ? "\t" : "\n")
  }
}

# function isint(n) { return n ~ /^[+-]?[0-9]+$/ }
function isint(n) { return n ~ /^[+-]?[[:digit:]]+$/ }

# Exercise 2:
# Using both versions of the script on the nums example file,
# the two versions take the same amount of time (1.07s).
# I tried using /d (which still I think is what the authors meant)
# but it turns out that Awk doesn't support it!
# https://stackoverflow.com/a/68293191

# Exercise 3:
# Removing the if statement would mean removing the check of
# whether the value is a number. In other words, we could end
# up trying to add string values to the number if the data
# set is badly formatted.

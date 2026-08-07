#! /opt/homebrew/bin/gawk -f

# This exercise was a real slugfest with the amount of experimentation
# it required for string manipulation and all the little numerical
# variables bouncing around.

BEGIN {
  FS = "\t"; blanks = sprintf("%100s", " ")
  num_re = "^[+-]?([0-9]+[.]?[0-9]*|[.][0-9]+)$"
}
{
  row[NR] = $0
  for (i = 1; i <= NF; i++) {
    if ($i ~ num_re) {
      nwid[i] = max(nwid[i], length($i))
      if (index($i, ".") != 0) {
        split($i, split_num, ".")
        integer = split_num[1]
        decimal = split_num[2]
        # This took some experimentation. The +2 at the end is to make
        # space for the decimal point.
        wid[i] = max(wid[i], (length($i) + length(decimal) * 2) + 2)
      } else {
        wid[i] = max(wid[i], length($i))
      }
    } else {
      wid[i] = max(wid[i], length($i))
    }
  }
}
END {
  for (r = 1; r <= NR; r++) {
    n = split(row[r], d)
    for (i = 1; i <= n; i++) {
      sep = (i < n) ? "  " : "\n"
      if (d[i] ~ num_re) {
        printf("%*s%s", wid[i], numjust(i,d[i]), sep)
      }
      else
        printf("%-*s%s", wid[i], d[i], sep)
    }
  }
}

function max(x, y) { return (x > y) ? x : y }

function numjust(n, s) {
  if (index(s, ".") != 0) {
    split(s, split_num, ".")
    decimal = split_num[2]
    return s substr(blanks, 1, int((wid[n]-nwid[n])/2 - length(decimal) - 1))
  } else {
    return s substr(blanks, 1, int((wid[n]-nwid[n])/2))
  }
}

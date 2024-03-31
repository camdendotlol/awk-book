#! /bin/zsh

# This exercise was suspiciously simple.
# Were they expecting me to calculate
# tomorrow's date using Awk???

date -v+1d |
awk '
{
  date = $0
  split(date, d, / /)
  date = d[2] " " d[3] ", " d[6]
  printf("%s\n", date)
}
'
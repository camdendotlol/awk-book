#! /opt/homebrew/bin/gawk -f

# Have to use gawk for this one because regular awk
# expects ARGV[1] to be a file no matter what.
# Gawk also expects this, so we need a silly workaround
# where we set it to an empty string after storing its value.
  BEGIN { count = ARGV[1]
  ARGV[1] = "" }
{ line[NR] = $0 }
  END { for (i = NR; i > NR-count; i--) print line[i] }

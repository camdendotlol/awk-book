#! /opt/homebrew/bin/gawk -f

# Not calling this file "lookup" like the book says to keep the filenames consistent.

# This exercise was as simple as adding an if statement and some ARGV handling to the prior example program.

BEGIN {
  RS = "";
  FS = "\n";
  field = ARGV[1];
  value = ARGV[2];
  ARGV[1] = "";
  ARGV[2] = "";
}
/(^|\n)check/ {
  for (i = 1; i < NF; i++) {
    split($i, f, ";")
    val[f[1]] = f[2]
  }

  if (val[field] == value) {
    printf("%8s %5d %8s  %s\n",
      val["date"],
      val["check"],
      sprintf("$%.2f", val["amount"]),
      val["to"])
    delete val
  }

}

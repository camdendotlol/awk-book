#! /usr/bin/awk -f

# Args:
# long: What to do with long names.
#       Possible values:
#         * "truncate"
#         * "ellipses"
#         * "columns"

BEGIN {
  # Set default value for long arg
  if (long == "") {
    long = "truncate"
  }
}

{ if (long == "truncate") {
  out = sprintf("%s%-10.10s  ", out, $0) 
} else if (long == "ellipses") {
  out = sprintf("%s%-10.10s%s  ", out, $0, length($0) > 10 ? "..." : "   ")
} else if (long == "columns") {
  out = sprintf("%s%-10s  ", out, $0)
  # Make room for long names in each row depending
  # on their length. The text actually said "print
  # them across multiple columns" which would be a
  # bit easier but sounds kind of ugly.
  if (length($0) > 10) {
    n = n+(40 / (n + 1))
  }
}
  if (n++ > 5) {
    print substr(out, 1, length(out)-2)
    out = ""
    n = 0
  }
}

END {
  if (n < 0)
    print substr(out, 1, length(out)-2)
}
#! /usr/bin/awk -f

{
  if (nc[FILENAME]) {
    nc[FILENAME] = nc[FILENAME] + length($0) + 1
  } else {
    nc[FILENAME] = length($0) + 1
  }
  nw[FILENAME] += NF
  nr[FILENAME] = FNR
}

END {
  for (i = 1; i < ARGC; i++) {
    print nr[ARGV[i]], nw[ARGV[i]], nc[ARGV[i]], ARGV[i]
  }
}

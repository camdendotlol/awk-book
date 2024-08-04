#! /opt/homebrew/bin/gawk -f

# When you want to run one program, just comment out the other one.

# The key here is that the / character is the only illegal character 
# in Unix filenames, so it's safe to use it as the delimiter.

# bundle
{
  printf("%s / %s\n", FILENAME, $0)
}

# unbundle

# `FS` overrides the default space delimiter.
BEGIN { FS = " / " }
$1 != prev { close(prev); prev = $1 }
           { print substr($0, index($0, " / ") + 3) >$1 }
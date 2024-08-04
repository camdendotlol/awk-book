#! /opt/homebrew/bin/gawk -f

# e6-test.txt is some `ls -la` output that I modified to fit the exercise conditions.
# To test, run `cat e6-test.txt | ./e6.awk`.

{ print substr($0, index($0, $9), length($9)) }

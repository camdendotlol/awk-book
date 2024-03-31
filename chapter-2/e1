#! /usr/bin/awk -f

{ line[NR] = $0 }
  END { if (NR < 6)
        { for (i = 1; i <= NR; i++) print line[i] }
        else
        { for (i = 1; i <= 3; i++) print line[i]
        print "..."
        for (i = NR-2; i <= NR; i++) print line[i] }
      }

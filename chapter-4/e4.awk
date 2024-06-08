#! /opt/homebrew/bin/gawk -f

BEGIN { num_buckets = ARGV[2]; ARGV[2] = ""; highest_num = 0; }

{
  x[NR] = $1
  if ($1 > highest_num) {
    highest_num = $1
  }
}

END {
    per_bucket = highest_num / num_buckets
    for (i = 0; i < NR; i++) {
      y[int (x[i]/per_bucket)]++
    }
    for (i = 0; i < num_buckets; i++)
          printf(" %2d - %2d: %3d %s\n",
            per_bucket*i, per_bucket*i+(per_bucket - 1), y[i], rep(y[i], "*"))
  }
  
  function rep(n, s,   t) {
    while (n-- > 0)
      t = t s
    return t
  }

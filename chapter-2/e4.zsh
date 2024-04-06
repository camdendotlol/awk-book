#! /bin/zsh

# Updates the book's example to:
# 1. Include today's date in the output
# 2. Format output in CSV-style rows
#
# The output looks like:
#   2024-03-30,GOOG,152.26
#   2024-03-30,AAPL,171.48
#   2024-03-30,VTI,259.90
#
# Pretty lazy solution to the exercise, but
# it makes sense to run this daily and pipe
# the data into a CSV file as described.

curl "https://bigcharts.marketwatch.com/quotes/multi.asp?refresh=on&view=Q&msymb=$1" 2>/dev/null |
awk -v current_date="$(date +%Y-%m-%d)" '
  /<td class="symb-col"/ {
    sub(/.*<td class="symb-col">/, "")
    sub(/<.*/, "")
    symb = $0
    next
  }
  /<td class="last-col"/ {
    sub(/.*<td class="last-col">/, "")
    sub(/<.*/, "")
    price = $0
    gsub(/,/, "", price)
    printf("%s,%s,%s\n", current_date, symb, price)
  }
'


#! /opt/homebrew/bin/gawk -f

# { printf("%-12s %20s\n", $0, addcomma($0)) }

# function addcomma(x,   num) {
#   if (x < 0)
#     return "-" addcomma(-x)
#   num = sprintf("%.2f", x)
#   while (num ~ /[0-9][0-9][0-9][0-9]/)
#     sub(/[0-9][0-9][0-9][,.]/, ",&", num)
#   return num
# }

{    
  result = validate($1)

  printf(result)

  gsub(/,/, "");
  sum += $1;
}

function validate(s) {
  split(s, split_arr, ".");
  whole_num = split_arr[1];

  num_digit_sets = split(whole_num, comma_digits, ",");

  if (num_digit_sets == 1) {
    if (length(comma_digits[1] <= 3))
      return sprintf("Congrats! %s is correctly formatted.\n", s)
    else
      return sprintf("Oops! %s is incorrectly formatted.\n", s)
  } else {
    for (i = 2; i <= num_digit_sets; i++) {
      if (length(comma_digits[i]) != 3) {
        return sprintf("Oops! %s is incorrectly formatted.\n", s)
      }
    }

    return sprintf("Congrats! %s is correctly formatted.\n", s)
  }
}

END { print sum }
#! /usr/bin/awk -f

function my_gsub(input, old_str, new_str,     arr) {
  split(input, arr, old_str)
  joined = sprintf("%s", arr[1])
  for (i=2; i <= length(arr); i++) {
    joined = sprintf("%s%s%s", joined, new_str, arr[i])
  }
  return joined
}

function my_sub(input, old_str, new_str,      arr) {
  split(input, arr, old_str)
  joined = arr[1]
  for (i=2; i <= length(arr); i++) {
    replacement = i == 2 ? new_str : old_str
    joined = sprintf("%s%s%s", joined, replacement, arr[i])
  }
  return joined
}

{
  print "gsub:"
  print my_gsub($0, "a", "!")

  print "sub:"
  print my_sub($0, "a", "!")
}

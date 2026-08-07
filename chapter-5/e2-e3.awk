# The original join program from the book was basically a read-only
# program - an initially simple-looking program that gets more complex the more
# you attempt to wrap your head around it. The number of global variables,
# the short variable names ("gp", etc.), and the weird "unget" stuff really
# shows how far we've come with code quality in the modern world. This version
# is a 90% rewrite that was drastically simpler to write and to understand.
# It's probably a lit less efficient given the O(n^2) complexity but the
# original version had such absurd cognitive overhead and was so brittle
# that I don't really care.

# This code satisfies exercises 2 and 3.

BEGIN {
    OFS = sep = "\t"
		file1_line_count = 0
		file2_line_count = 0
}

# write the first file into an array
FNR == NR {
	file1_lines[file1_line_count++] = $0
    next
}

# write the second file into an array
{
	file2_lines[file2_line_count++] = $0
}

END {
	# sort file1's lines alphabetically
	asorti(file1_lines, file1_sorted_indexes)

	for (i = 0; i < length(file1_sorted_indexes); i++) {
			this_idx = file1_sorted_indexes[i]
			this_line = file1_lines[this_idx]
			this_prefix = prefix(this_line)
			this_suffix = suffix(this_line)

			for (j = 0; j < length(file2_lines); j++) {
				if (prefix(file2_lines[j]) == this_prefix) {
					printf("%s %s %s\n", this_prefix, this_suffix, suffix(file2_lines[j]))
				}
			}
  }
}

function prefix(s) { return substr(s, 1, index(s, sep) - 1) }

function suffix(s) { return substr(s, index(s, sep) + 1) }

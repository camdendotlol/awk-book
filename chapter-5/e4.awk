# Originally adapted from e2-e3.awk

# This script expects some variables to be provided via the -v argument:
# joins: Indices of columns to join on
# output_fields: Indices of columns to print
# 
# Both should be comma-separated, e.g. "1,6"
# 
# Run like this: gawk -v joins="1" -f ./e4.awk countries capitals

BEGIN {
    OFS = sep = "\t"
		file1_line_count = 0
		file2_line_count = 0

		split(joins, joins_arr, ",")

		if (output_fields) {
			split(output_fields, output_fields_arr, ",")
		}
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

	file1_column_count = get_column_count(file1_lines[1])
	file2_column_count = get_column_count(file2_lines[1])

	for (i = 1; i < length(file1_sorted_indexes); i++) {
			this_idx = file1_sorted_indexes[i]
			this_line = file1_lines[this_idx]
			this_prefix = prefix(this_line)
			this_suffix = suffix(this_line)

			for (j = 0; j < length(file2_lines); j++) {
				matches = 1

				for (k = 1; k < length(joins_arr); k++) {
					if (get_field_value(file2_lines[j], joins_arr[k]) == get_field_value(this_line, joins_arr[k])) {
						continue
					} else {
						matches = 0
						break
					}
				}

				if (matches) {
					# if the user specified output fields, only print those
					if (output_fields_arr[1]) {
						for (m = 1; m < length(output_fields_arr); m++) {
							output_str = ""
							field_idx = output_fields_arr[m]
							if (field_idx > file1_column_count) {
								file2_field_idx = field_idx - file1_column_count
								if (file2_field_idx > file2_column_count) {
									break
								} else {
									output_str = output_str " " get_field_value(file2_lines[j])
								}
							} else {
								output_str = output_str " " get_field_value(file1_lines[j])
							}
							print output_str
						}
					# if the user didn't specify output fields, print them all
					} else {
						printf("%s %s %s\n", this_prefix, this_suffix, suffix(file2_lines[j]))
					}
				}
			}
  }
}

function get_column_count(s) {
	split(s, split_arr)
	return length(split_arr)
}

function get_field_value(s, idx) { return substr(s, idx, index(s, sep) - 1)}

function prefix(s) { return substr(s, 1, index(s, sep) - 1) }

function suffix(s) { return substr(s, index(s, sep) + 1) }

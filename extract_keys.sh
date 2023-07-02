#!/bin/bash

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <input_file1> [<input_file2> ...]"
  exit 1
fi

output_file="extracted_keys.txt"

# Remove output file if it already exists
if [ -f "$output_file" ]; then
  rm "$output_file"
fi

# Regular expression pattern
pattern="[A-Z0-9]{4,5}-[A-Z0-9]{4,5}-[A-Z0-9]{4,5}"
count=0

# Loop through each input file
for input_file in "$@"; do
  # Extract matching rows from current input file using grep and regex
  grep -Eo "$pattern" "$input_file" >> "$output_file"

  # Count the number of matches in current input file
  match_count=$(grep -Eo "$pattern" "$input_file" | wc -l)
  count=$((count + match_count))
done

echo "Extraction complete. Keys from selected files have been added to $PWD/$output_file."
echo "Total extracted keys: $count"

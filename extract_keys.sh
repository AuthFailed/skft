#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <input_file> <output_file>"
  exit 1
fi

input_file="$1"
output_file="$2"

# Remove output file if it already exists
if [ -f "$output_file" ]; then
  rm "$output_file"
fi

# Regular expression pattern
pattern="[A-Z0-9]{4,5}-[A-Z0-9]{4,5}-[A-Z0-9]{4,5}"

# Extract matching rows from input file using grep and regex
grep -Eo "$pattern" "$input_file" >> "$output_file"

echo "Extraction complete. Matching rows have been added to $PWD/$output_file."


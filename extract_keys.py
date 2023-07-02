import sys
import os
import re

if len(sys.argv) != 3:
    print("Usage: {} <input_file> <output_file>".format(sys.argv[0]))
    sys.exit(1)

input_file = sys.argv[1]
output_file = sys.argv[2]

# Remove output file if it already exists
if os.path.isfile(output_file):
    os.remove(output_file)

# Regular expression pattern
pattern = r"[A-Z0-9]{4,5}-[A-Z0-9]{4,5}-[A-Z0-9]{4,5}"

# Extract keys from input file using grep and regex
with open(input_file, 'r') as f:
    content = f.read()
    grep_result = re.findall(pattern, content)
    key_count = len(grep_result)

if not grep_result:
    print("No keys found in {}.".format(input_file))
else:
    # Write the extracted keys to output file
    with open(output_file, 'w') as f:
        f.write('\n'.join(grep_result))
    print("Extraction complete. {} key(s) have been extracted to {}/{}.".format(
        key_count, os.getcwd(), output_file))

import sys
import re

if len(sys.argv) < 2:
    print("Usage: python script.py input_file1 [input_file2 ...]")
    sys.exit(1)

output_file = "extracted_keys.txt"

# Remove output file if it already exists
try:
    os.remove(output_file)
except FileNotFoundError:
    pass

# Regular expression pattern
pattern = r"[A-Z0-9]{4,5}-[A-Z0-9]{4,5}-[A-Z0-9]{4,5}"
count = 0

# Loop through each input file
for input_file in sys.argv[1:]:
    with open(input_file, 'r') as file:
        content = file.read()
        matches = re.findall(pattern, content)

        with open(output_file, 'a') as output:
            for match in matches:
                output.write(match + '\n')

        match_count = len(matches)
        count += match_count

print("Extraction complete. Keys from selected files have been added to {}.".format(output_file))
print("Total extracted keys: {}".format(count))

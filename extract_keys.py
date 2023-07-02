#!/usr/bin/env python3

import argparse
import re

key_pattern = r"[A-Z0-9]{4,5}-[A-Z0-9]{4,5}-[A-Z0-9]{4,5}"
game_name_pattern = r"Товар Корзина #[0-9]+ (.*?) \|"

output_file = "extracted_keys.txt"

# Function to print the script usage
def print_usage():
    print("Usage: python script.py [options] <input_file1> [<input_file2> ...]")
    print("Options:")
    print("  -n, --game-name    Extract and append the game name to the key")

# Parse command line arguments
parser = argparse.ArgumentParser()
parser.add_argument("-n", "--game-name", action="store_true", help="Extract and append the game name to the key")
parser.add_argument("input_files", nargs="+", help="Input file(s)")
args = parser.parse_args()

extract_game_name = args.game_name
input_files = args.input_files

count = 0

# Open the output file
with open(output_file, "w") as f:
    for input_file in input_files:
        with open(input_file, "r") as file:
            for line in file:
                # Extract the key using regex
                match_key = re.search(key_pattern, line)
                if match_key:
                    key = match_key.group(0)

                # Extract the game name using regex if the flag is set
                if extract_game_name:
                    match_game_name = re.search(game_name_pattern, line)
                    if match_game_name:
                        game_name = match_game_name.group(1)

                # If both key and game name are extracted (or only key if the flag is not set), write them to the output file
                if key:
                    if extract_game_name and game_name:
                        f.write(f"{key} {game_name}\n")
                    else:
                        f.write(f"{key}\n")
                    count += 1
                    key = ""
                    game_name = ""

print("Extraction complete. Keys", end=" ")
if extract_game_name:
    print("and game names", end=" ")
print(f"from selected files have been added to {output_file}.")
print(f"Total extracted keys: {count}")

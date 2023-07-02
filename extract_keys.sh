#!/bin/bash

extract_game_name=false
output_file="extracted_keys.txt"
key_pattern="[A-Z0-9]{4,5}-[A-Z0-9]{4,5}-[A-Z0-9]{4,5}"
game_name_pattern="Товар Корзина #[0-9]+ (.*) \|"

# Function to print the script usage
print_usage() {
  echo "Usage: $0 [options] <input_file1> [<input_file2> ...]"
  echo "Options:"
  echo "  -n, --game-name    Extract and append the game name to the key"
}

# Process command line arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    -n|--game-name)
      extract_game_name=true
      shift
      ;;
    -h|--help)
      print_usage
      exit 0
      ;;
    *)
      break
      ;;
  esac
done

# Check if at least one input file is provided
if [ "$#" -lt 1 ]; then
  print_usage
  exit 1
fi

# Remove output file if it already exists
if [ -f "$output_file" ]; then
  rm "$output_file"
fi

count=0

# Loop through each input file
for input_file in "$@"; do
  # Read the contents of the current input file
  while IFS= read -r line; do
    # Extract the key using regex
    if [[ $line =~ $key_pattern ]]; then
      key="${BASH_REMATCH[0]}"
    fi

    # Extract the game name using regex if the flag is set
    if [[ $extract_game_name = true && $line =~ $game_name_pattern ]]; then
      game_name="${BASH_REMATCH[1]}"
    fi

    # If both key and game name are extracted (or only key if the flag is not set), write them to the output file
    if [[ -n $key ]]; then
      if [[ $extract_game_name = true && -n $game_name ]]; then
        echo "${key} ${game_name}" >> "$output_file"
      else
        echo "$key" >> "$output_file"
      fi
      count=$((count + 1))
      key=""
      game_name=""
    fi
  done < "$input_file"
done

echo "Extraction complete. Keys"
if [[ $extract_game_name = true ]]; then
  echo "and game names"
fi
echo "from selected files have been added to $PWD/$output_file."
echo "Total extracted keys: $count"

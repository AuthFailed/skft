Hi!

# Versions
There three versions of this scripts:
- For Windows
- For Unix-like systems
- For Python

If you want to use this script on any of your systems you can use Python version
Either you can use native version for your system

# Installation
Script doesn't require any specific software besides Python version, which requires Python 3.* installed.
Just download script and run.

# Using
## Windows
Open CMD and run
```extract_keys.bat *input_file_path* *output_file*```
in same directory with script

## Unix-like
Open terminal and give launch permission to script:
```
chmod +x extract_keys.sh
```
Then launch script:
```
./extract_keys.sh *input_file_path* *output_file*
```

## Python
First, install Python. Installation may vary from system.
Then, in terminal run:
```
python extract_keys.py *input_file_path* *output_file*
```

In all this cases output file will be placed in the same directory with script

# Example
Let's imagine that you have a file with keys, but in addition to the keys, it has extra text.
Script extracting all keys from input file in the next format:

Example file:
```
========================== Product  #21703391 House of Detention (18+) | Quantity: 1 ==========================
XXXX-XXXX-XXXX
========================== End of Product #21703406==========================

========================== Product  #21703391 Defense of Egypt: Cleopatra Mission | Quantity: 1 ==========================
AAAA-BBBB-CCCC
========================== End of Product #21703405==========================

========================== Product  #21703391 Neighboring Islands | Quantity: 1 ==========================
DDDD-EEEE-FFFF
========================== End of Product #21703404==========================
```

And after executing of script we get this:
```
XXXX-XXXX-XXXX
AAAA-BBBB-CCCC
DDDD-EEEE-FFFFq

The script is ideal for bulk key activation via [ASF](https://github.com/JustArchiNET/ArchiSteamFarm).

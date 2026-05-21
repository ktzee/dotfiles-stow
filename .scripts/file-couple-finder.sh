#!/bin/bash

# This script finds .zip files without a corresponding .chd file in the current directory.

# Check if the directory is empty of .zip files
if ! ls *.zip >/dev/null 2>&1; then
    echo "No .zip files found in the current directory."
    exit 0
fi

echo "Searching for missing .chd files..."

# Loop through each .zip file in the current directory
for zip_file in *.zip; do
    # Remove the .zip extension to get the base name
    base_name="${zip_file%.zip}"

    # Check if a file with the .chd extension and the same base name exists
    if [ ! -f "${base_name}.chd" ]; then
        # If it doesn't exist, print the name of the missing file couple
        echo "Missing .chd counterpart for: ${zip_file}"
    fi
done

echo "Search complete."

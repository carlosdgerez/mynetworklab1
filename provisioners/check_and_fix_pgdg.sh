#!/bin/bash

# Define the expected content
EXPECTED_REPO="deb https://apt-archive.postgresql.org/pub/repos/apt bionic-pgdg main"
FILE_PATH="/etc/apt/sources.list.d/pgdg.list"

# Check if the file exists
if [ -f "$FILE_PATH" ]; then
  # Check if the expected content is already present
  if grep -Fxq "$EXPECTED_REPO" "$FILE_PATH"; then
    echo "The repository is already correctly configured."
  else
    echo "The repository is incorrect. Fixing it..."
    echo "$EXPECTED_REPO" | tee "$FILE_PATH"
    echo "Repository updated."
  fi
else
  echo "The repository file is missing. Creating it..."
  echo "$EXPECTED_REPO" | tee "$FILE_PATH"
  echo "Repository file created and configured."
fi

# Update the package list and install the postgresql-14
echo "Updating the package list..."
apt-get update
apt-get install -y postgresql-14

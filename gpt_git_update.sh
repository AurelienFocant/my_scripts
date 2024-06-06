#!/bin/bash

# Loop through each subdirectory in the current directory
for dir in */ ; do
  echo ""
  echo "---------------------------------------------"
  # Check if the directory contains a .git folder
  if [ -d "$dir/.git" ]; then
    echo "Entering directory: $dir"
    cd "$dir"
    
    # Execute git fetch and git status
    echo "Fetching updates..."
    git fetch -v
    
    echo "Checking status..."
    git status
    
    # Return to the parent directory
    echo "Leaving directory: $dir"
    cd ..
  else
    echo "$dir is not a git repository"
  fi
  echo "---------------------------------------------"
done

echo ""

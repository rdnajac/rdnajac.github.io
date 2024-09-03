#!/bin/bash

(cd resume && make clean && make install && make clean)

git status
git add .
echo "All changes added to the repository."
git status
echo "Enter your commit message:"
read commit_message
git commit -m "$commit_message"
git push

echo "Resume updated and changes pushed to repository."

#!/bin/bash

(cd resume && make clean && make install && make clean)

git status
git add .

echo "Enter your commit message:"
read commit_message

git commit -m "$commit_message"
git push

echo "Resume updated and changes pushed to repository."

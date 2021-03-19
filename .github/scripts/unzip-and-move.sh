for file in $(git diff-tree -r HEAD --name-only --no-commit-id); do echo $file; done
# files=$(git diff-tree -r $GITHUB_SHA --name-only --no-commit-id)
# echo "Commit:"
# echo $GITHUB_SHA
# echo "Files changed:"
# echo "$files"
# for file in $files; do
#     echo "In for loop"
#     echo $file
#     if [ "${file##*.}" = "zip" ]; then 
#         echo "Found zip file"
#         unzip -d tmpoutdir $file
#         mkdir outdir
#         mv tmpoutdir/*/out/* outdir
#         rm -rf tmpoutdir
#         echo "Files in zip out/:"
#         ls outdir
#     else
#         echo "No zip file here"
#     fi
# done
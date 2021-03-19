echo "Apa" > $GITHUB_WORKSPACE/tmpfile
echo $GITHUB_SHA >> $GITHUB_WORKSPACE/tmpfile
git diff-tree -r $GITHUB_SHA --name-only --no-commit-id >> $GITHUB_WORKSPACE/tmpfile
cat $GITHUB_WORKSPACE/tmpfile
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
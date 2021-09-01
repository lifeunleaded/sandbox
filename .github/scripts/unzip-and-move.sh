files=$(git show HEAD --name-only --oneline | awk FNR-1)
# Get the list of changed files, and output some diagnostics in the job log.
echo "Commit:"
echo $GITHUB_SHA
echo "Files changed:"
echo "$files"
for file in $files; do
    echo "File changed:"
    echo $file
    # Check if the list of changed files contains a zip archive.
    # Also check that the file exists, since zip files in the list
    # if the commit removes them.
    if [ "${file##*.}" = "zip" ] && [ -f $file ]; then 
        echo "Found zip file"
        # Unzip and move the publication to docs/,
        # which is the base for this Pages setup.
        unzip -d tmpoutdir $file
        cp -rf tmpoutdir/*/out/* docs/
        rm -rf tmpoutdir
        cd docs
        git add -A .
        cd ..
        git rm $file
        git commit -a -m "Publishing"
        git push origin staging
    else
        echo "No zip file here"
    fi
done
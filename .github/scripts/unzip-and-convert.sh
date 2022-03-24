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
        pandoc -f docbook -t markdown tmpoutdir/*/out/*.xml -o README.md
        rm -rf tmpoutdir
        git add README.md
        git rm -f $file
        git commit -a -m "Updated README.md from Paligo"
        git push origin markdown
    else
        echo "No zip file here"
    fi
done
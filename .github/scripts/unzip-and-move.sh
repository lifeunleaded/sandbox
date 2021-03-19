files=$(git show HEAD --name-only --oneline | awk FNR-1)
echo "Commit:"
echo $GITHUB_SHA
echo "Files changed:"
echo "$files"
for file in $files; do
    echo "In for loop"
    echo $file
    if [ "${file##*.}" = "zip" ]; then 
        echo "Found zip file"
        unzip -d tmpoutdir $file
        cp -rf tmpoutdir/*/out/* docs/
        rm -rf tmpoutdir
        cd docs
        git add -A .
        git commit -a -m "Publishing"
        git push origin staging
    else
        echo "No zip file here"
    fi
done
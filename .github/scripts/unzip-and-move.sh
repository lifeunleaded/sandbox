files=$(git diff-tree HEAD --name-only --no-commit-id)
echo "Files changed:"
git diff-tree HEAD --name-only --no-commit-id
echo $GITHUB_WORKSPACE
ls $GITHUB_WORKSPACE
env
for file in $files
do
    if [ "${file##*.}" = "zip" ]
    then 
        echo "Found zip file"
        unzip -d tmpoutdir $file
        mkdir outdir
        mv tmpoutdir/*/out/* outdir
        rm -rf tmpoutdir
        echo "Files in zip out/:"
        ls outdir
    else
        echo "No zip file here"
    fi
done
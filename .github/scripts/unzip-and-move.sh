files=$(git diff-tree HEAD --name-only --no-commit-id)
for file in files
do
    if [ "${file##*.}" = "zip" ]
    then 
        echo "Found zip file"
        unzip -d tmpoutdir file
        mkdir outdir
        mv tmpoutdir/*/out/* outdir
        ls outdir
    else
        echo "No zip file here"
    fi
done
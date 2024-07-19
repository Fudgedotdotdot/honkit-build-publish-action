# Inspired by https://github.com/onejar99/gitbook-build-publish-action

function checkIfErr() {
    ret=$?
    echo "ret=[${ret}]"
    if [ ! $ret = '0' ]; then
        echo "Oops something wrong! exit code: ${ret}"
        exit $ret;
    fi
}

echo '[INFO] Building static website...'
cd ${GITHUB_WORKSPACE}

honkit build
ls -alt _book/


# checkout to the gh-pages branch
git checkout gh-pages

# pull the latest updates
git pull origin gh-pages --rebase

# copy the static site files into the current directory.
cp -R _book/* .

# remove 'node_modules' and '_book' directory
git clean -fx node_modules
git clean -fx _book

# add all files
git add .

git log


# commit
#git commit -a -m "Update docs"

# push to the origin
#git push origin gh-pages

# checkout to the master branch
#git checkout master
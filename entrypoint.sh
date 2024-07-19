echo "[INFO] Environment stuff here..."

echo "USER_NAME=[$USER_NAME]"
echo "USER_EMAIL=[$USER_EMAIL]"

echo '[INFO] Building static website...'
cd ${GITHUB_WORKSPACE}
git config --global --add safe.directory /github/workspace

honkit build

echo '[INFO] Some magic to merge main into gh-pages...'
git fetch origin gh-pages --depth 1
git checkout gh-pages
git rebase main

cp -R _book/* .
git clean -fx node_modules
git clean -fx _book
git add .

git config --local user.name "$USER_NAME"
git config --local user.email "$USER_EMAIL"

echo '[INFO] Pushing gh-pages...'
git commit -am "Deploying to Github Pages (from $(echo $GITHUB_SHA | cut -c1-7))"
git push origin HEAD:gh-pages --force
git checkout main
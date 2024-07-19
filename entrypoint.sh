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

git config --local user.name "Fudgedotdotdot"
git config --local user.email "28399056+Fudgedotdotdot@users.noreply.github.com"

echo '[INFO] Pushing gh-pages...'
git commit -am "Updated with:  $(echo $GITHUB_SHA | cut -c1-7)"
git push origin HEAD:gh-pages --force
git checkout main
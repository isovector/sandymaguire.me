#!/usr/bin/env bash

set -xe

echo "deploying on server..."
stack build
stack exec wcst
rm -rf docs/
mkdir docs
mv dist/* docs/
git checkout docs/CNAME
git checkout docs/dailystats/
git add docs
git commit -m "automatic deploy"
git push


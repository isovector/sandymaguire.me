#!/bin/bash

set +xe

echo "deploying on server..."
stack build
stack exec wcst
rm -rf docs/
mkdir docs
mv dist/* docs/
git add docs
git commit -m "i am excellent at programming"
git push


#!/usr/bin/zsh

source /home/sandy/.zshrc

set -x
cd /home/sandy/prj/arbtt-graph/
./update
cd /home/sandy/prj/sandymaguire.me
rm -rf docs/dailystats
cp -R ../arbtt-graph/render docs/dailystats
git add docs/dailystats
git commit "update daily stats"
git push


#!/usr/bin/zsh

source /home/sandy/.zshrc

set -x
cd /home/sandy/prj/arbtt-graph/
./update
cd /home/sandy/prj/sandymaguire.me
rm -rf dist/dailystats
cp -R ../arbtt-graph/render dist/dailystats
rsync -r -a -v -e "ssh -i $HOME/.ssh/santino.pem" dist/ "ubuntu@$SERENADE:/data/blog/_live/we-can-solve-this/"


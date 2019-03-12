#!/bin/bash

echo "deploying on server..."
stack build
stack exec wcst
cp -Rv ../arbtt-graph/render dist/dailystats
rsync -r -a -v -e "ssh -i $HOME/.ssh/santino.pem" dist/ "ubuntu@$SERENADE:/data/blog/_live/we-can-solve-this/"


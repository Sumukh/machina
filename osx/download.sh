#!/bin/sh

cd ~;
git clone https://github.com/Sumukh/machina.git;
cd machina/osx;
git checkout -b $USER
echo "Running Machina setup (setup.sh)"
source setup.sh
#!/bin/sh

path=`git rev-parse --show-toplevel`
cd $path
git ls-files --others --ignored --exclude-standard

#!/bin/sh
pushd scripts
python build.py
python run.py
popd

#!/bin/sh
pushd scripts
python build_sprites.py
python build.py
python run.py
popd

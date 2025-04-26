#!/usr/bin/bash

# change extension from .iso.chd to .chd in cwd
for f in *.iso.chd; do mv -- "$f" "${f%.iso.chd}.chd"; done

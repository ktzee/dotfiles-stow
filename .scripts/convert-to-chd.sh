#!/usr/bin/bash

# convert all .iso to .chd in cwd
find . -name "*iso" -exec chdman createcd -i {} -o {}.chd \;

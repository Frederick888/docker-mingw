#!/bin/sh

cd /builds
curl -O -L -J http://gnuwin32.sourceforge.net/downlinks/libgw32c-src-zip.php
unzip $(ls libgw32c*.zip) -d libgw32c
cd /builds/libgw32c/src/libgw32c/0.4/libgw32c-0.4

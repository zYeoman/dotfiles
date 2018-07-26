#!/bin/sh
echo "env DISPLAY=:0 feh ~/.lock.png" |at now+25 minutes

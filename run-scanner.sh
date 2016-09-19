#!/bin/sh

# This script can work with crontab and run zmap automatically.

export PATH=/usr/local/bin:/usr/local/sbin:$PATH

if [ -n "$(pgrep zmap)"  ]
then
    echo "[`date -R`]: zmap is running, exit."
else
    echo "[`date -R`]: zmap is not running. start zmap."
    cd /root/auto-zmap && python run-scanner.py
    echo "done."
fi

exit 0

#!/bin/sh
echo $(date) cron backup start
rsync -a --update /data/ /backup
echo $(date) cron backup end

#!/bin/sh

handler() {
    echo start graceful shutdown process
    kill ${child_pid}
    wait ${child_pid}

    sleep 10s
    sh /backup.sh
}

trap handler SIGTERM

crond -d 8 -f &
child_pid=$!

wait ${child_pid}

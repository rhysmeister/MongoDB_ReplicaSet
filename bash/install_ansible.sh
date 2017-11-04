#!/bin/bash
set -u;

function is_installed() {
        PACKAGE="$1";
        yum list installed "$PACKAGE" >/dev/null ;
        return $?
}

is_installed ansible || sudo yum install -y ansible;

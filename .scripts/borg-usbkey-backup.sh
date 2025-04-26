#!/bin/bash

repodir="borg"
dir="$(dirname "$0")"

cd "$dir" || exit 1

borg create -svp "$repodir::${HOSTNAME}_{utcnow}" \
    ~/.gnupg             \
    ~/.password-store    \
    ~/.ssh

cd - || exit 1

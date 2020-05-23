#!/bin/bash
set -o nounset
set -o errexit
set -o pipefail

# NOTE: RUN AS USER!

function mkdir_ifnot_exist() {
    if [[ $# != 1 ]]; then
        echo "mkdir_ifnot_exist(): don't have enough arguments!"
        exit 1
    fi

    local dir=$1

    if [ ! -d $dir ]; then
        mkdir -p $dir
        echo "mkdir -p $dir"
    fi
}

if [[ $1 == 'user' ]]; then
    if [ `id -u` -eq 0 ];then
        echo "THIS COMMAND NEED RUN AS USER!"
        exit 1
    fi

        # aria2
        touch ~/.aria2/aria2.session

        # install vim plugin
        mkdir_ifnot_exist ~/.vim/.backup
        mkdir_ifnot_exist ~/.vim/.swp
        mkdir_ifnot_exist ~/.vim/.undo
        mkdir_ifnot_exist ~/.vim/.info

        # Open vim and type `:PlugInstall`

        # Open tmux and press prefix + I (capital i, as in Install) to fetch the plugin.

        # Enable systemd user services
        systemctl enable --user mpd
        systemctl enable --user aria2c
fi

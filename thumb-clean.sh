#! /usr/bin/env bash

set -o noclobber  # Avoid overlay files (echo "hi" > foo)
set -o errexit    # Used to exit upon error, avoiding cascading errors
set -o pipefail   # Unveils hidden failures
set -o nounset    # Exposes unset variables

#X=$(ls -l /dev/disk/by-id/usb* | awk '{print $9}')

help_text() {
    echo "Help text goes here"
}

get_td_path() {
    my_array=()
    mapfile -t my_array < <( ls -l /dev/disk/by-id/usb* | awk '{print $9}')
    td_path=$(readlink -f "${my_array[0]}")
    echo "$td_path"
    
}

wipe_drive_zeros() {
    echo $1
    # dd if=/dev/zero of=/dev/sdX bs=1M status=progress
}

wipe_drive_rand() {
    echo $1
    # dd if=/dev/urandom of=/dev/sdX bs=1M status=progress
}

td_path=$(get_td_path)

while true; do
    echo "A thumb drive has been detected at ${td_path}." input
    read -p "Is this the correct drive to wipe?"
    case "$input" in
        [yY][eE][sS][yY])
            continue
        ;;
        [nN][oO][nN])
            echo "stopping script"
            exit 0
        ;;
    esac
done





echo $x
case "$1" in
    -r | --rand)
        wipe_drive_rand "rand_test"
    ;;
    -z | --zeros)
        wipe_drive_zeros "zero_test"
    ;;
    -h | --help)
        help_text
    ;;
    *)
        echo "Unknown option!"
        help_text
    ;;
esac

#! /bin/sh -ex

ZBE_ZMK_CONFIG_DIR="$(realpath $(dirname $0)/..)"

docker run --name "keymap-drawer" --rm -it -w /wd \
    --mount type=bind,source="${ZBE_ZMK_CONFIG_DIR}",target=/zmk-config \
    rgbj/keymap-drawer

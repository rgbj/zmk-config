#! /bin/sh -ex

ZBE_ZMK_CONFIG_DIR="$(realpath $(dirname $0)/..)"

docker build -t rgbj/keymap-drawer "${ZBE_ZMK_CONFIG_DIR}"/keymap-drawer


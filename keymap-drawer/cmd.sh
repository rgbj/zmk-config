#! /bin/sh -ex

cd /zmk-config/keymap-drawer

keymap -c config.yaml parse -z /zmk-config/config/*.keymap > keymap.yaml
keymap -c config.yaml draw keymap.yaml > keymap.svg

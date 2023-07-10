#! /bin/sh -ex

git config --global --add safe.directory /zmk-config
BUILD_ID=$(cd /zmk-config && git rev-parse --abbrev-ref HEAD)_$(cd /zmk-config && git rev-parse --short HEAD)_$(date +%Y%m%d-%H%M%S)

west zephyr-export

for side in left right
do
    shield=""
    if [ -n "${ZBE_SHIELD}" ]; then
        shield="-DSHIELD=${ZBE_SHIELD}_${side}"
    fi
    board="${ZBE_BOARD}"
    if [ -n "${ZBE_BOARD_left}" -a "${side}" = left ]; then
        board="${ZBE_BOARD_left}"
    fi
    if [ -n "${ZBE_BOARD_right}" -a "${side}" = right ]; then
        board="${ZBE_BOARD_right}"
    fi
    west build -b ${board} -d build/${side} zmk/app -- -DZMK_CONFIG=/wd/config ${shield}
    cp build/${side}/zephyr/zmk.uf2 /output/zmk_${BUILD_ID}_${side}.uf2
done

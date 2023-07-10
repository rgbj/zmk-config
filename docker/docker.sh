#! /bin/sh -ex

# configure:
ZBE_ID="kbd"
ZBE_ZMK_VERSION="3.2" # what ZMK version to use
ZBE_ENV="main" # an informational tag about the ZMK build env
ZBE_OUTPUT="${HOME}/Downloads/${ZBE_ID}" # where the artifacts end up
# and either:
#ZBE_BOARD_left=board_left
#ZBE_BOARD_right=board_right
# or:
#ZBE_BOARD=board
#ZBE_SHIELD=shield
# end configure

ZBE_ZMK_CONFIG_DIR="$(realpath $(dirname $0)/..)"

docker run --name "zmk-build-${ZBE_ID}" --rm -it -w /wd \
    --mount type=bind,source="${ZBE_ZMK_CONFIG_DIR}",target=/zmk-config,readonly \
    --mount type=bind,source="${ZBE_ZMK_CONFIG_DIR}/docker",target=/docker,readonly \
    --mount type=volume,source="zbe-${ZBE_ID}-${ZBE_ZMK_VERSION}-${ZBE_ENV}",target=/wd \
    --mount type=bind,source="${ZBE_ZMK_CONFIG_DIR}/config",target=/wd/config,readonly \
    --mount type=bind,source="${ZBE_OUTPUT}",target=/output \
    -e MAKEFILES=/docker/Makefile \
    -e ZBE_BOARD_left="${ZBE_BOARD_left}" -e ZBE_BOARD_right="${ZBE_BOARD_right}" \
    -e ZBE_BOARD="${ZBE_BOARD}" -e ZBE_SHIELD="${ZBE_SHIELD}" \
    zmkfirmware/zmk-dev-arm:"${ZBE_ZMK_VERSION}" "$@"

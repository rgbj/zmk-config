#! /bin/sh

ZBE_ZMK_VERSION="3.2" # what ZMK version to use
ZBE_ENV="rgbj-ciz"    # an informational tag about the ZMK build env

# end configure

ZBE_TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
ZBE_ZMK_CONFIG_DIR="$(realpath $(dirname $0)/..)"

for ZBE_ID in ${ZBE_IDS:-ciz}; do
    echo "${ZBE_ID}"
    ZBE_OUTPUT="${HOME}/Downloads/zbe/${ZBE_ID}" # where the artifacts end up
    case "${ZBE_ID}" in
    ciz)
        ZBE_BOARD_left=corneish_zen_v2_left
        ZBE_BOARD_right=corneish_zen_v2_right
        ZBE_BOARD=
        ZBE_SHIELD=
        ;;
    rollow)
        ZBE_BOARD_left=
        ZBE_BOARD_right=
        ZBE_BOARD=nice_nano_v2
        ZBE_SHIELD=rollow
        ;;
    esac

    docker run --name "zmk-build-${ZBE_ID}" --rm -it -w /wd \
        --mount type=bind,source="${ZBE_ZMK_CONFIG_DIR}",target=/zmk-config,readonly \
        --mount type=bind,source="${ZBE_ZMK_CONFIG_DIR}/docker",target=/docker,readonly \
        --mount type=volume,source="zbe-${ZBE_ID}",target=/wd \
        --mount type=bind,source="${ZBE_ZMK_CONFIG_DIR}/config",target=/wd/config,readonly \
        --mount type=bind,source="${ZBE_OUTPUT}",target=/output \
        -e ZBE_TIMESTAMP="${ZBE_TIMESTAMP}" \
        -e MAKEFILES=/docker/Makefile \
        -e ZBE_BOARD_left="${ZBE_BOARD_left}" -e ZBE_BOARD_right="${ZBE_BOARD_right}" \
        -e ZBE_BOARD="${ZBE_BOARD}" -e ZBE_SHIELD="${ZBE_SHIELD}" \
        -e ZBE_SIDES="${ZBE_SIDES:-left}" \
        zmkfirmware/zmk-dev-arm:"${ZBE_ZMK_VERSION}" "$@"
done



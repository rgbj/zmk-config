# ZMK keymap

## boards

- [Corne-ish Zen](https://lowprokb.ca/products/corne-ish-zen), using [caksoylar's ZMK](https://github.com/caksoylar/zmk)
- [Rollow](https://www.barbellboards.com/product/rollow), using [nickconway's ZMK](https://github.com/nickconway/zmk)

## building

Ensure docker is available. On macos, see https://github.com/abiosoft/colima. Then:

```sh
$ docker/docker.sh make init|update|build
```

The script will use a volume to store intermediate build state. `init` needs to be run once, `update` once or whenever dependencies need refreshing, `build` for building the firmware. 

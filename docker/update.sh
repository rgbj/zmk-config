#! /bin/sh -ex

while ! west update; do
    sleep 3
done

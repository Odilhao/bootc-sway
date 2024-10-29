SHELL := /bin/bash

IMAGE_NAME=sway-bootc

build:
	sudo podman build -t $(IMAGE_NAME) -f Containerfile

anaconda-iso:
	sudo podman run \
    --rm \
    -it \
    --privileged \
    --pull=newer \
    --security-opt label=type:unconfined_t \
    -v ./output:/output \
    -v ./config.toml:/config.toml:ro \
    -v /var/lib/containers/storage:/var/lib/containers/storage \
    quay.io/centos-bootc/bootc-image-builder:latest \
    --type anaconda-iso \
    --rootfs btrfs \
     ghcr.io/odilhao/bootc-sway:latest
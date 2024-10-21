SHELL := /bin/bash

IMAGE_NAME=sway-bootc

build:
	sudo podman build -t $(IMAGE_NAME) -f Containerfile
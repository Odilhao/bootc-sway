### Bootc Alternative of SwayWM for Fedora

This repo was inspired by [bootc for Desktops?? Tell me more!](https://mrguitar.net/?p=2627), with the assumption that if KDE is a viable option for bootc why not swaywm?

You can build the image by simply using `make build`, this will generate one image called `sway-bootc`.

It's possible to use the file `config.toml` to set the user/password and the ssh-key to be deployed in the image:

`cp config.toml.example config.toml`

To generate the inital ISO the following command can be used:


```bash
sudo podman run \
    --rm \
    -it \
    --privileged \
    --pull=newer \
    --security-opt label=type:unconfined_t \
    -v $(pwd)/output:/output \
    -v /var/lib/containers/storage:/var/lib/containers/storage \
    quay.io/centos-bootc/bootc-image-builder:latest \
    --local \
    --type qcow2 \
    --rootfs btrfs \
    sway-test:latest
```

Here I'm using `btrfs` as filesystem, you can switch to `xfs` if necessary

To test locally qemu or libvirt can be used: 

### qemu

```bash
qemu-system-x86_64 \
    -M accel=kvm \
    -cpu host \
    -smp 2 \
    -m 4096 \
    -bios /usr/share/OVMF/OVMF_CODE.fd \
    -serial stdio \
    -snapshot output/qcow2/disk.qcow2
```

### libvirt

```
sudo virt-install \
    --name fedora-bootc \
    --cpu host \
    --vcpus 4 \
    --memory 4096 \
    --import --disk ./output/qcow2/disk.qcow2,format=qcow2 \
    --os-variant fedora-eln
```



References:

1 - https://mrguitar.net/?p=2627
2 - https://docs.fedoraproject.org/en-US/bootc/qemu-and-libvirt/
3 - https://pagure.io/fedora-kickstarts/blob/main/f/fedora-live-sway.ks
4 - https://pagure.io/fedora-kickstarts/blob/main/f/fedora-sway-common.ks
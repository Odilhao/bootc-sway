FROM quay.io/fedora/fedora-bootc:41
LABEL org.opencontainers.image.source="https://github.com/Odilhao/bootc-sway"

RUN mkdir -p /var/roothome /data /var/home

RUN dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

RUN dnf install -y fedora-release-sway && \
    dnf group install -y "swaywm-extended"

#Spliting into 2 layers to reduce pul time with more layers
RUN dnf install -y firefox bash-completion bcache-tools bwm-ng  cups cups-browsed dmraid ethtool firefox firewalld fwupd gdb git htop input-leap lm_sensors nfs-utils nss-mdns pcp pcp-selinux powertop qemu-kvm samba sysstat thermald tuned vim-enhanced vulkan-tools xdpyinfo wget && \
    dnf swap -y ffmpeg-free ffmpeg --allowerasing && dnf install -y @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin && dnf group install -y "Sound and Video" && dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld && dnf swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld && \
    dnf install -y krb5-workstation podman libvirt-daemon pavucontrol vim git-annex  virt-install virt-manager openvpn blueman bluez NetworkManager-bluetooth


RUN systemctl enable lm_sensors sysstat tuned fstrim.timer libvirtd.socket sddm && \
systemctl set-default graphical.target
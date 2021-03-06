FROM debian:jessie
MAINTAINER leejoneshane@gmail.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get --fix-missing update \
    && apt-get upgrade -y\
    && apt-get -y --no-install-recommends install apt-utils \
util-linux tar gzip bzip2 lzop pigz pbzip2 procps dialog rsync parted pciutils tcpdump bc gawk hdparm sdparm netcat file ethtool etherwake ssh syslinux syslinux-common syslinux-efi isolinux pxelinux mtools reiserfsprogs e2fsprogs psmisc locales wget disktype zip unzip patch iproute traceroute iputils-ping binutils expect partimage udpcast debconf-utils txt2html dosfstools ecryptfs-utils initscripts tftpd-hpa nfs-kernel-server nis curl lftp iptables memtest86+ ntfs-3g \
lvm2 ntfs-3g genisoimage lshw hwinfo aoetools dmidecode lzop lzma xz-utils pixz lzip pigz pbzip2 lbzip2 plzip lrzip pv hfsutils hfsprogs dmsetup dmraid kpartx tofrodos dos2unix isc-dhcp-server gdisk btrfs-tools disktype efibootmgr syslinux-utils tftp-server  grub-efi-amd64-bin grub-efi-ia32-bin \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen "en_US.UTF-8" \
    && dpkg-reconfigure locales \
    && apt-get clean all
RUN echo "deb http://free.nchc.org.tw/debian/ jessie main" >> /etc/apt/sources.list \
    && echo "deb http://free.nchc.org.tw/drbl-core drbl stable" >> /etc/apt/sources.list \
    && wget -q http://drbl.nchc.org.tw/GPG-KEY-DRBL -O- | apt-key add - \
    && mkdir -p /run/sendsigs.omit.d 
RUN apt-get update \
    && apt-get -y install drbl clonezilla partclone ipxe lzop pigz pbzip2 udpcast \
       mkswap-uuid partclone drbl-chntpw mkpxeinitrd-net freedos \
    && apt-get clean all

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.utf-8
ENV LC_ALL en_US.UTF-8

VOLUME ["/tftpboot", "/home/partimag"]
EXPOSE 68/udp 111/udp 2049/tcp
CMD ["drbl4imp -e -b -p 40"]



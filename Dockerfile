FROM debian
MAINTAINER leejoneshane@gmail.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get --fix-missing update \
    && apt-get -y --no-install-recommends install wget gnupg libnss3 apt-utils locales \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen "en_US.UTF-8" \
    && dpkg-reconfigure locales \
    && echo "deb http://free.nchc.org.tw/debian/ jessie main" >> /etc/apt/sources.list \
    && echo "deb http://free.nchc.org.tw/drbl-core drbl stable" >> /etc/apt/sources.list \
    && wget -q http://drbl.nchc.org.tw/GPG-KEY-DRBL -O- | apt-key add - \
    && mkdir -p /run/sendsigs.omit.d \
    && apt-get -y install drbl clonezilla partclone ipxe lzop pigz pbzip2 udpcast \
    && apt-get clean all

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.utf-8
ENV LC_ALL en_US.UTF-8

VOLUME ["/tftpboot", "/home/partimag"]
EXPOSE 68/udp 111/udp 2049/tcp
CMD ["drbl4imp -e -b -p 40"]



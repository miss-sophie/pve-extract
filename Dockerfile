FROM debian:buster

WORKDIR /tmp

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y apt-utils wget libglib2.0-0 libiscsi7 librbd1 libaio1 lzop glusterfs-common libcurl3-gnutls lzop libjemalloc-dev qemu-utils gnupg2 && \
	echo "deb http://download.proxmox.com/debian/pve buster pve-no-subscription" > /etc/apt/sources.list.d/pve-no-subscription-repo.list && \
	wget http://download.proxmox.com/debian/proxmox-ve-release-6.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg && \
  apt-get update && \
	apt full-upgrade -y && \
  apt-get download -y pve-qemu-kvm && \
  dpkg --fsys-tarfile ./pve-qemu-kvm*.deb | tar xOf - ./usr/bin/vma > ./vma && \
  chmod u+x ./vma && \
  mv ./vma /usr/local/bin && \
  mkdir -p /extract && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY extract.sh /usr/local/bin/

WORKDIR /extract

VOLUME /extract

CMD [ "bash", "extract.sh" ]

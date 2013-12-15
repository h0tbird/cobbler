#!/bin/bash

#---------
# Define:
#---------

name='Fedora_19-x86_64'
arch='x86_64'
breed='redhat'
version='fedora19'

#---------
# Create:
#---------

[[ ! -d "/var/www/cobbler/ks_mirror/${name}" ]] && mkdir /var/www/cobbler/ks_mirror/${name}
ln -s /var/www/cobbler/ks_mirror/${name} /var/www/cobbler/links/${name}
ln -s /var/www/cobbler/repo_mirror/${name}-base/Packages /var/www/cobbler/ks_mirror/${name}/
ln -s /var/www/cobbler/repo_mirror/${name}-base/cache /var/www/cobbler/ks_mirror/${name}/
ln -s /var/www/cobbler/repo_mirror/${name}-base/repodata /var/www/cobbler/ks_mirror/${name}/

tmp=`mktemp`
cat << EOF > $tmp
images/pxeboot/initrd.img
images/pxeboot/vmlinuz
EOF

wget \
--base=http://ftp.cica.es/fedora/linux/releases/19/Fedora/x86_64/os/ \
--input-file=${tmp} \
--timestamping \
--force-directories \
--no-host-directories \
--directory-prefix=/var/www/cobbler/ks_mirror/${name} \
--cut-dirs=7; rm -f $tmp

cobbler distro add \
--name ${name} \
--breed ${breed} \
--os-version ${version} \
--arch ${arch} \
--kernel /var/www/cobbler/ks_mirror/${name}/images/pxeboot/vmlinuz \
--initrd /var/www/cobbler/ks_mirror/${name}/images/pxeboot/initrd.img \
--ksmeta="tree=http://@@http_server@@/cblr/links/${name}"

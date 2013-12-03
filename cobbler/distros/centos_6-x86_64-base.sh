#!/bin/bash

#---------
# Define:
#---------

name='CentOS_6-x86_64'
arch='x86_64'
path='/var/www/cobbler/repo_mirror/CentOS_6-x86_64-base'
breed='redhat'
version='rhel6'
kickstart='/var/lib/cobbler/kickstarts/demo.ks'

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
images/install.img
images/pxeboot/initrd.img
images/pxeboot/vmlinuz
EOF

wget \
--base=http://mirror.centos.org/centos/6/os/x86_64/ \
--input-file=${tmp} \
--timestamping \
--force-directories \
--no-host-directories \
--directory-prefix=/var/www/cobbler/ks_mirror/${name} \
--cut-dirs=4; rm -f $tmp

cobbler distro add \
--name ${name} \
--breed ${breed} \
--os-version ${version} \
--arch ${arch} \
--kernel /var/www/cobbler/ks_mirror/${name}/images/pxeboot/vmlinuz \
--initrd /var/www/cobbler/ks_mirror/${name}/images/pxeboot/initrd.img \
--ksmeta="tree=http://@@http_server@@/cblr/links/${name}"

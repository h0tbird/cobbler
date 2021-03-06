#!/bin/bash

#---------
# Define:
#---------

name='CentOS_Hardware'
distro='CentOS_6-x86_64'
kickstart='/var/lib/cobbler/kickstarts/centos6.ks'
repos='CentOS_6-x86_64-base CentOS_6-x86_64-extras CentOS_6-x86_64-updates EPEL-el6-x86_64 EPEL_testing-el6-x86_64 puppetlabs-deps-el6-x86_64 puppetlabs-products-el6-x86_64'

#---------
# Create:
#---------

cobbler profile add \
--name ${name} \
--distro ${distro} \
--kickstart ${kickstart} \
--repos "${repos}"

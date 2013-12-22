#!/bin/bash

#---------
# Define:
#---------

name='RHEL_Hardware'
distro='RHEL7-x86_64'
kickstart='/var/lib/cobbler/kickstarts/demo.ks'
repos='RHEL7-x86_64-base'

#---------
# Create:
#---------

cobbler profile add \
--name ${name} \
--distro ${distro} \
--kickstart ${kickstart} \
--repos "${repos}"

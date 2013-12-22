#!/bin/bash

#---------
# Define:
#---------

name='RHEL_Virtual'
distro='RHEL7-x86_64'
kickstart='/var/lib/cobbler/kickstarts/rhel7.ks'
repos='RHEL7-x86_64-base'

#---------
# Create:
#---------

cobbler profile add \
--name ${name} \
--distro ${distro} \
--kickstart ${kickstart} \
--repos "${repos}"

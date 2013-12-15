#!/bin/bash

#---------
# Define:
#---------

name='Fedora_19-x86_64-updates'
arch='x86_64'
mirror='http://ftp.cica.es/fedora/linux/updates/19/x86_64/'

#---------
# Create:
#---------

cobbler repo add --name ${name} --arch ${arch} --mirror ${mirror}

#!/bin/bash

#---------
# Define:
#---------

name='Fedora_19-x86_64-base'
arch='x86_64'
mirror='http://ftp.cica.es/fedora/linux/releases/19/Fedora/x86_64/os/'

#---------
# Create:
#---------

cobbler repo add --name ${name} --arch ${arch} --mirror ${mirror}

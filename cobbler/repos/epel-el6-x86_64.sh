#!/bin/bash

#---------
# Define:
#---------

name='EPEL-el6-x86_64'
arch='x86_64'
mirror='http://mirrors.ircam.fr/pub/fedora/epel/6/x86_64/'

#---------
# Create:
#---------

cobbler repo add --name ${name} --arch ${arch} --mirror ${mirror}

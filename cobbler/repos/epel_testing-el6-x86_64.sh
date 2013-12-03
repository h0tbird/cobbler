#!/bin/bash

#---------
# Define:
#---------

name='EPEL_testing-el6-x86_64'
arch='x86_64'
mirror='http://mirrors.ircam.fr/pub/fedora/epel/testing/6/x86_64/'

#---------
# Create:
#---------

cobbler repo add --name ${name} --arch ${arch} --mirror ${mirror}

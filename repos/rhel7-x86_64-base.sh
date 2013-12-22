#!/bin/bash

#---------
# Define:
#---------

name='RHEL7-x86_64-base'
arch='x86_64'
mirror='http://ftp.redhat.com/pub/redhat/rhel/beta/7/x86_64/os/'

#---------
# Create:
#---------

cobbler repo add --name ${name} --arch ${arch} --mirror ${mirror}

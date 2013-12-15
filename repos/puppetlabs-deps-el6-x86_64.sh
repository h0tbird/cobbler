#!/bin/bash

#---------
# Define:
#---------

name='puppetlabs-deps-el6-x86_64'
arch='x86_64'
mirror='http://yum.puppetlabs.com/el/6/dependencies/x86_64'

#---------
# Create:
#---------

cobbler repo add --name ${name} --arch ${arch} --mirror ${mirror}

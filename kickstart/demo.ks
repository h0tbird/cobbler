#---------------
# Main section:
#---------------

text
install
$yum_repo_stanza
url --url=$tree
lang en_US.UTF-8
keyboard es
$SNIPPET('network_config')
rootpw password
firewall --disabled
authconfig --enableshadow --passalgo=sha512 --enablefingerprint
selinux --disabled
services --disabled auditd,fcoe,ip6tables,iptables,iscsi,iscsid,lldpad,netfs,nfslock,rpcbind,rpcgssd,rpcidmapd,udev-post,lvm2-monitor,postfix
services --enabled sshd
timezone --utc Europe/Andorra

#-------------
# Partitions:
#-------------

zerombr
bootloader --location=mbr --driveorder=vda,sda,hda --append="crashkernel=auto"
%include /tmp/part1-include
part /boot --fstype=ext4 --size 128
part pv.0 --grow --size=1
volgroup vg0 --pesize=4096 pv.0
%include /tmp/part2-include
reboot

#-------------------
# Packages section:
#-------------------

%packages --nobase
openssh-server
bridge-utils
wget
puppet
%end

#-------------------------------------------------------------------------------------
# Pre-installation script: Commands to run on the system immediately after the ks.cfg
# has been parsed:
#-------------------------------------------------------------------------------------

%pre
$SNIPPET('kickstart_start')
$SNIPPET('pre_install_network_config')
for i in /sys/block/[hsv]da; do d="\$(basename \$i)"; done
echo "clearpart --all --drives=\$d --initlabel" > /tmp/part1-include
echo "ignoredisk --only-use=\$d" >> /tmp/part1-include
[[ $is_virtual -eq 1 ]] \
&& echo "logvol / --fstype=ext4 --name=lv0 --vgname=vg0 --size=1 --grow" >> /tmp/part2-include \
|| echo "logvol / --fstype=ext4 --name=lv0 --vgname=vg0 --size=1 --grow --maxsize=4096" >> /tmp/part2-include
%end

#----------------------------------------------------------------------------------
# Post-installation script: Commands to run on the system once the installation is
# complete:
#----------------------------------------------------------------------------------

%post
puppet="[main]\n\
\n\
    confdir    = /etc/puppet\n\
    vardir     = /var/lib/puppet\n\
    logdir     = /var/log/puppet\n\
    rundir     = /var/run/puppet\n\
    ssldir     = \\$vardir/ssl\n\
    pluginsync = true\n\
\n\
[agent]\n\
\n\
    classfile     = \\$vardir/classes.txt\n\
    localconfig   = \\$vardir/localconfig\n\
    graphdir      = \\$vardir/state/graphs\n\
    graph         = true\n\
    factsignore   = .svn CVS .git *.markdown .*.swp\n\
    pluginsignore = .svn CVS .git *.markdown .*.swp\n\
\n\
[master]\n\
\n\
    modulepath = \\$confdir/modules:\\$confdir/roles\n\
"
sed -i 's/timeout=./timeout=0/' /boot/grub/grub.conf
echo "127.0.0.1 `hostname` `hostname -s` localhost.localdomain localhost" > /etc/hosts
echo "192.168.1.4 puppet" >> /etc/hosts
echo -e "\$puppet" > /etc/puppet/puppet.conf
$SNIPPET('post_install_network_config')
$SNIPPET('puppet_register_if_enabled')
$SNIPPET('kickstart_done')
%end

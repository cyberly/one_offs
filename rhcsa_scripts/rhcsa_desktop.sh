unset HISTFILE
echo $(openssl rand -base64 32) | passwd root --stdin
echo $(openssl rand -base64 32) | passwd student --stdin
sed -i 's/^SELINUX=.*/SELINUX=disabled' /etc/selinux/config
systemctl set-default multi-user.target
systemctl disable sshd.service
systemctl mask sshd.service
systemctl disable nfs-secure
systemctl mask nfs-secure
yum remove -y bash-completion chrony nfs-secure
mkdir /dank_memes
groupadd lol
groupadd moderators
rm -f /etc/yum.repos.d/*
systemctl reboot

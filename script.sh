#!/bin/bash

echo "Menu for installing virtualization like virtualbox and etc"
echo "=========================================================="
echo "1. Virtualbox (host)"
echo "2. VMware (host)"
echo "3. Installing VMware tools (Guest Tools)"
echo "4. Installing VirtualBox Guest Addtion (Guest Tools)"
echo "========================================================="

read -p "number = " ask

echo

if (( $ask == 1)); then

sudo apt-get update -y
sudo apt-get update -y
[ -f /var/run/reboot-required ]
sudo reboot -f
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | gpg --dearmor | sudo tee /usr/share/keyrings/virtualbox-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/virtualbox-archive-keyring.gpg] http://download.virtualbox.org/virtualbox/debian buster contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
sudo apt update
sudo apt install -y dkms
sudo apt install -y virtualbox virtualbox-ext-pack
echo "reference : https://www.kali.org/docs/virtualization/install-virtualbox-host/"
sleep 5
virtualbox

elif (( $ask == 2)); then

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt install -y build-essential linux-headers-$( uname -r ) vlan libaio1
[ -f /var/run/reboot-required ]
sudo reboot -f
sudo apt-get install -y curl
curl -L https://www.vmware.com/go/getworkstation-linux > ~/Downloads/vmware.bin
file Downloads/vmware.bin
ls -lah Downloads/vmware.bin
chmod +x ~/Downloads/vmware.bin
sudo ~/Downloads/vmware.bin
echo "reference : https://www.kali.org/docs/virtualization/install-vmware-host/"
sleep 5
vmware

elif (( $ask == 3)); then

echo "Reference = https://www.kali.org/docs/virtualization/install-vmware-guest-tools/"
sleep 5
sudo apt-get update
sudo apt install -y --reinstall open-vm-tools-desktop fuse
sudo reboot -g
echo "In the Kali Tweaks menu, select Virtualization, then Install additional packages and scripts for VMware. Congratulations, you now have two additional tools in your toolbox!"
sleep 6.5
kali-tweaks
sudo mount-shared-folders
echo "And with a bit of luck, checking /mnt/hgfs/ you should see your shared folders."
sudo restart-vm-tools

elif (( $ask == 4 )); then

echo "https://www.kali.org/docs/virtualization/install-virtualbox-guest-additions/"
sleep 5
sudo apt-get update
sudo apt install -y --reinstall virtualbox-guest-x11
sudo reboot -f

echo "for older version of Kali Linux , here is our previous guide"
echo "https://www.kali.org/docs/virtualization/install-virtualbox-guest-additions-legacy/"
sleep 5

else
  echo "Something Did it wrong"
  sleep 3
  exit
fi

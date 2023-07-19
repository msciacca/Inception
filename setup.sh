#!/bin/bash

DOMAIN="msciacca.42.fr"

RED="\e[91m"
GREEN="\e[92m"
YELLOW="\e[93m"
BLUE="\e[94m"
PURPLE="\e[95m"
CYAN="\e[96m"
BLANK="\e[0m"


echo -e $PURPLE "Updating system..." $BLANK
sudo apt update 2> /dev/null
sudo apt upgrade -y 2> /dev/null
echo -e $GREEN "Done." $BLANK

echo -e $PURPLE "Installing git, make and vim..."
sudo apt install -y git make vim 2> /dev/null
echo -e $GREEN "Done." $BLANK

echo -e $PURPLE "Installing vscode..."
sudo snap install --classic code 2> /dev/null
echo -e $GREEN "Done." $BLANK

echo -e $PURPLE "Installing filezilla..."
sudo snap install --edge filezilla 2> /dev/null
echo -e $GREEN "Done." $BLANK

if grep -q $DOMAIN /etc/hosts; then
	echo -e $PURPLE "Setting up $DOMAIN as localhost"
	sudo echo "127.0.0.1	$DOMAIN" >> /etc/hosts
	echo -e $GREEN "Done." $BLANK
fi

echo -e $PURPLE "Installing docker dependencies..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
echo -e $GREEN "Done."

echo -e $PURPLE "Downloading and adding docker gpg..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo -e $GREEN "Done."

echo -e $PURPLE "Installing docker..."
sudo apt-get remove docker.io docker-doc docker-compose podman-docker containerd runc
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg --insecure | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo -e $GREEN "Done."

echo -e $GREEN "Config completed. " $RED "Rebooting in 5 seconds..." $BLANK
sleep 5

sudo reboot

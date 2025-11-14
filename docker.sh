#!/bin/bash

 dnf -y install dnf-plugins-core
 dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
 dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
 
 systemctl enable --now docker
 systemctl start docker
 usermod -aG docker ec2-user

 growpart /dev/nvme0n1 4
 lvextend -L +20G /dev/RootVG/rootVol
 lvextend -L +10G /dev/RootVG/varVol

 xfs_growfs /
 xfs_growfs /var
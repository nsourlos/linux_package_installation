#!/bin/bash

yes| sudo apt update
yes| sudo apt install python3-pip 


wget https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh



bash Anaconda3-2022.05-Linux-x86_64.sh -b

source ~/.bashrc
export PATH="/${PWD%/*}/anaconda3/bin:$PATH"

echo "source ${PWD%/*}/anaconda3/bin/activate" >> ~/.bashrc
jupyter notebook --generate-config
sed -i 's/# c.NotebookApp.use_redirect_file = True/c.NotebookApp.use_redirect_file = False/' ${PWD%/*}/.jupyter/jupyter_notebook_config.py


yes| sudo apt install git 
yes| sudo apt install vim 
yes| sudo apt install tmux 

sudo apt-get update
yes| sudo apt-get install \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg \
      lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
yes| sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo groupadd docker
sudo usermod -aG docker $USER

kill -SIGKILL $PPID

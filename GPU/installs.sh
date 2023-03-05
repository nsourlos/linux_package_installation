#!/bin/bash

yes| sudo apt update
yes| sudo apt install python3-pip 


#Anaconda installation and path activation
wget https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh
bash Anaconda3-2022.10-Linux-x86_64.sh -b

source ~/.bashrc
export PATH="/${PWD%/*}/anaconda3/bin:$PATH"
echo "source ${PWD%/*}/anaconda3/bin/activate" >> ~/.bashrc


#https://stackoverflow.com/questions/71983770/just-updated-ubuntu-to-22-04-now-i-cant-open-jupyter-notebook
#https://stackoverflow.com/questions/70753768/jupyter-notebook-access-to-the-file-was-denied
#Correct error in jupyter which does not work
jupyter notebook --generate-config
sed -i 's/# c.NotebookApp.use_redirect_file = True/c.NotebookApp.use_redirect_file = False/' ${PWD%/*}/.jupyter/jupyter_notebook_config.py

rm /home/$USER/Desktop/Anaconda3-2022.10-Linux-x86_64.sh

#Github, VIM, and TMUX installations
yes| sudo apt install git 
yes| sudo apt install vim 
yes| sudo apt install tmux 

#Required for docker installation - https://docs.docker.com/engine/install/ubuntu/
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


#VS not recognize Conda packages
#https://stackoverflow.com/questions/56658553/module-not-found-error-in-vs-code-despite-the-fact-that-i-installed-it
#Install Visual Studio Code - https://phoenixnap.com/kb/install-vscode-ubuntu
sudo snap install --classic code

#Below needed for Tensorflow installation with pip (GPU version)
##https://stackoverflow.com/questions/13428910/how-to-set-the-environmental-variable-ld-library-path-in-linux
#https://www.tensorflow.org/install/pip
yes | conda install -c conda-forge cudatoolkit=11.2.2 cudnn=8.1.0

echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/' >> ~/.bashrc

#Find file 'prefs.js', copy it to Desktop to avoid permission issues, make changes there and copy it back
#Text is replaced with 'sed' as described in https://askubuntu.com/questions/20414/find-and-replace-text-within-a-file-using-commands
cp $(find . -name "prefs.js") /home/$USER/Desktop/moztmp
sed -i 's/dom.w3c_touch_events.enabled", 2/dom.w3c_touch_events.enabled", 1/g' /home/$USER/Desktop/moztmp
sudo cp /home/$USER/Desktop/moztmp $(find . -name "prefs.js")
rm /home/$USER/Desktop/moztmp

#An alternative of the above since we may have to first open firefox to create this path
#We changed to '/' in the find command to search all directories as stated in:
#https://stackoverflow.com/questions/24655436/how-can-i-find-a-file-directory-that-could-be-anywhere-on-linux-command-line
#https://support.mozilla.org/en-US/questions/994951#:~:text=acceleration%20is%20disabled.-,You%20can%20close%20Firefox%20through%20the%20Terminal%20if%20it%20refuses,a%20Mac%20user%20but%20that
#firefox &
#sleep 5
#kill -9 $(ps -x|grep firefox)

#cp $(sudo find / -name "prefs.js" | grep mozilla) /home/$USER/Desktop/
#sed -i 's/dom.w3c_touch_events.enabled", 2/dom.w3c_touch_events.enabled", 1/g' /home/$USER/Desktop/prefs.js
#sudo cp /home/$USER/Desktop/prefs.js $(sudo find / -name "prefs.js" | grep mozilla)

#For mozilla touch screen
cp /etc/security/pam_env.conf /home/$USER/Desktop/mozparams

#Append line at the end of file- https://www.cyberciti.biz/faq/linux-append-text-to-end-of-file/
echo 'MOZ_USE_XINPUT2 DEFAULT=1' >> /home/$USER/Desktop/mozparams
sudo cp /home/$USER/Desktop/mozparams /etc/security/pam_env.conf
rm /home/$USER/Desktop/mozparams

#For changing boot options when there are 2 OS - make Windows default and change timeout
#Information on how to do that can be found in https://linuxhint.com/change-grub-options/
cp /etc/default/grub /home/$USER/Desktop/tmp
sed -i 's/GRUB_DEFAULT=0/GRUB_DEFAULT=2/g' /home/$USER/Desktop/tmp
sed -i 's/GRUB_TIMEOUT=10/GRUB_TIMEOUT=5/g' /home/$USER/Desktop/tmp
sudo cp /home/$USER/Desktop/tmp /etc/default/grub

sudo update-grub

rm /home/$USER/Desktop/tmp

#Automatically close window
kill -SIGKILL $PPID

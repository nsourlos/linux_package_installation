# Linux Package Installation

![Alt text](./linux-package-installation.svg)

![Alt text](./made-with-shell.svg)
[![forthebadge](https://forthebadge.com/images/badges/uses-badges.svg)](https://forthebadge.com)

[![Maintenance](https://img.shields.io/badge/Maintained%3F-no-red.svg)]( https://github.com/nsourlos/linux_package_installation)


> The scripts on this repo can be used when **[Ubuntu OS](https://ubuntu.com/desktop)** is initialized and there are no packages installed. It installs some basic packages/tools automatically. They have been tested on Ubuntu 22.04

After cloning this repo, select the version that you want to install (CPU or GPU). The following two commands should be executed to install all the packages:

```bash
bash installs.sh 
```

```bash
pip install --no-cache -r requirements.txt 
```

The **[first script](/installs.sh)** is used to install packages that can�t be installed with `pip`. These packages are:
- Anaconda3 (To fix error of Jupyter notebook not working we also added some commands to edit its configuration file based on the information found [here](https://stackoverflow.com/questions/70753768/jupyter-notebook-access-to-the-file-was-denied) and more specific information (maybe not needed) [here](https://stackoverflow.com/questions/71983770/just-updated-ubuntu-to-22-04-now-i-cant-open-jupyter-notebook).
- Git
- Vim
- Tmux
- Docker


The **[second script](/requirements.txt)** is used to install `pip` packages, all at once. A list of all the packages/libraries that will be installed can be seen below:

- tensorflow 2.9.2
- pytorch 1.11 (CPU version only � for GPU some lines have to be modified according to the instructions found in the [official website](https://pytorch.org/get-started/locally/))
- pydicom 2.3.0
- OpenCV 4.6.0.66
- imutils 0.5.4
- graphviz 0.20.1
- nibabel 4.0.2
- MedPy 0.4.0


For the [GPU version](/GPU) the **[requirements script](/GPU/requirements.txt)** also contains GPU versions of [Tensorflow (2.9.0)](https://www.tensorflow.org/install/pip) and [PyTorch (1.10.1)](https://discuss.pytorch.org/t/runtimeerror-unexpected-error-from-cudagetdevicecount/139977/5). It installs cuda and cudnn toolkits. Moreover, the **[installs script](/GPU/installs.sh)** is updated and includes commands to enable mozilla touchscreen, install VisualStudio code, and change dual boot options when Ubuntu are installed along with Windows 10. If that is not the case, the script should be updated manually by the user. 


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
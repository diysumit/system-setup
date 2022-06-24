# **System Setup**
### Scripts to setup new systems for my workflow(Data Science and Google Cloud)
---
## **Setup.py**
#### I wrote this script primarily  to automate as much as possible when setting up a new Linux system for my work. If you have a WSL or bash shell installed, it will also run on Windows. Installs all the required Linux and Python packages and set up the Kaggle API and device configurations to use.
---

>Note: This works well on Gnome flavour of Manjaro[^1] and Pop!_OS[^2]. Anyone can use this script however you want to add the drive links for Kaggle API(otherwise it will not work) and zsh configuration file(I've terrible taste in terminal customization) and also note that most of the packages I have installed are data science related packages.

## **Manjaro**

git clone https://github.com/diysumit/system-setup  
cd system-setup/  
chmod +x setup.py  
./setup.py

---
## **Pop!_OS**

git clone https://github.com/diysumit/system-setup  
cd system-setup/   
chmod +x setup.py  
./setup.py

[^1]: I love Manjaro and it was the first Linux distribution that actually ran on my machine without a serious bottleneck. It was hard to configure and the learning curve was steep, but in the end it was very rewarding. Most of the work I do requires packages and libraries that Teams doesn't provide support on Arch-based systems, but they do support Ubuntu-based distributions, hence I had to switch to a Debian based distribution.
[^2]: I chose Pop!_OS as it was stable enough and Gnome DE that I had grown to love while using Manjaro worked well though not as well as on Manjaro.
#!/usr/bin/env bash
#* Setting up OS

#! Colors for enphasizing texts
RED='\033[0;31m'
GREEN="\033[2;32m"
BLUE='\033[1;34m'
NC='\033[0m' #! No Color
BOLD=$(tput bold)
NORM=$(tput sgr0)

#! distro_family
distro_family=$(cat /etc/os-release | grep "^ID_LIKE" | cut -b 9-30)

#! arch_packages
arch_packages=( git wget yajl python3 python-pip python-wheel code snapd telegram-desktop discord gnome-tweaks python-pip neofetch postgresql xclip xsel opencl-mesa puppet refind )

#! debian_packages
debian_packages=( python3 python-is-python3 git code snapd telegram-desktop discord gnome-tweaks python3-pip neofetch git-extras postgresql postgresql-contrib xclip xsel tensorman docker gnome-session puppet refind )

#! python_packages
python_packages=( google-compute-engine google-cloud-storage gcloud gsutil psutil gdown kaggle docker kubernetes jupyter notebook anaconda matplotlib plotly pandas sklearn scipy numpy keras bs4 scrapy seaborn theano pillow simpleitk requests selenium pytest apache-beam apache-beam[dataframe] apache-beam[gcp] apache-beam[interactive] apache-beam[test] apache-beam[docs] tensorflow torch dataprep apache-airflow tensorflow_transform modin pyspark )

#! Running different configurations for different distro_family
if [[ ! -z $distro_family ]]; then #! Checking empty variable
	#! arch linux
	if [[ $distro_family == *'arch'* ]]; then
		echo "==========================INSTALLING DEPENDENCIES=========================="
		#! enable AUR packages for pamac
		sudo sed -Ei 'EnableAUR/s/^#//' /etc/pamac.conf
            #! installing base-devel packages
		sudo pacman -Syyu --needed base-devel
            for package in ${arch_packages[@]} 
		do
            sudo pacman -Syyu $package
            done
		echo ""
		echo "=============================REMOVING UNINSTALLED============================="
		sudo pacman -Sc
		echo ""
		echo "==================================UNUSED PACKAGES=================================="
		sudo pacman -Qtdq
	#! debian linux
	elif [[ $distro_family == *'debian'* ]]; then
		echo ""
		echo "============================ADDING REPOSITORIES============================"
            #! adding repositories
            sudo apt-add-repository ppa:rodsmith/refind
		echo ""
		echo "============================UPDATING && UPGRADING============================"
            #! updating and upgrading
		sudo apt-get update && apt-get upgrade
		echo ""
		echo "==========================INSTALLING DEPENDENCIES=========================="
            #! installing build essential packages
		sudo apt-get install build-essential
            for package in ${debian_packages[@]} 
		do
            sudo apt-get install $package
            done
		#! adding tensorman to docker group
		sudo usermod -aG docker $USER
		#! adding kernal parameter 
		sudo kernelstub --add-options "systemd.unified_cgroup_hierarchy=0"
		echo ""
		echo "===================================HOUSE CLEANING==================================="
		sudo apt autoclean && apt-get autoremove
	fi
fi

function python_dependencies() {
	echo ""
	echo "==================================PYTHON DEPENDENCIES=================================="
	python3 -m pip install pip
	for package in ${python_packages[@]} 
	do
	pip install --upgrade $package
	done
	echo ""
	echo "================================REMOVING CACHED PACKAGES================================"
	pip cache purge
}

python_dependencies

#! installing oh-my-zsh
echo ""
echo "======================================SETTING UP OH-MY-ZSH======================================"
sudo apt-get install zsh
sudo sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
export PATH=$PATH:/home/$USER/.local/bin
gdown --fuzzy https://drive.google.com/file/d/1MVR3yxRAJ9Oq_msjA9kB9izlXM55LCZ2/view?usp=sharing -O $HOME/.zshrc
sed -i 's/diysumit/$USER/' $HOME/.zshrc
chsh -s $(which zsh) $(whoami)
echo -e "${RED}${BOLD}install zsh-autosuggestions: ${BLUE}git clone https://github.com/zsh-users/zsh-autosuggestions.git \$ZSH_CUSTOM/plugins/zsh-autosuggestions${NC}${NORM}"
echo -e "${RED}${BOLD}install zsh-syntax-highlighting: ${BLUE}git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \$ZSH_CUSTOM/plugins/zsh-syntax-highlighting${NC}${NORM}"

#! settting up kaggle api
mkdir -p $HOME/.kaggle
Kaggle_GDrive=""
gdown  --fuzzy $Kaggle_GDrive -O $HOME/.kaggle/
sudo chmod 600 $HOME/.kaggle/kaggle.json

#! installing nerd fonts
echo ""
echo "======================================INSTALLING NERD FONTS======================================"
git clone https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh
cd ..
rm -rv nerd-fonts

#! installing powerline font
echo ""
echo "======================================INSTALLING POWERLINE FONTS======================================"
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
cd ..
rm -rf fonts

echo -e "${GREEN}Login again for changes to take effect${NC}"
zsh
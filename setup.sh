# Setting up OS
distro_family=$(cat /etc/os-release | grep "^ID_LIKE" | cut -b 9-30)
if [[ ! -z $distro_family ]]; then
	if [[ $distro_family == *'arch'* ]]; then
		echo "==========================INSTALLING DEPENDENCIES=========================="
		# * enable AUR packages for pamac
		sudo sed -Ei 'EnableAUR/s/^#//' /etc/pamac.conf
		sudo pacman -Syyu --needed base-devel git wget yajl python3 code snapd telegram-desktop discord gnome-tweaks python-pip neofetch postgresql xclip xsel opencl-mesa opencl-amd opencl-legacy-amdgpu-pro rocm-opencl-runtime amdapp-sdk
		echo ""
		echo "=============================REMOVING UNINSTALLED============================="
		sudo pacman -Sc
		echo ""
		echo "==================================UNUSED PACKAGES=================================="
		sudo pacman -Qtdq
	elif [[ $distro_family == *'debian'* ]]; then
		echo ""
		echo "============================UPDATING && UPGRADING============================"
		sudo apt-get update && apt-get upgrade
		echo ""
		echo "==========================INSTALLING DEPENDENCIES=========================="
		sudo apt-get install build-essential python3 python-is-python3 git code snapd telegram-desktop discord gnome-tweaks python3-pip neofetch zsh git-extras postgresql postgresql-contrib xclip xsel tensorman docker gnome-session
		# * adding tensorman to docker group
		sudo usermod -aG docker $USER
		# * adding kernal parameter 
		sudo kernelstub --add-options "systemd.unified_cgroup_hierarchy=0"
		echo ""
		echo "===================================HOUSE CLEANING==================================="
		sudo apt autoclean && apt-get autoremove
	fi
fi

# * Installing python packages for my work
echo ""
echo "==================================PYTHON DEPENDENCIES=================================="
pip install --upgrade google-compute-engine google-cloud-storage matplotlib tensorflow sklearn plotly pandas pyspark numpy gcloud kaggle torch docker kubernetes jupyter notebook anaconda keras bs4 scipy scrapy seaborn theano mahotas pillow simpleitk requests selenium pytest gsutil psutil gdown

echo ""
echo "================================REMOVING CACHED PACKAGES================================"
pip cache purge

if [[ $distro_family == *"debian"* ]]; then
	# * installing oh-my-zsh
	echo "======================================SETTING UP OH-MY-ZSH======================================"
	sudo sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	export PATH=$PATH:/home/$USER/.local/bin
	gdown --fuzzy https://drive.google.com/file/d/1MVR3yxRAJ9Oq_msjA9kB9izlXM55LCZ2/view?usp=sharing -O $HOME/.zshrc
	sed -i 's/diysumit/$USER/' $HOME/.zshrc
	chsh -s $(which zsh) $(whoami)
	echo "use to install zsh-autosuggestions: git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions"
	echo "use to install zsh-syntax-highlighting: git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
	echo "gdown is not added to path, add /home/\$USER/.local/bin to path"
fi

# * settting up kaggle api
mkdir -p $HOME/.kaggle
gdown  --fuzzy https://drive.google.com/file/d/14kD-I5mmHLYG_DNXfzbn_851o8j8nD8W/view?usp=sharing -O $HOME/.kaggle/
sudo chmod 600 $HOME/.kaggle/kaggle.json

# * installing nerd fonts
echo "======================================INSTALLING NERD FONTS======================================"
git clone https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh
cd ..
rm -rv nerd-fonts

# * installing powerline font
echo "======================================INSTALLING POWERLINE FONTS======================================"
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
cd ..
rm -rf fonts

echo "Login again for changes to take effect"
zsh
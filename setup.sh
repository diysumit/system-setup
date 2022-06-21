# Setting up OS
distro_family=$(cat /etc/os-release | grep "^ID_LIKE" | cut -b 9-30)
if [[ ! -z $distro_family ]]; then
	if [[ $distro_family == *'arch'* ]]; then
		echo "==========================INSTALLING DEPENDENCIES=========================="
		sudo pacman -Syyu --needed base-devel git wget yajl python3 python-is-python3 code snapd telegram-desktop discord gnome-tweaks python3-pip
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
		sudo apt-get install build-essential python3 python-is-python3 git code snapd telegram-desktop discord gnome-tweaks python3-pip
		echo ""
		echo "===================================HOUSE CLEANING==================================="
		sudo apt autoclean && apt-get autoremove
	fi
fi

# Installing python packages for my work
echo ""
echo "==================================PYTHON DEPENDENCIES=================================="
pip install --upgrade google-compute-engine google-cloud-storage matplotlib tensorflow sklearn plotly pandas pyspark numpy gcloud kaggle torch docker kubernetes jupyter notebook anaconda keras bs4 scipy scrapy seaborn theano mahotas pillow simpleitk requests selenium pytest gsutil psutil

echo ""
echo "================================REMOVING CACHED PACKAGES================================"
pip cache purge

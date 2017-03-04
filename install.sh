#!/bin/bash

# Script to provide a one line install for a Sugarizer launcher for the Raspberry Pi.
# 
# Motivating use case:
# - To be able to provide consise and robust instructions for installing a basic
#   Raspberry Pi setup.
#   
# Usage:
# 
# curl -L https://github.com/punkbass/sugarizer-launcher/raw/master/install.sh | sh
# wget --no-delete-certificate https://github.com/punkbass/sugarizer-launcher/raw/master/install.sh -O - | sh

LAUNCHER_DIR="/opt/kano/sugarizer-launcher"

delete()
{  
	read key

	case $key in
	[yY][eE][sS]|[yY]|"")
		sudo rm -rf $1
		echo -e "\nDelete $1 complete!\n" 
	;;
	*)
	exit
	;;
	esac
}

#Update source-list of dependencies
echo -e "====================================\n"
echo -e "\n Updating source lists to download dependencies ... \n Please check your internet connection! \n"
echo -e "====================================\n"
sleep 2
sudo apt-get update 

if test -d $LAUNCHER_DIR;
then
  	echo  -e "\n[Sugarizer Launcher installer] It looks like you've already got the Sugarizer Launcher installed."
  	echo  -e "\n[Sugarizer Launcher installer] You'll need to remove $LAUNCHER_DIR to install."
  	echo  -e "\nWould you like to remove [Sugarizer Launcher installer] directory[Y/n]?"
	delete $LAUNCHER_DIR ;
fi

echo -e "[Sugarizer Launcher installer] Installing Chromium ..."
sudo apt-get -y install chromium-browser

echo  -e "\nInstalling git ...\n"
sudo apt-get -y install git

echo -e "\n[Sugarizer Launcher installer] Installing desktop icon."
sudo mkdir -p $LAUNCHER_DIR
sudo git clone git://github.com/punkbass/sugarizer-launcher.git $LAUNCHER_DIR
sudo cp $LAUNCHER_DIR/sugarizer.desktop /usr/share/applications

if test -e ~/Desktop/sugarizer.desktop; 
then
	echo -e "\n~/Desktop/sugarizer.desktop file has existes!\nDo you want to remove it[y/n]?"
	delete ~/Desktop/sugarizer.desktop;	
fi
	
sudo ln -s $LAUNCHER_DIR/sugarizer.desktop ~/Desktop/sugarizer.desktop
sudo chmod +x ~/Desktop/sugarizer.desktop
sudo chown $(whoami) ~/Desktop/sugarizer.desktop
sleep  2
echo -e "\nComplete!\n"

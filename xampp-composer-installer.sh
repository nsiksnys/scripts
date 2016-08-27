#!/bin/bash

##Composer for XAMPP
##This script installs Composer using php binaries provided with XAMPP. Requires sudo privileges.

install()
{
	echo -en "installer:\n"
	echo -en "\nDownloading installer in $INSTALLER \n"
	sudo wget -q https://getcomposer.org/installer -O $INSTALLER
	echo -en "\nInstalling...\n"
	cd $XAMPP_BIN
	sudo ./php composer-installer.php
}

uninstall()
{
	echo -en "uninstaller:\n"
	echo -en "\nRemoving composer.phar...\n"
	sudo rm $COMPOSER_BIN
	sudo rm -r "$HOME/.composer"
}

DOWNLOAD_FOLDER="/opt/lampp/bin"
INSTALLER="$DOWNLOAD_FOLDER/composer-installer.php"
XAMPP_BIN="/opt/lampp/bin"
COMPOSER_BIN="$XAMPP_BIN/composer.phar"

echo -en "Composer for XAMPP "

if [ "$1" = "install" ]
then
	install
elif [ "$1" = "uninstall" ]
then
	uninstall
else
	echo -en "Error! Options are install or uninstall.\n"
fi
exit

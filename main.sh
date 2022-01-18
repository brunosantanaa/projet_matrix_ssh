#!/bin/bash
# Script: cksum.sh
# Author: Bruno de Santana | Kevin Clovel | Mario Camelo
# Date: 24/01/2022
# Description: 
#	Script Projet from Linux Class Matrix College.
#
#
#
###
#Variables
PWD=$(pwd)
SRC+=$PWD/src
DATA+=$PWD/data
fileName=fichierTransfer.txt
logFile=$DATA/script.log

CKSUM=""

serverUser=matrix1serveur
IP=192.168.56.103

###
# Function to VIEW Menu
show_menu(){
	clear
	echo " =========================================="
	echo "|                                          |"
	echo "|                                          |"
	echo "| *** Projet - Introdution au Linux ***    |"
	echo "|                                          |"
	echo "| Équipe 1:                                |"
	echo "|  - Bruno de Santana                      |"
	echo "|  - Kevin Clovel                          |"
	echo "|  - Mario Camelo                          |"
	echo "|                                          |"
	echo " ------------------------------------------"
	echo " =========================================="
	echo "|             *** MENU ***                 |"
	echo " ------------------------------------------"
	echo "|                                          |"
	echo "| 1. Create File                           |"
	echo "| 2. Validate File                         |"
	echo "| 3. Create CKSum                          |"
	echo "| 4. Transfer File                         |"
	echo "| 5. Verifier le Transfer                  |"
	echo "| 6. View Log                              |"
	echo "| 7. Exit                                  |"
	echo "|                                          |"
	echo " ------------------------------------------"
	echo " =========================================="
}

wait(){
	read -p "Enter to cont..." READ
}

# Function to read keyboard from user
read_option(){
 local option
 read -p "| Option (1-6) --------------------> " option
 case $option in
  1) 
		$SRC/create_file.sh $logFile $fileName | tee -a $logFile
		wait;;
  2) 
		$SRC/validate.sh $logFile $fileName | tee -a $logFile
		wait ;;
  3) 
		$SRC/cksum.sh 0 $fileName > CHECKSUM | tee -a $logFile
		wait ;;
  4) 
		$SRC/send.sh $logFile $serverUser $IP $fileName | tee -a $logFile
		wait ;;
	5)
		$SRC/cksum.sh 1 $fileName $CKSUM $serverUser $IP | tee -a $logFile
		wait ;;
  6) viewLog ;;
  7) sortir ;;
  *) echo ERROR ;;
esac

}

###
#Function to visualise log
viewLog(){
	echo "---> View log: "$logFile | tee -a $logFile
	cat $logFile 
	wait
}
###
#Function to exit the program
sortir(){
	echo "---> Exiting..." | tee -a $logFile
	clear
	exit 1
}

################
#Run the program
while true
do
 show_menu
 read_option
done

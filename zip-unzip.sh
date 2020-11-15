#!/bin/sh

R=$( tput setaf 1 )
G=$( tput setaf 2 )


echo ''
echo -e $R "press 1$G to zip a file or directory"
echo " "
echo -e $R "press 2$G to unzip a zip file"
echo " "
echo -e $R " "
read -p "zip/unzip: $G" user_what
echo " "
case $user_what in
  1)  clear;
      echo " ";
      echo -e "enter the name or path you want to zip";
      echo -e $R " ";
      read -p "zip: $G" user_zip;
      echo " ";
      echo "what do you want the zip file's name to be?";
      echo " ";
      echo "include .zip when naming";
      echo -e $R " ";
      read -p "name: $G" user_name;
      echo " ";
      echo "is this a directory?";
      echo -e $R " "
      read -p "y/n $G" user_d;
      if [ $user_d == y ]
      then
        zip -r $user_name $user_zip
      else
        zip $user_name $user_zip
      fi
      echo " ";;
  2)  echo " ";
      echo " ";
      echo "enter the zip file's name or path to unzip";
      echo -e $R" ";
      read -p "unzip: $G" user_unzip;
      echo " ";
      unzip $user_unzip;;
  *)  echo "error...";
      exit;;
esac
echo ' '
sleep 2

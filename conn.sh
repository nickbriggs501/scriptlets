#!/bin/sh

R=$( tput setaf 1 )
Y=$( tput setaf 3 )

clear
echo $R"SSH Connect "
echo " "
read -p "user:$Y " user_name
echo $R" "
read -p "ip:$Y " user_ip
echo " "
clear
echo " "
echo $Y"connecting..."
echo " "
ssh $user_name@$user_ip
echo " "

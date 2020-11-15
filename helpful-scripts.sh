#!/bin/sh
IP=$( ip addr show dev wlan0 | sed -e's/^.*inet \([^ ]*\)\/.*$/\1/;t;d' )
FOUND=`grep "eth0:\|wlan0" /proc/net/dev`
D=$( date '+%A %B %d, %Y' )
T=$( date '+%r ' )
R=$( tput setaf 1 )
G=$( tput setaf 2 )
Y=$( tput setaf 3 )

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
echo " "
echo $R "x) exit"
echo $R" "
read -p "option:$G " user_opt
echo " "
if [ $user_opt == x ]
then
  exit
fi
if [ $user_opt == 1 ]
then
  clear
  echo " "
  echo "this script will convert text file img" 
  echo " "
  echo "enter file name or path"
  echo " "
  read -p "file: " user_file
  sed -i -e 's/^/echo -e $(tput setaf 2)"/; s/$/"/' $user_file
  sed -i -e '1i#!/bin/sh\' $user_file
  echo " "
  echo "done"
  sleep 3
fi
if [ $user_opt == 2 ]
then
  clear
  echo " "
  echo "this script will replace words in a file"
  echo " "
  read -p "file to edit: " user_edit
  echo " "
  read -p "find and replace: " search
  echo " "
  read -p "replace with: " replace
  echo " "
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
  echo " "
  echo "enter the target file's extention before the .part"
  echo " "
  echo "example; .mp4 .mp3 .mpeg .avi"
  echo " "
  read -p "target file ext: $(tput setaf 1)." user_ext
  for f in *.part; do
      mv -- "$f" "${f%.$user_ext.part}.$user_ext"                                         done
  done
  echo " "
  echo "done"
  sleep 3
fi
if [ $user_opt == 4 ]
then
  clear
  echo " "
  echo "warning"
  echo " "
  echo "this will convert all dir from current"
  echo " "
  echo "contine? y/n "
  echo " "
  read -p "proceed: " user_go
  if [ $user_go == y ]
  then
    for i in */; do zip -r "${i%/}.zip" "$i"; done
    for f in *.zip; do
        mv -- "$f" "${f%.zip}.watch"
    done
    echo " "
    echo "done"
    sleep 3
  fi
  if [ $user_go == n ]
  then
    exit
  fi
fi
if [ $user_opt == 5 ]
then
  clear
  echo " "
  echo "to send a file over ssh you must know the following"
  echo "ip address, username, password of the device to send to"
  echo "as well as the paths to the file and its destination"
  echo " "
  read -p "continue?: " user_ready
  if [ $user_ready == y ]
  then
    clear
    echo " "
    echo "enter the ip address of target"
    echo " "
    read -p "ip: " user_ip
    clear
    echo " "
    echo "enter the username of target device"
    echo " "
    read -p "username: " user_name
    clear
    echo " "
    echo "enter the path of the file to send"
    echo " "
    read -p "path: " user_file
    clear
    echo " "
    echo "enter destination path from HOME"
    echo " "
    read -p "destination: " user_dest
    clear
    scp $user_file $user_name@$user_ip:$user_dest
    echo " "
    echo "done"
    sleep 3
  fi
  if [ $user_ready == n ]
  then
    exit
  fi
fi
if [ $user_opt == 6 ]
then
  clear
  echo " "
  echo "add shebang to what file?"               echo ' '
  read -p "file: " F
  sed -i -e '1i#!/bin/sh\' $F
  echo " "
  echo "done"
  sleep 3
fi
if [ $user_opt == 7 ]
then
  clear
  echo " "
  echo "this will unhide all files in dir"
  echo " "
  read -p "proceed? y/n " user_pro
  if [ $user_pro == y ]
  then
    for file in .*; do mv "$file" "${file#.}";done;
    clear
    echo " "
    echo "done"
    sleep 3
  fi
  if [ $user_pro == n ]
  then
    exit
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
  echo " "
  echo "done"
  sleep 3
fi
if [ $user_opt == 9 ]
then
  clear
  echo " "
  echo "add this file to the end of another"
  echo " "
  read -p "file: " file1
  echo " "
  echo "add to this file"
  echo " "
  read -p "file: " file2
  cat $file1 >> $file2
  echo " "
  echo "done"
  sleep 3
fi
if [ $user_opt == 10 ]
then
  clear
  echo " "
  echo "add this text"
  echo " "
  read -p "insert: " text
  echo " "
  echo "to this file"
  echo " "
  read -p "file: " filez
  echo " "
  sed '$ a\ > $text' $filez
  echo " "
  echo "done"
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
  while true; do
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
    exit
  fi
  done
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
  echo "move all files of this type"
  echo " "
  echo "example .zip .mpg .mp3"
  echo " "
  read -p "file extention: " file_ex
  echo " "
  echo "to this location"
  echo " "
  read -p "destination: " user_de
  echo " "
  mv *$file_ex $user_de
  echo " "
  echo "done"
  sleep 3
fi
if [ $user_opt == 14 ]
then
  clear
  echo " "
  echo "enter passwd hash file name below"
  echo " "
  read -p "file: " user_hash
  hashcat -m 5600 $user_hash -o cracked.txt -a 3 ?l?l?l?l?l?l?l?l
  echo " "
  echo "cracked file info saved tp cracked.txt"
  sleep 3
fi

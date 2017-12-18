#!/bin/bash

function create_structure() {
    cd ~
    mkdir -p "share/Data/Network Mapping/Internal/Eyewitness/"
    mkdir -p "share/Data/Network Mapping/Internal/Nmap/"
    mkdir -p "share/Data/Network Mapping/External/Eyewitness/"
    mkdir -p "share/Data/Network Mapping/External/Nmap/"
    mkdir -p "share/Data/Network Mapping/External/OSINT"
    mkdir -p "share/Data/Vulnerability Scanning/External/Nessus/"
    mkdir -p "share/Data/Vulnerability Scanning/External/Nikto/"
    mkdir -p "share/Data/Vulnerability Scanning/Internal/Nessus/"
    mkdir -p "share/Data/Vulnerability Scanning/Internal/Nikto/"
    mkdir -p "share/Data/Web Application/External/BurpSuite/"
    mkdir -p "share/Data/Web Application/Internal/BurpSuite/"
    mkdir -p "share/Data/Phishing/Targets/"
    mkdir -p "share/Data/Phishing/Templates/"
    mkdir -p "share/Data/Phishing/Payloads/OLE/"
    mkdir -p "share/Data/Phishing/Payloads/HTA/"
    mkdir -p "share/Findings/Technical Overview/Attack Path/"
    mkdir -p "share/Findings/Technical Overview/Phishing"
    mkdir -p "share/Findings/Internal/"
    mkdir -p "share/Findings/External/"
    mkdir -p "share/Working/"
    mkdir -p "share/Documentation/"
    cd ~/share/Findings/
    echo $'Affected Systems(comma delimited):\n{xxx.xxx.xxx.xxx, xxx.xxx.xxx.xxx}\n\nService/Services (comma delimited):\n{i.e. Penetration Testing (must match services catalog)}\n\nCustomer Specific Finding Description (one line): \n{Description of the finding with text unique to this RVA, if necessary}\n\nCustomer Specific Recommendation (one line):\n{Recommendation with text unique to this RVA, if necessary}\n\nScreenshot Description ("This screenshot shows...")\n{This screenshot shows a group of penguins having fun on the beach.}\n\nHVA Specific: {If this finding is HVA specific then replace this text with the HVA name (must match the HVA folder name in the "Attack Path" folder)}' > details.txt
}

function client_zip_structure() {
    read -p "[ ] Enter the username for the account who owns the share:  " -r username
    read -p "[ ] Who is the client?:  " -r clientname
    su $username
    path=$( cd ~;pwd )
    cd ~
    zip -r "${clientname}-CLIENT.zip" share/ --exclude "share/Working/*" > /dev/null 2>&1
    echo "Your zip file is stored in the path: ${path}"
    exit
}

function team_zip_structure() {
    read -p "[ ] Enter the username for the account who owns the share:  " -r username
    read -p "[ ] Enter your company name (without spaces):  " -r mycompany
    read -p "[ ] Who is the client?:  " -r clientname
    su $username
    path=$( cd ~;pwd )
    cd ~
    zip -r "${clientname}-For${mycompany}Use.zip" share/ > /dev/null 2>&1
    echo "Your zip file is stored in the path: ${path}"
    exit	
}

echo "#######################################"
PS3="Server Setup Script - Pick an option: "
options=("Create Structure" "Zip Structure for Client" "Zip Struture for Archiving")
select opt in "${options[@]}" "Quit"; do

    case "$REPLY" in
    #Prep
    1) create_structure;;
    
    2) client_zip_structure;;
    
    3) team_zip_structure;;
    
    $(( ${#options[@]}+1 )) ) echo "L8r"; break;;
    *) echo "Invalid option. Try another one.";continue;;
    
    esac

done

#!/bin/bash
# Function to check if given command exist !!
is_Command_Exist(){
 local arg="$1"
 type "$arg" &> /dev/null
 return $?
}
is_Exist(){
 local arg="$1"
 dpkg -l | grep "$arg" &> /dev/null
 return $?
}
is_folder(){
 local arg="$1"
 cd "$arg"
 ls -lrt &> /dev/null
 return $?
}
# Install Function
install_package(){
 local arg="$1"
 sudo apt install "$arg"
}
# Check Java exist or not?
if is_Command_Exist "java"; then
 echo "Java is installed in this ubuntu"
else
 echo "Java is not installed"
 install_package "openjdk-8-jdk";
fi
# Check Maven exist or not?
if is_Command_Exist "mvn"; then
 echo "Maven is installed in this ubuntu"
else
 echo "mvn is not installed"
 install_package "mvn";
fi
# check xvfb exist or not?
if is_Exist "xvfb"; then
 echo "XVFB is installed in this ubuntu"
else
 echo "XVFB is not installed"
 install_package "xvfb";
 Xvfb:99&
 export DISPLAY=:99
fi
# check Chrome exist or not?
if is_folder "/opt/google/chrome"; then
 echo "Chrome is installed in this ubuntu"
else
 echo "Chrome is not installed"
 wget http://mirror.cs.uchicago.edu/google-chrome/pool/main/g/google-chrome-stable/googlechrome-stable_114.0.5735.198-1_amd64.deb
 sudo dpk -i google-chrome-stable_114.0.5735.198-1_amd64.deb
 sudo apt --fix-broken install
fi

cd ~
cd webdriver-tests/
mvn clean test

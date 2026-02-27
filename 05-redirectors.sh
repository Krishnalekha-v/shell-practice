#!/bin/bash

#store the date in log files
# /var/log/shell-script/05-redirectors.sh-<timestamp>.log
logs_folder="/var/log/shell-script"
script_name=$(echo $0 | cut -d "." -f1)
timestamp=$(date+ %Y-%m-%d-%H-%M-%s)
log_file="$logs_folder/$script_name-$timestamp.log"
mkdir -p $logs_folder

userid=$(id -u)
R="\e[32m"
g="\e[31m"
n="\e[0m"
y="\e[33m"

check_root(){
    if [ $? -ne 0 ]
    then 
    echo -e "$R please run this script with root privileges $n" | tee -a $log_file
    exit 1
    fi
}

validate()
{
    if [ $? -ne 0 ]
    then 
    echo -e "$2 is ..$r failed $n" | tee -a $log_file
    exit 1
    else 
    echo -e "$2 is .. $g success $n" | tee -a $log_file
    fi
}

usage(){
    echo -e "$R usage: : $n sudo sh 05-redirectors.sh package1 package2..."
    exit 1
}
echo " script started execution at: $(date)" | tee -a $log_file
check_root
if [ $# -eq 0 ]
then 
usage
fi
for package in $@
do 
dnf list installed $package
if [ $? -ne 0 ]
then echo "$package not installed.. going to install it" | tee -a $log_file
dnf install $package -y &>> $log_file
validate $? " installing $package"
else
echo "$package is already installed" | tee -a $log_file
fi
done 
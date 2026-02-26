#!/bin/bash

USERID=$(id -u)
R="\e[32m"
g="\e[31m"
n="\e[0m"

check_root(){
    if [ $USERID -ne 0 ]
    then 
    echo "please run this script with root privileges"
    exit 1
    fi
}
validate()
{
    if [ $? -ne 0 ]
    then 
    echo -e "$2 is ..$r failed $n"
    exit 1
    else 
    echo -e "$2 is .. $g success $n"
    fi
}
check root 

for package in $@
do 
dnf list installed $package
if [ $? -ne 0 ]
then echo "$package not installed.. going to install it"
dnf install $package -y
validate $? " installing $package"
else
echo "$package is already installed"
done 
#echo "user id is: $USERID"

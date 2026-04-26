#!/bin/bash

get_salt() {
	cut -d $ -f 3 "$1"
}

check_master_password() {
	echo "Checking master password..."
	password_hash=$(cat data/.MASTER)
	password_salt=$(get_salt data/.MASTER)
	echo -n "Enter password: "
	read -s pw
	check_hash=$(openssl passwd -6 -salt $password_salt $pw)
	while [[ ! $check_hash = $password_hash ]]
	do
		echo "Incorrect password."
		echo -n "Enter password: "
		read -s pw
		check_hash=$(openssl passwd -6 -salt $password_salt $pw)
	done
	MASTER_PASSWORD=$pw
}

create_master_password() {
	echo "Creating master password..."
	echo -n "Enter the password: "
	read -s pw1
	echo -n "Confirm the password: "
	read -s pw2
	while [[ ! $pw1 = $pw2 ]]
	do
		echo "Passwords don't match."
		echo -n "Enter the password: "
		read -s pw1
		echo -n "Confirm the password: "
		read -s pw2
	done
	MASTER_PASSWORD=$pw1
	openssl passwd -6 -salt $(openssl rand -base64 16) $MASTER_PASSWORD > data/.MASTER
	echo "Master password created."
}

initialize() {
	if [ -f "data/.MASTER" ]
	then
		check_master_password
	else
		create_master_password
	fi
}

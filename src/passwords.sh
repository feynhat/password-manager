#!/bin/bash

generate_password() {
	openssl rand -base64 24
}

encrypt_password() {
	echo $2 | openssl enc -aes-256-cbc -pbkdf2 -iter 64000 -a -k $1
}

new_password() {
	while :
	do
		echo -n "Enter account name ('q' to exit to main menu): "
		read account_name
		if [[ "$account_name" = "q" ]]
		then
			return 1
		fi
		if [ -f data/passwords/$account_name ]
		then
			echo -n "Account $account_name already exists. Would you like to overwrite it? (y/n) "
			read resp
			if [[ ! $resp = "y" ]]
			then
				echo "Not overwriting the password for $account_name."
				continue
			fi
		fi
		echo -n "Creating a new password for $account_name. Confirm (y/n): "
		read resp
		if [[ $resp = "y" ]]
		then
			new_password="$(generate_password)"
			#echo New password to encrypt $new_password
			encrypt_password "$1" "$new_password" > ./data/passwords/$account_name
			echo "Created new password for $account_name."
		fi
	done
}

decrypt_password() {
	#echo "decrypt_password (master password: $1, encrypted_password: $2)"
	echo "$2" | openssl enc -d -aes-256-cbc -pbkdf2 -iter 64000 -a -k $1
}

display_password() {
	echo ""
	echo $1
	echo ""
	echo -n "Are you done viewing the password (press enter): "
	read resp
	clear
}

retrieve_password() {
	if [ -z "$(ls data/passwords)" ]
	then
		echo "There are no saved passwords."
		return 1
	fi
	while :
	do
		echo -n "Enter account name ('q' to exit to main menu): "
		read account_name
		if [[ "$account_name" = "q" ]]
		then
			return 1
		fi
		if [ -f data/passwords/$account_name ]
		then
			encrypted_password="$(cat data/passwords/$account_name)"
			decrypted_password="$(decrypt_password "$1" "$encrypted_password")"
			display_password "$decrypted_password"
		else
			echo -n "No saved password for $account_name. Exit to main menu? (y/n) "
			read resp
			if [[ $resp = "y" ]]
			then
				return 1
			fi
		fi
	done
}

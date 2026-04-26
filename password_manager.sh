#!/bin/bash

source src/initialize.sh
source src/utils.sh
source src/passwords.sh

show_menu() {
	echo ""
	echo "--------------------------------------------------------------------------------"
	echo "Password Manager Menu"
	echo "--------------------------------------------------------------------------------"
	echo "1. Add new password"
	echo "2. Get password"
	echo "3. List accounts" 
	echo "4. Exit"
	echo "--------------------------------------------------------------------------------"
	echo -n "Choose an option: "
}

main() {
	initialize
	while :
	do
		show_menu
		read resp;
		case $resp in
			1)
				new_password "$MASTER_PASSWORD"
				;;
			2)
				retrieve_password "$MASTER_PASSWORD"
				;;
			3)
				list_accounts
				;;
			4)
				echo "Exiting."
				exit 0
				;;
			*)
				echo "Invalid option."
				;;
		esac
	done
}

#You may choose to later inlcude arguments to main.
main "$@"

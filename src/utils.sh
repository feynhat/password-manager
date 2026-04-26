#!/bin/bash

list_accounts() {
	if [ -z "$(ls data/passwords/)" ]
	then
		echo "No saved passwords."
		return 1
	fi
	ls -1 data/passwords
}

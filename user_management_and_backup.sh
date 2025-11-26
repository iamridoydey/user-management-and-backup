#!/bin/bash
##########################################################################
# Author: Ridoy Dey
# Description: This script is for create, delete and update of user. It 
# 	       can also create, delete the group and add the user to the
# 	       the group as well as has a backup option.
##########################################################################

### User management scripts
# Add a new user
add_user(){
	read -p "Enter user's username: " username
	sudo useradd "$username"
	echo "Successfully added $username"
}

# Delete a user
delete_user(){
	read -p "Enter user's username: " username
	if id "$username" &> /dev/null; then
		sudo userdel -r "$username"
		echo "Successfully deleted $username"
		sudo rm -rf "/home/$username"
		echo "Deleted /home/$username directory"
	else
		echo "$username doesn't exist"
	fi
}

update_user(){
	read -p "Enter user's username: " username
	read -p "Enter new shell (e.g., /bin/bash): " shell
	sudo usermod -s "$shell" "$username" && echo "$username shell updated"
}


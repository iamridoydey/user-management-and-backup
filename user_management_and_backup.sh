#!/bin/bash
##########################################################################
# Author: Ridoy Dey
# Description: User management script for creating, deleting, updating
#              users, managing groups, and backups.
# Version: 1.0
##########################################################################

### User management scripts

# List of user
all_user(){
	awk -F: '$3 >= 1000 {print $1}' /etc/passwd
}

# Add a new user
add_user(){
	read -p "Enter user's username: " username
	sudo useradd -m "$username"
	echo "Successfully added $username"
}

# Delete a user
delete_user(){
	read -p "Enter user's username: " username
	# Prevent deletion of default user
	if [[ "$username" == "$USER" ]]; then
		echo "Cannot delete your own account: $USER"
		return 1;
	fi

	# Deletion of other users
	if id "$username" &> /dev/null; then
		sudo userdel -r "$username"
		echo "Successfully deleted $username"
	else
		echo "$username doesn't exist"
	fi
}

update_user_shell(){
	read -p "Enter user's username: " username
	if ! id "$username" &> /dev/null; then
		echo "User $username doesn't exist"
	fi
	read -p "Enter new shell (e.g., /bin/bash): " shell
	sudo usermod -s "$shell" "$username" && echo "$username shell updated"
}


### Group management scripts
# List of group
all_group(){
	awk -F: '$3 >= 1000 {print $1}' /etc/group
}


# Add  a new group
add_group() {
	read -p "Enter group name: " groupname
	sudo groupadd "$groupname"
	echo "Successfully added group $groupname"
}


# Add user to a group
add_user_to_group() {
	read -p "Enter user's username: " username
	if id "$username" &> /dev/null; then
		read -p "Enter group name: " groupname

		# Check whether the group exist
		if ! getent group $groupname &> /dev/null; then
			echo "Group $groupname doesn't exist! Add a group first"
			return 1
		fi
		# Else create group
		sudo usermod -aG "$groupname" "$username"
		echo "Added $username to group $groupname successfully"
	else
		echo "$username doesn't exist"
	fi
}

# Delete a group
delete_group() {
	read -p "Enter group name: " groupname
	if getent group "$groupname" &> /dev/null; then
		sudo groupdel "$groupname"
		echo "Successfully deleted group $groupname"
	else
		echo "Group $groupname doesn't exist"
	fi
}

# Delete user from a group
remove_user_from_group() {
	read -p "Enter user's username: " username
	if ! id "$username" &> /dev/null; then
		echo "User $username doesn't exist"
		return 1
	fi

	read -p "Enter user's groupname: " groupname
	if ! getent group "$groupname" &> /dev/null; then
		echo "Group $groupname doesn't exist"
		return 1;
	fi

	# Delete the user
	sudo gpasswd -d "$username" "$groupname"
	echo "$username successfully deleted from $groupname"
}


# User backup data
backup_user() {
	read -p "Enter user's username: " username

	# Check if user exists
	if ! id "$username" &> /dev/null; then
		echo "User $username doesn't exist"
		return 1
	fi

	# Check if user directory exists
	userdir="/home/$username"
	if [[ ! -d $userdir ]]; then
		echo "User directory $userdir not found"
		return 1
	fi

	# Create backup directory if not exists
	backupdir="/var/backup"
	sudo mkdir -p "$backupdir"

	# Timestamp backup file
	backupfile="$backupdir/${username}_$(date +%F_%H-%M-%S).tar.gz"

	# Perform backup
	sudo tar -czf "$backupfile" "$userdir"
	echo "Backup of $username created at $backupfile"
}




# Menu system
while true; do
	echo "================================="
	echo " User & Group Management Menu    "
	echo "================================="
	echo "1) All user"
	echo "2) Add user"
	echo "3) Delete user"
	echo "4) Update user shell"
	echo "5) All group"
	echo "6) Add group"
	echo "7) delete group"
	echo "8) Add user to group"
	echo "9) Remove user from group"
	echo "10) Backup user"
	echo "11) Exit"
	echo "================================="
	read -p "Choose an option [1-11]: " choice

	case $choice in
		1) all_user ;;
		2) add_user ;;
		3) delete_user ;;
		4) update_user_shell ;;
		5) all_group ;;
		6) add_group ;;
		7) delete_group ;;
		8) add_user_to_group ;;
		9) remove_user_from_group ;;
		10) backup_user ;;
		11) echo "Exiting..."; break ;;
		*) echo "Invalid option, try again." ;;
	esac
done
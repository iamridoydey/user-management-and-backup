# 🐧 Linux User & Group Management with Backup Automation

## 📌 Project Description
This project provides a **menu-driven shell script** to automate common **user management, group management, and backup tasks** in a Linux environment.  
The primary goal is to enable efficient management of user accounts and secure backup of specified directories.  

Learners will apply their knowledge of:
- Linux commands
- Shell scripting
- GitHub version control

to develop, maintain, and share their script.

---

## ⚙️ Features
- **User Management**
  - List all non-system users
  - Add new users with home directories
  - Delete users safely (prevents deleting the current logged-in user)
  - Update user login shell

- **Group Management**
  - List all non-system groups
  - Create new groups
  - Delete existing groups
  - Add users to groups
  - Remove users from groups

- **Backup Management**
  - Create compressed, timestamped backups of user home directories
  - Store backups in `/var/backup` (auto-created if missing)

- **Interactive Menu**
  - Simple text-based menu for navigation
  - Options numbered for ease of use
  - Continuous loop until user chooses to exit

---

## 🛠️ Prerequisites
- Linux system with `bash` installed
- **sudo privileges** (required for user/group modifications and backups)
- Essential commands available:
  - `useradd`, `userdel`, `usermod`, `groupadd`, `groupdel`, `gpasswd`
  - `awk`, `tar`, `mkdir`, `getent`

---

## 🚀 Usage Instructions

### 1. Clone or Download
```bash
git clone <repository-url>
cd <repository-folder>

# Deploy a Database Server with Backup Automation

-   Automate the deployment, configuration, and backup of a PostgreSQL database server on an Ubuntu instance hosted on AWS using Ansible.

## Problem Statement

-   The goal is to automate the following tasks:
    -   Deploy and configure a PostgreSQL database server on an AWS Ubuntu instance.
    -   Create a database and a user with specific permissions.
    -   Set up a cron job for regular database backups and ensure that backups are stored in a specified directory.
    -   Use Ansible for configuration management, including handling sensitive data like database passwords.


### Ansible Inventory File
```
[db]
x.xxx.xxx.xxx ansible_user=ubuntu ansible_ssh_private_key_file=/home/einfochips/day17/ansible-new.pem
```
Defines the AWS Ubuntu instance and connection details for Ansible.

### Ansible Playbook deploy_database.yml
```
- name: setup Mysql with database db and
  remote login
  become: yes
  hosts: worker-node-01

  vars_files: 
    - vars.yml
  
  tasks:
    - name: Installing Mysql  and dependencies
      package:
       name: "{{item}}"
       state: present
       update_cache: yes
      loop:
       - mysql-server
       - mysql-client 
       - python3-mysqldb
       - libmysqlclient-dev
      become: yes

    - name: start and enable mysql service
      service:
        name: mysql
        state: started
        enabled: yes

    - name: creating mysql user
      mysql_user:
        name: "{{db_user}}"
        password: "{{db_pass}}"
        priv: '*.*:ALL'
        host: '%'
        state: present

    - name: creating database
      mysql_db:
        name: "{{db_name}}"
        state: present

    - name: Enable remote login to mysql
      lineinfile:
         path: /etc/mysql/mysql.conf.d/mysqld.cnf
         regexp: '^bind-address'
         line: 'bind-address = 0.0.0.0'
         backup: yes
      notify:
         - Restart mysql 

    - name: Create Backup Directory
      file: 
        path: /var/backups/mysql
        state: directory

    - name: Create Backup Script
      copy:
        src: scripts/backup.sh
        dest: ~/
        mode: 0755

    - name: Create a cron job
      cron:
        name: "MySQL Backup"
        minute: "2"
        hour: "0"
        job: "~/backup.sh"  

  handlers:
    - name: Restart mysql
      service:
        name: mysql
        state: restarted
```
Automates the installation of PostgreSQL, sets up the database, creates a user, and configures a cron job for backups. It also includes variables for database configuration and backup settings.

![alt text](<project1/Screenshot from 2024-08-01 17-36-20.png>)

### Backup Script

```
#!/bin/bash

DB_NAME="db"
DB_USER="user"
DB_PASSWORD="pass"
BACKUP_DIR="/var/backups/mysql"

DATE=$(date +\%F_\%T)

# Perform the backup
mysqldump -u $DB_USER -p$DB_PASSWORD $DB_NAME > $BACKUP_DIR/backup_$DATE.sql
```
A script to perform the backup of the PostgreSQL database. This script should be referenced in the cron job defined in the playbook.
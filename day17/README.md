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
- name: setup Mysql
  hosts: db
  become: yes
  vars:
    db_name: "my_database"
    db_user: "my_user"
    db_password: "user123"
    backup_dir: "/backup/mysql"
    backup_schedule: "daily"

  tasks:
  - name: Install MySQL server
    apt:
      update_cache: yes
      name: "{{ item }}"
      state: present
    with_items:
    - mysql-server
    - mysql-client
    - python3-mysqldb
    - libmysqlclient-dev

  - name: Copy MySQL configuration file
    template:
      src: /home/einfochips/day17/project1/templates/mysql.cnf.j2
      dest: /etc/mysql/mysql.conf.d/mysqld.cnf
    notify: Restart MySQL

  - name: Ensure MySQL service is running and enabled
    service:
      name: mysql
      state: started
      enabled: yes

  - name: Create MySQL user
    mysql_user:
      name: "{{ db_user }}"
      password: "{{ db_password }}"
      priv: '*.*:ALL'
      host: '%'
      state: present

  - name: Create MySQL database
    mysql_db:
      name: "{{ db_name }}"
      state: present

  - name: Configure backup directory
    file:
      path: "{{ backup_dir }}"
      state: directory
      mode: '0755'

  - name: Copy MySQL backup script
    copy:
      src: /home/einfochips/day17/project1/scripts/backup.sh
      dest: /usr/local/bin/mysql_backup.sh
      mode: '0755'

  - name: Configure backup cron job
    cron:
      name: "mysql backup"
      minute: "0"
      hour: "2"
      day: "*"
      month: "*"
      weekday: "*"
      job: "/usr/local/bin/mysql_backup.sh"
      state: present


  handlers:
  - name: Restart MySQL
    service:
      name: mysql
      state: restarted
```
Automates the installation of PostgreSQL, sets up the database, creates a user, and configures a cron job for backups. It also includes variables for database configuration and backup settings.

![alt text](<project1/Screenshot from 2024-08-01 17-36-20.png>)

### Backup Script

```
#!/bin/bash

# Set variables
DATABASE_NAME=mydatabase
BACKUP_DIR=/var/backups/mysql
DATE=$(date +"%Y-%m-%d")

# Create backup file name
BACKUP_FILE="${BACKUP_DIR}/${DATABASE_NAME}_${DATE}.sql"

# Dump database to backup file
mysqldump -u myuser -p${database_password} ${DATABASE_NAME} > ${BACKUP_FILE}

# Compress backup file
gzip ${BACKUP_FILE}

# Remove old backups (keep only 7 days)
find ${BACKUP_DIR} -type f -mtime +7 -delete
```
A script to perform the backup of the PostgreSQL database. This script should be referenced in the cron job defined in the playbook.
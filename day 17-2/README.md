# Project 02: Automate the Setup of a Multi-Tier Web Application Stack
## Objective

Automate the deployment and configuration of a multi-tier web application stack using Ansible. This includes setting up separate database and application servers and ensuring the application is deployed and configured to connect to the database.
## Problem Statement

-   The goal is to automate the following tasks:

    -   Set up a PostgreSQL database server on one Ubuntu instance.
    -   Set up a web server (e.g., Apache or Nginx) on another Ubuntu instance to host a web application.
    -   Ensure the web application is deployed on the application server and is configured to connect to the PostgreSQL database on the database server.
    -   Use Ansible to automate the configuration of both servers, including the initialization of the database and the deployment of the web application.

## Deliverables

### 1. Ansible Inventory File

#### Filename: inventory.ini

-   Defines the database server and application server instances, including their IP addresses and connection details.

```
[database]
db_server-01 ansible_host=x.xxx.xxx.xxx ansible_user=ubuntu ansible_ssh_private_key_file=/home/einfochips/day17/ansible-new.pem

[app]
app-server-01 ansible_host=x.xxx.xxx.xxx  ansible_user=ubuntu ansible_ssh_private_key_file=/home/einfochips/day17/ansible-new.pem
```

-   To verify we will ping both the server using following ad-hoc command
```
ansible all -i inventory.ini -m ping
```
![alt text](<project2/Screenshot from 2024-08-01 17-49-06.png>)
### 2. Ansible Playbook

#### Filename: playbook.yml

-   Automates the deployment and configuration of the PostgreSQL database server, the setup and configuration of the web server, and the deployment of the web application with its configuration to connect to the database.

```
- name: Setting application server
  hosts: app
  become: yes

  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present

    - name: Start and enable Nginx service
      systemd:
        name: nginx
        state: started
        enabled: yes

    - name: Copy application files
      copy:
        src: files/index.html
        dest: /var/www/html/index.html

  handlers:
    - name: Reload Nginx
      service:
        name: nginx
        state: reloaded
# -----------------------------------------------------
- name: setup Mysql and remote login
  become: yes
  hosts: database

  vars: 
    db_user: user
    db_pass: pass
    db_name: my_db
  
  tasks:
    - name: Installing Mysql 
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
# -----------------------------------------------------
- name: Connecting Webserver with database
  hosts: app
  become: yes
  tasks:
    - name: Configure application
      template:
        src: templates/app_config.php.j2
        dest: /var/www/html/app_config.php
```
-   Run the Ansible Playbook
```
ansible-playbook -i inventory.ini deploy_multitier_stack.yml
```

![alt text](<project2/Screenshot from 2024-08-01 19-28-17.png>)

### 3. Jinja2 Template
#### Filename: templates/app_config.php.j2
-   Defines a configuration file for the web application that includes placeholders for dynamic values such as database connection details.

```
<?php
$db_host = "db_host";
$db_name = "my_db";
$db_user = "user";
$db_pass = "pass";

$conn = new mysqli($db_host, $db_user, $db_pass, $db_name);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

echo "Connected successfully";
?>
```

### 4. Application Files

#### Filename: files/index.html
-   Static or basic dynamic content served by the web application.

![alt text](<project2/Screenshot from 2024-08-01 19-28-34.png>)